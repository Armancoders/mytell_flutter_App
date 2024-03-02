import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/call_bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

class BluredBackGrpund extends StatelessWidget {
  const BluredBackGrpund({super.key});

  @override
  Widget build(BuildContext context) {
    CallBloc callController = Get.find();
    return GetBuilder(
        init: callController,
        builder: (_) {
          return Container(
              height: Get.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/userP.jpeg"),
              )),
              child: Obx(
                () => callController.isOnlyVoice.value
                    ? BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2)),
                        ),
                      )
                    : RTCVideoView(
                        callController.localRenderer!,
                        mirror: true,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      ),
              ));
        });
  }
}

class CallDetails extends StatelessWidget {
  const CallDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CallBloc callController = Get.find();
    return Column(
      children: [
        Text(
          "Maya",
          style: textTitleXLarge.copyWith(color: backGroundColor),
        ),
        Obx(
          () => Text(
            callController.callStatus.value ==
                    CallStateEnum.CONNECTING.toString()
                ? CallStateEnum.CONNECTING.toString()
                : callController.callStatus.value ==
                        CallStateEnum.FAILED.toString()
                    ? CallStateEnum.FAILED.toString()
                    : callController.timeLabel.value,
            style: textMedium.copyWith(color: backGroundColor),
          ),
        )
      ],
    );
  }
}

class CallActionButtons extends StatelessWidget {
  const CallActionButtons({super.key});

  Widget buttonBG(Widget child, Color? bgColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: Get.height * .1,
      width: Get.height * .1,
      decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    CallBloc callController = Get.find();
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    callController.muteAudio();
                  },
                  child: buttonBG(
                      Icon(
                        callController.audioMuted.value
                            ? Icons.mic_off_outlined
                            : Icons.mic_none,
                        color: backGroundColor,
                      ),
                      Colors.white.withOpacity(
                          callController.audioMuted.value ? .7 : .2)),
                ),
                buttonBG(const Icon(Icons.dialpad, color: backGroundColor),
                    Colors.white.withOpacity(.2)),
                buttonBG(const Icon(Icons.speaker, color: backGroundColor),
                    Colors.white.withOpacity(.2))
              ],
            ),
            spY(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonBG(const Icon(Icons.add, color: backGroundColor),
                    Colors.white.withOpacity(.2)),
                GestureDetector(
                  onTap: () {
                    callController.handleHold();
                  },
                  child: buttonBG(
                      Icon(
                          callController.hold.value
                              ? Icons.play_arrow
                              : Icons.pause,
                          color: backGroundColor),
                      Colors.white
                          .withOpacity(callController.hold.value ? .7 : .2)),
                ),
                buttonBG(
                    const Icon(Icons.perm_contact_calendar_outlined,
                        color: backGroundColor),
                    Colors.white.withOpacity(.2))
              ],
            )
          ],
        ));
  }
}

class HangUpButton extends StatelessWidget {
  const HangUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    CallBloc callController = Get.find();
    return GestureDetector(
      onTap: () {
        callController.onHangUp();
      },
      child: Container(
        height: Get.height * .1,
        width: Get.height * .1,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Colors.redAccent),
        child: const Icon(
          Icons.phone_disabled_outlined,
          color: backGroundColor,
        ),
      ),
    );
  }
}
