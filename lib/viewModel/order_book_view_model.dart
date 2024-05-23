import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:raven_assessment/model/order_model.dart';
import 'package:raven_assessment/utilities/const_utils.dart';
import 'package:raven_assessment/viewModel/base_view_model.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class OrderBookViewModel extends BaseViewModel {
  List<OrderModel> bids = [];
  List<OrderModel> asks = [];
  final StreamController<List<OrderModel>> bidsController =
      StreamController.broadcast();
  final StreamController<List<OrderModel>> asksController =
      StreamController.broadcast();
  final WebSocketChannel channel2 = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@depth'));

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
            bids.add(OrderModel(price, quantity, total));
          } else {
            bids[index] = OrderModel(price, quantity, total);
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
            asks.add(OrderModel(price, quantity, total));
          } else {
            asks[index] = OrderModel(price, quantity, total);
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

  // Future<Map<String, List<OrderModel>>> fetchOrderBook() async {
  //   final uri = Uri.parse(
  //       "https://api.binance.com/api/v3/depth?symbol=BTCUSDT&limit=100");
  //   final res = await http.get(uri);
  //   final data = jsonDecode(res.body);

  //   List<OrderModel> bids = (data['bids'] as List<dynamic>)
  //       .map((e) => OrderModel(double.parse(e[0]), double.parse(e[1]),
  //           double.parse(e[0]) * double.parse(e[1])))
  //       .toList();

  //   List<OrderModel> asks = (data['asks'] as List<dynamic>)
  //       .map((e) => OrderModel(double.parse(e[0]), double.parse(e[1]),
  //           double.parse(e[0]) * double.parse(e[1])))
  //       .toList();

  //   return {'bids': bids, 'asks': asks};
  // }

  Future<Map<String, List<OrderModel>>> fetchOrderBook() async {
    try {
      final uri = Uri.parse(
          "$baseUrl/depth?symbol=BTCUSDT&limit=100");
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        List<OrderModel> bids = (data['bids'] as List<dynamic>)
            .map((e) => OrderModel(double.parse(e[0]), double.parse(e[1]),
                double.parse(e[0]) * double.parse(e[1])))
            .toList();

        List<OrderModel> asks = (data['asks'] as List<dynamic>)
            .map((e) => OrderModel(double.parse(e[0]), double.parse(e[1]),
                double.parse(e[0]) * double.parse(e[1])))
            .toList();

        return {'bids': bids, 'asks': asks};
      } else {
        throw Exception('Failed to load order book: ${res.statusCode}');
      }
    } catch (e) {
      return Future.error('Error fetching order book: $e');
    }
  }


  disposeOrderBookData() {
    channel2.sink.close(status.normalClosure);
    bidsController.close();
    asksController.close();
  }
}
