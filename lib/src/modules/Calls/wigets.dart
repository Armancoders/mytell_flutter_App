import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

class BluredBackGrpund extends StatelessWidget {
  const BluredBackGrpund({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/userP.jpeg"),
      )),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }
}

class CallDetails extends StatelessWidget {
  const CallDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Maya",
          style: textTitleXLarge.copyWith(color: backGroundColor),
        ),
        Text(
          "00:02",
          style: textMedium.copyWith(color: backGroundColor),
        ),
      ],
    );
  }
}

class CallActionButtons extends StatelessWidget {
  const CallActionButtons({super.key});

  buttonBG(Widget child) {
    return Container(
      height: Get.height * .1,
      width: Get.height * .1,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.white.withOpacity(.2)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonBG(
              const Icon(
                Icons.mic_none_outlined,
                color: backGroundColor,
              ),
            ),
            buttonBG(
              const Icon(Icons.dialpad, color: backGroundColor),
            ),
            buttonBG(
              const Icon(Icons.speaker, color: backGroundColor),
            )
          ],
        ),
        spY(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonBG(
              const Icon(Icons.add, color: backGroundColor),
            ),
            buttonBG(
              const Icon(Icons.pause, color: backGroundColor),
            ),
            buttonBG(
              const Icon(Icons.perm_contact_calendar_outlined,
                  color: backGroundColor),
            )
          ],
        )
      ],
    );
  }
}

class HangUpButton extends StatelessWidget {
  const HangUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .1,
      width: Get.height * .1,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent),
      child: const Icon(
        Icons.phone_disabled_outlined,
        color: backGroundColor,
      ),
    );
  }
}
