import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voipmax/src/component/button.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/modules/OnBoarding/widgets.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: false,
      child: Container(
          padding: EdgeInsets.only(
            top: Get.height * .04,
            left: Get.width * .04,
            right: Get.width * .04,
          ),
          height: Get.height,
          width: Get.width,
          color: backGroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              voipMaxBanner(),
              voipMaxTitle(),
              // spY(15),
              voipMaxPrivacyPolicy(),
              // spY(15),
              Button(
                  btnWidth: Get.width,
                  btnBackGroundColor: primaryColor,
                  btnChild: Text(
                    "Login",
                    style: textMedium.copyWith(color: Colors.white),
                  ),
                  btnOnPressed: () {}),
              // spY(15),
              Button(
                  btnWidth: Get.width,
                  btnBorder: Border.all(color: textColor),
                  btnBackGroundColor: backGroundColor,
                  btnChild: Text(
                    "Register",
                    style: textMedium,
                  ),
                  btnOnPressed: () {}),
            ],
          )),
    ));
  }
}
