import 'dart:async';
import 'dart:convert';

import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:http/http.dart' as http;
import 'package:raven_assessment/main.dart';
import 'package:raven_assessment/viewModel/base_view_model.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class TokenViewModel extends BaseViewModel {
  String timeInterval = '1m';
  bool isChartTab = true;
  List<Candle> candles = [];
  bool themeIsDark = false;

  List<Order> bids = [];
  List<Order> asks = [];
  final StreamController<List<Order>> bidsController =
      StreamController.broadcast();
  final StreamController<List<Order>> asksController =
      StreamController.broadcast();
  final WebSocketChannel channel2 = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@depth'));

  WebSocketChannel channel() {
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(
        'wss://stream.binance.com:9443/ws/btcusdt@kline_$timeInterval'));
    return channel;
  }

  final StreamController<List<Candle>> candlesController =
      StreamController.broadcast();

  initializeCandle() {
    fetchCandles().then((value) {
      candles = value;
      candlesController.add(candles);
    });

    getCandles().listen((updatedCandles) {
      candles = updatedCandles;
      candlesController.add(candles);
    });
  }

  Future<List<Candle>> fetchCandles() async { //btcusdt
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=$timeInterval");
    final res = await http.get(uri);
    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Stream<List<Candle>> getCandles() async* {
    await for (var event in channel().stream) {
      final data = json.decode(event);
      final kline = data['k'];

      Candle newCandle = Candle(
          date: DateTime.fromMillisecondsSinceEpoch(kline['t']),
          high: double.parse(kline['h']),
          low: double.parse(kline['l']),
          open: double.parse(kline['o']),
          close: double.parse(kline['c']),
          volume: double.parse(kline['q']));

      if (kline['x']) {
        print('Candle closed');
        candles.add(newCandle);
        // if (candles.length > 100) {
        //   candles.removeAt(0);
        // }
      } else {
        print('Candle in process');
        if (candles.isNotEmpty && candles.last.date == newCandle.date) {
          candles[candles.length - 1] = newCandle;
        } else {
          candles.add(newCandle);
        }
      }

      // print(candles);
      yield candles;
    }
  }

  onPageReload() {
    candles.addAll(candles.sublist(0, 100));
    candlesController.add(candles);
    setState();
  }

  disposeTokenValue() {
    channel().sink.close(status.normalClosure);
    candlesController.close();
  }

  selectTimeInterval(String time) async {
    timeInterval = time;
    await initializeCandle();
    setState();
  }

  toggleChartTab(bool tab) {
    isChartTab = tab;
    setState();
  }

  initiaLizeFecchOrderBook() {
    fetchOrderBook().then((value) {
      bids = value['bids']!;
      asks = value['asks']!;

      bidsController.add(bids);
      asksController.add(asks);

      // setState();
    });

    channel2.stream.listen((event) {
      final data = json.decode(event);
      final List<dynamic> newBids = data['b'];
      final List<dynamic> newAsks = data['a'];

      // Update bids
      for (var order in newBids) {
        double price = double.parse(order[0]);
        double quantity = double.parse(order[1]);
        double total = price * quantity;
        if (quantity == 0) {
          bids.removeWhere((o) => o.price == price);
        } else {
          int index = bids.indexWhere((o) => o.price == price);
          if (index == -1) {
            bids.add(Order(price, quantity, total));
          } else {
            bids[index] = Order(price, quantity, total);
          }
        }
      }

      // Update asks
      for (var order in newAsks) {
        double price = double.parse(order[0]);
        double quantity = double.parse(order[1]);
        double total = price * quantity;
        if (quantity == 0) {
          asks.removeWhere((o) => o.price == price);
        } else {
          int index = asks.indexWhere((o) => o.price == price);
          if (index == -1) {
            asks.add(Order(price, quantity, total));
          } else {
            asks[index] = Order(price, quantity, total);
          }
        }
      }

      // Sort order book
      bids.sort((a, b) => b.price.compareTo(a.price));
      asks.sort((a, b) => a.price.compareTo(b.price));

      // Update controllers
      bidsController.add(bids);
      asksController.add(asks);
    });

    // setState();
  }

  Future<Map<String, List<Order>>> fetchOrderBook() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/depth?symbol=BTCUSDT&limit=100");
    final res = await http.get(uri);
    final data = jsonDecode(res.body);

    List<Order> bids = (data['bids'] as List<dynamic>)
        .map((e) => Order(double.parse(e[0]), double.parse(e[1]),
            double.parse(e[0]) * double.parse(e[1])))
        .toList();

    List<Order> asks = (data['asks'] as List<dynamic>)
        .map((e) => Order(double.parse(e[0]), double.parse(e[1]),
            double.parse(e[0]) * double.parse(e[1])))
        .toList();

    return {'bids': bids, 'asks': asks};
  }

  disposeOrderBookData() {
    channel2.sink.close(status.normalClosure);
    bidsController.close();
    asksController.close();
  }
}
