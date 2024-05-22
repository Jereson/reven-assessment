import 'package:flutter/material.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';

class PriceActionWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isColor;
  const PriceActionWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      this.isColor = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: kcA7B1BC,
              size: 13,
            ),
            Text(' $title', style: stA7B1BC50016)
          ],
        ),
        const SizedBox(height: 5),
        Text(value,
            style: st00C07650014.copyWith(color: isColor ? kc00C076 : kcWhite))
      ],
    );
  }
}
