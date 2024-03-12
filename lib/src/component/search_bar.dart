import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * .06,
          width: Get.width * .8,
          margin: EdgeInsets.symmetric(horizontal: Get.width * .04),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
            decoration: BoxDecoration(
                color: hintBackGroundColor,
                borderRadius: BorderRadius.circular(Get.width * .08)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search contact",
                    hintStyle: textSmall.copyWith(color: hintColor)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
