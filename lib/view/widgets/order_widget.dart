import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';
import 'package:raven_assessment/view/widgets/custom_button.dart';
import 'package:raven_assessment/view/widgets/show_order_modal.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: kcPrimaryColor, border: Border.all(color: kc262932)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('No Open Orders', style: stFFFFFF70018),
                const SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                  style: stFFFFFF70014.copyWith(color: kcA7B1BC, height: 1.8),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CustomOrderButton(
                title: 'Buy',
                bgColor: kc25C26E,
                callback: () {
                  print('object!');
                  ShowOrderModal(context);
                },
              ),
              const Spacer(),
              CustomOrderButton(
                title: 'Sell',
                bgColor: kcFF554A,
                callback: () {},
              )
            ],
          ),
        )
      ],
    );
  }
}

List<String> orderTabText = ['Open Orders', 'Positions', 'Order History'];
