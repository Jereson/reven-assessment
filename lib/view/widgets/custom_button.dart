import 'package:flutter/material.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';

class ChartButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final bool isActive;
  const ChartButton(
      {super.key,
      required this.title,
      required this.callback,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isActive ? kcE9F0FF.withOpacity(0.05) : kcTransparent,
            borderRadius: BorderRadius.circular(8)),
        width: MediaQuery.of(context).size.width * 0.3,
        child: Text(title, style: stFFFFFF70014),
      ),
    );
  }
}

class CustomOrderButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final double? width;
  final VoidCallback callback;
  const CustomOrderButton(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.callback, this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Container(
          alignment: Alignment.center,
          width:width ?? MediaQuery.of(context).size.width * 0.42,
          height: 32,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(8)),
          child: Text(title, style: stFFFFFF70016),
        ));
  }
}

class CustomActionButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  const CustomActionButton(
      {super.key, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: callback,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 32,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient:
                  const LinearGradient(colors: [kc483BEB, kc7847E1, kcDD568D])),
          child: Text(title, style: stFFFFFF70014),
        ));
  }
}
