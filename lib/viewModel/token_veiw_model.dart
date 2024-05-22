import 'dart:async';
import 'dart:convert';

import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:http/http.dart' as http;
import 'package:raven_assessment/viewModel/base_view_model.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class TokenViewModel extends BaseViewModel {
  String timeInterval = '1m';
  List<Candle> candles = [];
  bool themeIsDark = false;

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

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BNBUSDT&interval=$timeInterval");
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

  selectTimeInterval(String time ) async {
  
    timeInterval = time;
    await initializeCandle();
    setState();
  }
}
