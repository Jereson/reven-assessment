import 'package:flutter/material.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/utilities/image_util.dart';

AppBar appBar(String title) {
  return AppBar(
      backgroundColor: kcPrimaryColor,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            imgLogomark,
            height: 34,
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 16,
            backgroundColor: kcCC6607,
            child: Icon(
              Icons.person,
              // color: kcCC6607,
            ),
          ),
          const SizedBox(width: 15),
          Image.asset(
            imgGlob,
            height: 24,
          ),
          const SizedBox(width: 10),
          Image.asset(
            imgMenu,
            height: 32,
          ),
        ],
      ));
}
