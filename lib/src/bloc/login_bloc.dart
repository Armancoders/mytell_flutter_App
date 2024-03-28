import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';
import 'package:voipmax/src/routes/routes.dart';

class LoginBloc extends Bloc {
  MyTelRepo repo = MyTelRepo();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool logging = false.obs;
  late SharedPreferences prefs;
  var onBoardIsDone = false;

  late TutorialCoachMark loginTutorialCoachMark;
  GlobalKey uniqIdWidgetKey = GlobalKey();

  void showTutorial(BuildContext context) async {
    var toturialDone = prefs.getBool("loginToturialDone") ?? false;
    if (toturialDone) return;
    // ignore: use_build_context_synchronously
    loginTutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    loginTutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: primaryColor,
      textSkip: "Skip",
      hideSkip: true,
      textStyleSkip: textMedium.copyWith(color: Colors.white),
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      onFinish: () {
        prefs.setBool("loginToturialDone", true);
      },
      onClickTarget: (target) {},
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickOverlay: (target) {},
      onSkip: () {
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "statusBarKey1",
        keyTarget: uniqIdWidgetKey,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "You need to share your unique id with admin to register your device. Then you can login and use MyTell.",
                    style: textLarge.copyWith(color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    return targets;
  }

  Future<void> login({bool? isPush = false}) async {
    if (userNameController.text.trim().isEmpty) {
      Get.snackbar("", "",
          backgroundColor: Colors.redAccent,
          titleText: Text(
            "Error",
            style: textTitleMedium.copyWith(color: Colors.white),
          ),
          messageText: Text(
            "Please Enter your Username",
            style: textMedium.copyWith(color: Colors.white),
          ));
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar("", "",
          backgroundColor: Colors.redAccent,
          titleText: Text(
            "Error",
            style: textTitleMedium.copyWith(color: Colors.white),
          ),
          messageText: Text(
            "Please Enter your Password",
            style: textMedium.copyWith(color: Colors.white),
          ));
      return;
    }
    logging.value = true;
    await AipHelper.authenticateDevice(
            userName: userNameController.text.isNotEmpty
                ? userNameController.text
                : prefs.getString("userName") ?? "",
            password: passwordController.text.isNotEmpty
                ? passwordController.text
                : prefs.getString("passWord") ?? "")
        .then((value) async {
      if (value.$1 != null) {
        prefs.setBool("onBoardingDone", true);
        repo.sipServer = value.$1;
        logging.value = false;

        SIPBloc sipBloc = Get.find();
        sipBloc.register();

        prefs.setString("userName", userNameController.text);
        prefs.setString("passWord", passwordController.text);
        if (!isPush!) {
          Get.offAllNamed(Routes.HOME);
        }
      } else if (value.$2 != null) {
        Get.snackbar("", "",
            backgroundColor: Colors.redAccent,
            titleText: Text(
              "Error",
              style: textTitleMedium.copyWith(color: Colors.white),
            ),
            messageText: Text(
              value.$2!["detail"].toString(),
              style: textMedium.copyWith(color: Colors.white),
            ));
      } else {
        Get.snackbar("", "",
            backgroundColor: Colors.redAccent,
            titleText: Text(
              "Error",
              style: textTitleMedium.copyWith(color: Colors.white),
            ),
            messageText: Text(
              "Something went wrong. please trye again",
              style: textMedium.copyWith(color: Colors.white),
            ));
      }
      logging.value = false;
    });
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void autoLogin() async {
    userNameController.text = prefs.getString("userName") ?? "";
    passwordController.text = prefs.getString("passWord") ?? "";

    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      login();
    }
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("onBoardingDone") ?? false) {
      onBoardIsDone = true;
    } else {
      onBoardIsDone = false;
    }
    createTutorial();
  }
}
