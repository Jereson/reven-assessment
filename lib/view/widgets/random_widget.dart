import 'package:flutter/material.dart';
import 'package:raven_assessment/utilities/color_utils.dart';

Widget flagImage(String image,VoidCallback callback, [bool isColor = false]) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: isColor ? kc353945 : kcTransparent,
          borderRadius: BorderRadius.circular(6)),
      child: Image.asset(
        image,
        height: 10,
      ),
    ),
  );
}
