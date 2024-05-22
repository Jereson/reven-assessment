import 'package:flutter/material.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/view/widgets/app_bar_widget.dart';
import 'package:raven_assessment/view/widgets/chart_widget.dart';
import 'package:raven_assessment/view/widgets/custom_button.dart';
import 'package:raven_assessment/view/widgets/order_book_widget.dart';
import 'package:raven_assessment/view/widgets/order_widget.dart';
import 'package:raven_assessment/view/widgets/token_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(''),
      backgroundColor: kc1C2127,
      body: ListView(
        shrinkWrap: true,
        children: [
          const TokenWidget(),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kcPrimaryColor,
              border: Border.all(color: kc262932, width: 0.5),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: kc1C2127,
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(
                        // bottom: BorderSide(color: kc262932, width: 0.5),
                        left: BorderSide(color: kc262932, width: 0.5),
                        right: BorderSide(color: kc262932, width: 0.5),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChartButton(
                        title: 'Charts',
                        callback: () {},
                        isActive: true,
                      ),
                      ChartButton(
                        title: 'Orderbook',
                        callback: () {},
                      ),
                      ChartButton(
                        title: 'Recent trades',
                        callback: () {},
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 20),
              ],
            ),
          ),
          // const SizedBox(height: 8),
          const ChartWidget(),
          // const OrderbookWidget(),
          const OrderWidget()
        ],
      ),
    );
  }
}
