import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voipmax/src/bloc/call_bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/bloc/splash_bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/data/services/firebase_service.dart';
import 'package:voipmax/src/data/services/foreground_service.dart';
import 'package:voipmax/src/repo.dart';

import '../core/theme/text_theme.dart';
import '../routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyTelRepo(), permanent: true);
    Get.put(CallBloc(), permanent: true);
    Get.put(MyTellForeGroundService(), permanent: true);
    Get.put(SIPBloc(), permanent: true);

    SplashScreenBloc controller = Get.put(SplashScreenBloc(), permanent: true);
    Get.put(MyTelFirebaseServices(), permanent: true);
    return Scaffold(
      body: Container(
          height: Get.height,
          width: Get.width,
          color: primaryColor,
          child: Obx(() {
            return AnimatedOpacity(
              opacity: controller.animationStarted.value ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              onEnd: () async {
                var prefs = await SharedPreferences.getInstance();
                if (prefs.getBool("onBoardingDone") ?? false) {
                  Get.toNamed(Routes.LOGIN);
                  return;
                }
                Get.offAllNamed(Routes.ON_BOARDING);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/splashL.png"),
                  spY(15),
                  Text.rich(
                    TextSpan(
                      text: "VoIP",
                      style: textXLarge.copyWith(
                          fontWeight: FontWeight.bold, color: backGroundColor),
                      children: [
                        TextSpan(
                            text: "Max",
                            style: textXLarge.copyWith(color: backGroundColor)),
                      ],
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
