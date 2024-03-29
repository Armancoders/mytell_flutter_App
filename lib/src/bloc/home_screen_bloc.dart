import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

class HomeScreenBloc extends Bloc {
  late TutorialCoachMark homeScreenTutorialCoachMark;
  CupertinoTabController controller = CupertinoTabController();
  GlobalKey statusBarKey = GlobalKey();
  GlobalKey contactTabsKey = GlobalKey();
  GlobalKey contactTabIconKey = GlobalKey();
  GlobalKey messagesTabIconKey = GlobalKey();
  GlobalKey voiceMailTabIconKey = GlobalKey();
  late SharedPreferences prefs;

  void showHomeScreenTutorial(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    var toturialDone = prefs.getBool("homeScreenTutorialDone") ?? false;
    if (toturialDone) return;
    // ignore: use_build_context_synchronously
    homeScreenTutorialCoachMark.show(context: context);
  }

  void createHomeScreenTutorial() {
    homeScreenTutorialCoachMark = TutorialCoachMark(
      targets: [
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
        TargetFocus(
          shape: ShapeLightFocus.Circle,
          identify: "contactTabIconKey",
          keyTarget: contactTabIconKey,
          alignSkip: Alignment.bottomRight,
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "You can manage your contacts by going to Contact page.",
                      style: textLarge.copyWith(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        TargetFocus(
          shape: ShapeLightFocus.RRect,
          identify: "contactTabsKey",
          keyTarget: contactTabsKey,
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
                      "Your phone Contacts , Teammates and Sip contacts are categorized and you can simply interact with them.",
                      style: textLarge.copyWith(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        TargetFocus(
          shape: ShapeLightFocus.Circle,
          identify: "messagesTabIconKey",
          keyTarget: messagesTabIconKey,
          alignSkip: Alignment.bottomRight,
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Your all chats will apear here ASAP you start a conversation.",
                      style: textLarge.copyWith(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        TargetFocus(
          shape: ShapeLightFocus.Circle,
          identify: "voiceMailTabIconKey",
          keyTarget: voiceMailTabIconKey,
          alignSkip: Alignment.bottomLeft,
          enableOverlayTab: true,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "You can see and play all of your voice mails.",
                      style: textLarge.copyWith(color: Colors.white),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
      colorShadow: primaryColor,
      textSkip: "Skip",
      textStyleSkip: textMedium.copyWith(color: Colors.white),
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      onFinish: () {
        prefs.setBool("homeScreenTutorialDone", true);
      },
      onClickTarget: (target) {
        if (target.identify == "contactTabIconKey") {
          controller.index = 2;
        }
        if (target.identify == "messagesTabIconKey") {
          controller.index = 3;
        }
        if (target.identify == "voiceMailTabIconKey") {
          controller.index = 4;
        }
      },
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickOverlay: (target) {},
      onSkip: () {
        return true;
      },
    );
  }

  @override
  void onInit() async {
    super.onInit();
    createHomeScreenTutorial();
  }
}
