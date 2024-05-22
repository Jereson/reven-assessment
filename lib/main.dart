import 'package:flutter/material.dart';
import 'package:raven_assessment/getit.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItGetUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          fontFamily: 'Satoshi',
          primaryColor: kcPrimaryColor,
          primarySwatch: const MaterialColor(0xFF02136B, <int, Color>{
            50: kcPrimaryColor, //10%
            100: kcPrimaryColor, //20%
            200: kcPrimaryColor, //30%
            300: kcPrimaryColor, //40%
            400: kcPrimaryColor, //50%
            500: kcPrimaryColor, //60%
            600: kcPrimaryColor, //70%
            700: kcPrimaryColor, //80%
            800: kcPrimaryColor, //90%
            900: kcPrimaryColor, //100%
          })),
      title: 'Reven Assessment',
      home: const HomeScreen(),
    );
  }
}

// import 'dart:async';
// import 'dart:convert';

// import 'package:candlesticks_plus/candlesticks_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:web_socket_channel/status.dart' as status;
// import 'package:web_socket_channel/web_socket_channel.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Candle> candles = [];
//   bool themeIsDark = false;
//   final WebSocketChannel channel = WebSocketChannel.connect(
//       Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@kline_1m'));
//   final StreamController<List<Candle>> _candlesController =
//       StreamController.broadcast();

//   @override
//   void initState() {
//     super.initState();
//     fetchCandles().then((value) {
//       candles = value;
//       _candlesController.add(candles);
//     });

//     getCandles().listen((updatedCandles) {
//       candles = updatedCandles;
//       _candlesController.add(candles);
//     });
//   }

//   @override
//   void dispose() {
//     channel.sink.close(status.normalClosure);
//     _candlesController.close();
//     super.dispose();
//   }

//   Future<List<Candle>> fetchCandles() async {
//     final uri = Uri.parse(
//         "https://api.binance.com/api/v3/klines?symbol=BNBUSDT&interval=1m");
//     final res = await http.get(uri);
//     return (jsonDecode(res.body) as List<dynamic>)
//         .map((e) => Candle.fromJson(e))
//         .toList()
//         .reversed
//         .toList();
//   }

//   Stream<List<Candle>> getCandles() async* {
//     await for (var event in channel.stream) {
//       final data = json.decode(event);
//       final kline = data['k'];

//       Candle newCandle = Candle(
//           date: DateTime.fromMillisecondsSinceEpoch(kline['t']),
//           high: double.parse(kline['h']),
//           low: double.parse(kline['l']),
//           open: double.parse(kline['o']),
//           close: double.parse(kline['c']),
//           volume: double.parse(kline['q']));

//       if (kline['x']) {
//         print('Candle closed');
//         candles.add(newCandle);
//         // if (candles.length > 100) {
//         //   candles.removeAt(0);
//         // }
//       } else {
//         print('Candle in process');
//         if (candles.isNotEmpty && candles.last.date == newCandle.date) {
//           candles[candles.length - 1] = newCandle;
//         } else {
//           candles.add(newCandle);
//         }
//       }

//       print(candles);
//       yield candles;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: themeIsDark ? ThemeData.dark() : ThemeData.light(),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: StreamBuilder<List<Candle>>(
//             stream: _candlesController.stream,
//             builder: (context, snapshot) {
//               return Text(snapshot.hasData && snapshot.data!.isNotEmpty
//                   ? snapshot.data!.last.open.toString()
//                   : 'Loading...');
//             },
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   themeIsDark = !themeIsDark;
//                 });
//               },
//               icon: Icon(
//                 themeIsDark
//                     ? Icons.wb_sunny_sharp
//                     : Icons.nightlight_round_outlined,
//               ),
//             )
//           ],
//         ),
//         body: Center(
//           child: StreamBuilder<List<Candle>>(
//             stream: _candlesController.stream,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Text('No data available');
//               } else {
//                 return Candlesticks(
//                   showToolbar: true,
//                   candles: snapshot.data!,
//                   watermark: 'Matinex',
//                   onLoadMoreCandles: () async {
//                     // Handle loading more candles if needed
//                     setState(() {
//                       candles.addAll(candles.sublist(0, 100));
//                       _candlesController.add(candles);
//                     });
//                   },
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


















// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:web_socket_channel/status.dart' as status;
// import 'package:web_socket_channel/web_socket_channel.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Order> bids = [];
//   List<Order> asks = [];
//   final StreamController<List<Order>> _bidsController =
//       StreamController.broadcast();
//   final StreamController<List<Order>> _asksController =
//       StreamController.broadcast();
//   final WebSocketChannel channel = WebSocketChannel.connect(
//       Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@depth'));

//   @override
//   void initState() {
//     super.initState();
//     fetchOrderBook().then((value) {
//       setState(() {
//         bids = value['bids']!;
//         asks = value['asks']!;
//       });
//       _bidsController.add(bids);
//       _asksController.add(asks);
//     });

//     channel.stream.listen((event) {
//       final data = json.decode(event);
//       final List<dynamic> newBids = data['b'];
//       final List<dynamic> newAsks = data['a'];

//       setState(() {
//         // Update bids
//         for (var order in newBids) {
//           double price = double.parse(order[0]);
//           double quantity = double.parse(order[1]);
//           double total = price * quantity;
//           if (quantity == 0) {
//             bids.removeWhere((o) => o.price == price);
//           } else {
//             int index = bids.indexWhere((o) => o.price == price);
//             if (index == -1) {
//               bids.add(Order(price, quantity, total));
//             } else {
//               bids[index] = Order(price, quantity, total);
//             }
//           }
//         }

//         // Update asks
//         for (var order in newAsks) {
//           double price = double.parse(order[0]);
//           double quantity = double.parse(order[1]);
//           double total = price * quantity;
//           if (quantity == 0) {
//             asks.removeWhere((o) => o.price == price);
//           } else {
//             int index = asks.indexWhere((o) => o.price == price);
//             if (index == -1) {
//               asks.add(Order(price, quantity, total));
//             } else {
//               asks[index] = Order(price, quantity, total);
//             }
//           }
//         }

//         // Sort order book
//         bids.sort((a, b) => b.price.compareTo(a.price));
//         asks.sort((a, b) => a.price.compareTo(b.price));

//         // Update controllers
//         _bidsController.add(bids);
//         _asksController.add(asks);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     channel.sink.close(status.normalClosure);
//     _bidsController.close();
//     _asksController.close();
//     super.dispose();
//   }

//   Future<Map<String, List<Order>>> fetchOrderBook() async {
//     final uri = Uri.parse(
//         "https://api.binance.com/api/v3/depth?symbol=BTCUSDT&limit=100");
//     final res = await http.get(uri);
//     final data = jsonDecode(res.body);

//     List<Order> bids = (data['bids'] as List<dynamic>)
//         .map((e) => Order(double.parse(e[0]), double.parse(e[1]),
//             double.parse(e[0]) * double.parse(e[1])))
//         .toList();

//     List<Order> asks = (data['asks'] as List<dynamic>)
//         .map((e) => Order(double.parse(e[0]), double.parse(e[1]),
//             double.parse(e[0]) * double.parse(e[1])))
//         .toList();

//     return {'bids': bids, 'asks': asks};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.light(),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Order Book'),
//         ),
//         body: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   const Text('Bids',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   Expanded(
//                     child: StreamBuilder<List<Order>>(
//                       stream: _bidsController.stream,
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         }
//                         return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             Order order = snapshot.data![index];
//                             return ListTile(
//                               title: Text(order.price.toStringAsFixed(2)),
//                               subtitle: Text(order.quantity.toStringAsFixed(6)),
//                               trailing: Text(order.total.toStringAsFixed(2)),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   const Text('Asks',
//                       style: TextStyle(fontWeight: FontWeight.bold)),
//                   Expanded(
//                     child: StreamBuilder<List<Order>>(
//                       stream: _asksController.stream,
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         }
//                         return ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (context, index) {
//                             Order order = snapshot.data![index];
//                             return ListTile(
//                               title: Text(order.price.toStringAsFixed(2)),
//                               subtitle: Text(order.quantity.toStringAsFixed(6)),
//                               trailing: Text(order.total.toStringAsFixed(2)),
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Order {
//   final double price;
//   final double quantity;
//   final double total;

//   Order(this.price, this.quantity, this.total);
// }

// // title for the price.
// // subtitle for the quantity.
// // trailing for the total.
