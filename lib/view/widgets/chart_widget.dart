import 'package:candlesticks_plus/candlesticks_plus.dart';
import 'package:flutter/material.dart';
import 'package:raven_assessment/getit.dart';
import 'package:raven_assessment/model/time_interval_model.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/image_util.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';
import 'package:raven_assessment/view/base_view_builder.dart';
import 'package:raven_assessment/view/widgets/order_widget.dart';
import 'package:raven_assessment/viewModel/token_veiw_model.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BaseViewBuilder<TokenViewModel>(
        model: getIt(),
        initState: (init) {
          init.initializeCandle();
        },
        builder: (tVm, _) {
          return StreamBuilder<List<Candle>>(
              stream: tVm.candlesController.stream,
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: const BoxDecoration(
                          color: kcPrimaryColor,
                          border: Border(
                            top: BorderSide(color: kcBlack, width: 0.5),
                            left: BorderSide(color: kc262932, width: 0.5),
                            right: BorderSide(color: kc262932, width: 0.5),
                          )),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: timeIntervalData.length,
                          itemBuilder: (context, index) {
                            final timeInterval = timeIntervalData[index];
                            return GestureDetector(
                              onTap: () {
                                if (timeInterval.isTime ?? false) {
                                  tVm.selectTimeInterval(
                                      timeInterval.item, index);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(right: 14),
                                child: timeInterval.isImage ?? false
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(timeInterval.item,
                                              height: timeInterval.item ==
                                                      imgDropdown
                                                  ? 8
                                                  : 20),
                                        ],
                                      )
                                    : Container(
                                        height: 28,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            color: (timeInterval.isTime ??
                                                        false) &&
                                                    tVm.currentTimeIntervalIndex ==
                                                        index
                                                ? kc555C63
                                                : kcTransparent),
                                        child: Text(
                                          timeInterval.item,
                                          style: stA7B1BC50014,
                                        ),
                                      ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: const BoxDecoration(
                          color: kcPrimaryColor,
                          border: Border.symmetric(
                              horizontal:
                                  BorderSide(color: kc262932, width: 0.5))),
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                  color: kc353945,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text('Trading view',
                                  style: stFFFFFF70014)),
                          const SizedBox(width: 20),
                          const Text('Depth', style: stA7B1BC50014),
                          const SizedBox(width: 20),
                          Image.asset(imgZoom, height: 17)
                        ],
                      ),
                    ),
                    snapshot.connectionState == ConnectionState.waiting
                        ? const CircularProgressIndicator()
                        : snapshot.hasError
                            ? Text('Error: ${snapshot.error}')
                            : (!snapshot.hasData || snapshot.data!.isEmpty)
                                ? const Text('No data available')
                                : SizedBox(
                                    height: 400,
                                    child: Candlesticks(
                                      // showToolbar: true,
                                      candles: snapshot.data!,

                                      watermark: 'BTC/USDT',
                                      onLoadMoreCandles: () =>
                                          tVm.onPageReload(),
                                    ),
                                  ),
                    SizedBox(
                      height: 36,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: orderTabText.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => tVm.resetCurrentOrderTab(index),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: tVm.currentOrderTab == index
                                        ? kc21262C
                                        : kcTransparent,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                width: size.width * 0.4,
                                child: Text(orderTabText[index],
                                    style: stFFFFFF70014),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              });
        });
  }
}
