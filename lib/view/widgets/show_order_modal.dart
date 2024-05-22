import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/form_style_utils.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';
import 'package:raven_assessment/view/widgets/custom_button.dart';

class ShowOrderModal extends StatefulWidget {
  ShowOrderModal(BuildContext context, {super.key}) {
    showCupertinoModalBottomSheet(context: context, builder: (context) => this);
  }

  @override
  State<ShowOrderModal> createState() => _ShowOrderModalState();
}

class _ShowOrderModalState extends State<ShowOrderModal> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(24),
        color: kc20252B,
        height: 700,
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: kcBlack.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabRow('Buy', 0),
                  tabRow('Sell', 1),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 600,
              child: PageView(
                onPageChanged: (page) {
                  setState(() => currentIndex = page);
                },
                controller: pageController,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  color: kc353945,
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Text(
                                'Limit',
                                style: stFFFFFF70014,
                              ),
                            ),
                            const Text(
                              'Limit',
                              style: stA7B1BC50014,
                            ),
                            const Text(
                              'Stop-Limit',
                              style: stA7B1BC50014,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        textAlign: TextAlign.end,
                        style: stA7B1BC50012,
                        decoration: borderInputDecoration.copyWith(
                            hintText: '0.00',
                            suffixIcon: Container(
                                width: 5,
                                alignment: Alignment.centerRight,
                                child:
                                    const Text('USD  ', style: stA7B1BC50012)),
                            prefixIcon: const SizedBox(
                              width: 30,
                              child: Row(
                                children: [
                                  Text('  Limt ', style: stA7B1BC50012),
                                  Icon(Icons.info_outline,
                                      color: kcA7B1BC, size: 10)
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        textAlign: TextAlign.end,
                        style: stA7B1BC50012,
                        decoration: borderInputDecoration.copyWith(
                            hintText: '0.00',
                            suffixIcon: Container(
                                width: 5,
                                alignment: Alignment.centerRight,
                                child:
                                    const Text('USD  ', style: stA7B1BC50012)),
                            prefixIcon: const SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  Text('  Amount ', style: stA7B1BC50012),
                                  Icon(Icons.info_outline,
                                      color: kcA7B1BC, size: 10)
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        textAlign: TextAlign.end,
                        style: stA7B1BC50012,
                        decoration: borderInputDecoration.copyWith(
                            hintText: 'Good till cancelled',
                            suffixIcon: const SizedBox(
                              width: 1,
                              // alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: kc777E90,
                                // size: 12,
                              ),
                            ),
                            prefixIcon: const SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  Text('  Amount ', style: stA7B1BC50012),
                                  Icon(Icons.info_outline,
                                      color: kcA7B1BC, size: 10)
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(height: 14),
                      Transform.translate(
                        offset: const Offset(-10, 0),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.check_box_outline_blank_outlined,
                                  color: kc373B3F,
                                )),
                            const Text('Post Only ', style: stA7B1BC50012),
                            const Icon(Icons.info_outline,
                                color: kcA7B1BC, size: 10)
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: stA7B1BC50012),
                          Text('0.0', style: stA7B1BC50012),
                        ],
                      ),
                      const SizedBox(height: 14),
                      CustomActionButton(
                        title: 'Buy BTC',
                        callback: () {},
                      ),
                      const Divider(
                        color: kc394047,
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total account value', style: stA7B1BC50012),
                              Text('0.0', style: stFFFFFF70014),
                            ],
                          ),
                          Spacer(),
                          Text('NGN', style: stA7B1BC50012),
                          Icon(Icons.keyboard_arrow_down, color: kc777E90),
                        ],
                      ),
                      const SizedBox(height: 14),
                      const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total account value', style: stA7B1BC50012),
                              Text('0.0', style: stFFFFFF70014),
                            ],
                          ),
                          Spacer(),
                          Text('Available', style: stA7B1BC50012),
                        ],
                      ),
                      const SizedBox(height: 30),
                      CustomOrderButton(
                        title: 'Deposit',
                        bgColor: kc2764FF,
                        callback: () {},
                        width: 80,
                      )
                    ],
                  ),
                  const Text('data3')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabRow(String title, int page) {
    return GestureDetector(
      onTap: currentIndex != page
          ? () {
              pageController.animateToPage(page,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            }
          : null,
      child: Container(
        height: 28,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: BoxDecoration(
            color: currentIndex == page ? kc21262C : kcTransparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: currentIndex == page ? kc25C26E : kcTransparent,
            )),
        child: Text(
          title,
          style: stFFFFFF50012.copyWith(
              color: currentIndex == page ? kcWhite : kcA7B1BC),
        ),
      ),
    );
  }
}
