import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/theme/color_theme.dart';
import '../core/utils/utils.dart';

class Button extends StatelessWidget {
  final Widget btnChild;
  final void Function()? btnOnPressed;
  final Color? btnBackGroundColor;
  final Border? btnBorder;
  final double? btnWidth;
  final bool? disable;
  final bool? isLoad;
  final LinearGradient? gradient;
  final EdgeInsets padding;

  const Button(
      {required this.btnChild,
      required this.btnOnPressed,
      this.btnBackGroundColor,
      this.btnBorder,
      this.btnWidth,
      this.gradient,
      this.disable,
      this.isLoad,
      this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 32)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth,
      decoration: BoxDecoration(
        border: btnBorder,
        borderRadius: BorderRadius.all(
          Radius.circular(Get.width * 0.08),
        ),
        gradient: gradient,
      ),
      child: CupertinoButton(
          padding: padding,
          color:(disable==true)?muteColor:btnBackGroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(Get.width * 0.08),
          ),
          onPressed:(disable==true)?(){}:(isLoad==true)?(){}:btnOnPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: Get.width * .05,
              minWidth: Get.width * .35,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (isLoad==true)?spinKitButton:btnChild
              ],
            ),
          ) ),
    );
  }
}
