import 'package:flutter/material.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/text_style.utils.dart';

final borderInputDecoration = InputDecoration(
  // labelStyle: stPrimaryColor150014,
  hintStyle: stA7B1BC50012,

  filled: true,
  fillColor: kc20252B,

  contentPadding: const EdgeInsets.all(8),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: kc373B3F),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: kc373B3F),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: kc373B3F),
  ),
);
