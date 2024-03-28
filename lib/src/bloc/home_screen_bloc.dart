import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

class HomeScreenBloc extends Bloc {
  late TutorialCoachMark tutorialCoachMark;
  GlobalKey statusBarKey = GlobalKey();
  late SharedPreferences prefs;

  void showTutorial(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var toturialDone = prefs.getBool("toturialDone") ?? false;
    if (toturialDone) return;
    // ignore: use_build_context_synchronously
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: primaryColor,
      textSkip: "Skip",
      textStyleSkip: textMedium.copyWith(color: Colors.white),
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      onFinish: () {
        prefs.setBool("toturialDone", true);
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
        keyTarget: statusBarKey,
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
                    "This is your sip registration status which dynamicly changes. Whenever you were 'unregistered' you can simply tap on it and it will try to register again!",
                    style: textLarge.copyWith(color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "statusBarKey2",
        keyTarget: statusBarKey,
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
                    "Also, if you want to logout, just tap and hold on the status section then you will be prompted to wether logout or cancel. ",
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

  @override
  void onInit() async {
    super.onInit();

    createTutorial();
  }
}
