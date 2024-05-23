import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:raven_assessment/getit.dart';
import 'package:raven_assessment/model/token_pairs_model.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/image_util.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';
import 'package:raven_assessment/view/base_view_builder.dart';
import 'package:raven_assessment/view/widgets/price_action_widget.dart';
import 'package:raven_assessment/viewModel/token_veiw_model.dart';

class TokenWidget extends StatelessWidget {
  const TokenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<TokenViewModel>(
        model: getIt(),
        initState: (init) {
          init.initializeCandle();
        },
        builder: (tVm, _) {
          return StreamBuilder<List<Candle>>(
              stream: tVm.candlesController.stream,
              builder: (context, snapshot) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 20),
                  decoration: BoxDecoration(
                    color: kcPrimaryColor,
                    border: Border.all(color: kc262932),
                  ),
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : snapshot.hasError
                          ? Text('Error: ${snapshot.error}')
                          : (!snapshot.hasData || snapshot.data!.isEmpty)
                              ? const Text('No data available')
                              : Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: PopupMenuButton<String>(
                                              icon: Row(
                                                children: [
                                                  FlutterImageStack.widgets(
                                                    showTotalCount: false,
                                                    totalCount: 4,
                                                    itemRadius: 20,
                                                    itemCount: 2,
                                                    itemBorderWidth: 0,
                                                    children: [
                                                      Image.asset(imgBnb),
                                                      Image.asset(imgUsdt),
                                                    ],
                                                  ),
                                                  const Text(
                                                    '  BTC/USDT',
                                                    style: stFFFFFF50018,
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: kcWhite,
                                                  ),
                                                ],
                                              ),
                                              itemBuilder:
                                                  (BuildContext context) =>
                                                      tokenPairsData
                                                          .map(
                                                            (e) =>
                                                                PopupMenuItem<
                                                                    String>(
                                                              // onTap: () => tVm.selectTransactionType(e),
                                                              // value: tVm.selectedTxnType,
                                                              child: Text(
                                                                e.pairs,
                                                                style:
                                                                    stFFFFFF50018,
                                                              ),
                                                            ),
                                                          )
                                                          .toList()),
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                            '\$${snapshot.data?.last.high ?? 0}',
                                            style: st00C07650018)
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        PriceActionWidget(
                                          title: '24h change',
                                          value:
                                              '${snapshot.data?.last.high} +1.25%',
                                          icon: Icons.schedule,
                                          isColor: true,
                                        ),
                                        PriceActionWidget(
                                          title: '24h high',
                                          value:
                                              '${snapshot.data?.last.high} +1.25%',
                                          icon: Icons.arrow_upward,
                                        ),
                                        PriceActionWidget(
                                          title: '24h low',
                                          value:
                                              '${snapshot.data?.last.low} +1.25%',
                                          icon: Icons.arrow_downward,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                );
              });
        });
  }
}
