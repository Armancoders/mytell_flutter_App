import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voipmax/src/component/button.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/modules/OnBoarding/widgets.dart';
import 'package:voipmax/src/routes/routes.dart';

import '../../core/theme/dimensions.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: EdgeInsets.only(
            top: Get.height * .08,
            left: Get.width * .06,
            right: Get.width * .06,
          ),
          height: Get.height,
          width: Get.width,
          color: backGroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              voipMaxBanner(),
              voipMaxTitle(),
              voipMaxPrivacyPolicy(),
              spY(15),
              Hero(
                tag: "btn",
                child: Button(
                    btnWidth: Get.width,
                    btnBackGroundColor: primaryColor,
                    btnChild: Text(
                      "Start",
                      style: textMedium.copyWith(color: backGroundColor),
                    ),
                    btnOnPressed: () async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool("onBoardingDone", true);
                      Get.toNamed(Routes.LOGIN);
                    }),
              ),
              // spY(15),
              // Button(
              //     btnWidth: Get.width,
              //     btnBorder: Border.all(color: textColor),
              //     btnBackGroundColor: backGroundColor,
              //     btnChild: Text(
              //       "Register",
              //       style: textMedium,
              //     ),
              //     btnOnPressed: () {}),
            ],
          )),
    ));
  }
}
