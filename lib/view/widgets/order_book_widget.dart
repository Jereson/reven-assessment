import 'package:flutter/material.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/image_util.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';
import 'package:raven_assessment/view/widgets/random_widget.dart';

class OrderbookWidget extends StatelessWidget {
  const OrderbookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kcPrimaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              flagImage(imgFlag1, true),
              const SizedBox(width: 5),
              flagImage(imgFlag1),
              const SizedBox(width: 5),
              flagImage(imgFlag1),
              const Spacer(),
              Container(
                width: 63,
                height: 32,
                decoration: BoxDecoration(
                    color: kc353945, borderRadius: BorderRadius.circular(4)),
                child: PopupMenuButton<String>(
                    icon: Row(
                      children: [
                        const Text(
                          '10',
                          style: stFFFFFF50012,
                        ),
                        const Spacer(),
                        Transform.translate(
                          offset: const Offset(2, -3),
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: kc777E90,
                          ),
                        ),
                      ],
                    ),
                    itemBuilder: (BuildContext context) => numbers
                        .map(
                          (e) => PopupMenuItem<String>(
                            // onTap: () => tVm.selectTransactionType(e),
                            // value: tVm.selectedTxnType,
                            child: Text(
                              e.pairs,
                              style: stFFFFFF50018.copyWith(color: kcBlack),
                            ),
                          ),
                        )
                        .toList()),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price\n(USDT)', style: stA7B1BC50012),
              Text(
                'Amounts\n(BTC)   ',
                style: stA7B1BC50012,
                textAlign: TextAlign.end,
              ),
              Text('Total', style: stA7B1BC50012),
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0.903945',
                          style: stA7B1BC50012.copyWith(color: kcFF6838)),
                      const Text('0.903945', style: stFFFFFF50012),
                      const Text('0.903945', style: stFFFFFF50012),
                    ],
                  ),
                );
              }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '0.83884  ',
                style: stFFFFFF70016.copyWith(color: kc25C26E),
              ),
              const Icon(
                Icons.arrow_upward,
                color: kc25C26E,
                size: 10,
              ),
              const Text('  0.83884', style: stFFFFFF70016),
            ],
          ),
          const SizedBox(height: 14),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0.903945',
                          style: stA7B1BC50012.copyWith(color: kc25C26E)),
                      const Text('0.903945', style: stFFFFFF50012),
                      const Text('0.903945', style: stFFFFFF50012),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}

List numbers = ['10', '20', '30'];
