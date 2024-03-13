import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/call_bloc.dart';
import 'package:voipmax/src/bloc/contact_bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/modules/Contact/widgets.dart';
import 'package:voipmax/src/repo.dart';

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
    MyTelRepo repo = MyTelRepo();
    return Column(
      children: [
        GetBuilder(
            init: callController,
            builder: (_) {
              return Text(
                repo.remoteUserDetails["callee"] != null &&
                        repo.remoteUserDetails["callee"].toString().isNotEmpty
                    ? repo.remoteUserDetails["callee"].toString()
                    : repo.remoteUserDetails["caller"] != null &&
                            repo.remoteUserDetails["caller"]
                                .toString()
                                .isNotEmpty
                        ? repo.remoteUserDetails["caller"] ?? "Unknown"
                        : "Unknown",
                style: textTitleXLarge.copyWith(color: backGroundColor),
              );
            }),
        Obx(
          () => Text(
            "${callController.callStatus.value == CallStateEnum.FAILED.name || callController.callStatus.value == CallStateEnum.NONE.name ? "" : callController.timeLabel.value} - ${callController.callStatus.value}",
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
    ContactBloc _controller = Get.find();
    MyTelRepo repo = MyTelRepo();
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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Get.width * .12)),
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return inCallDialPadWidget(callController,
                              makeCall: callController.sendDTMF);
                        });
                  },
                  child: buttonBG(
                      const Icon(Icons.dialpad, color: backGroundColor),
                      Colors.white.withOpacity(.2)),
                ),
                GestureDetector(
                  onTap: () {
                    callController.toggleSpeaker();
                  },
                  child: buttonBG(
                      const Icon(Icons.speaker, color: backGroundColor),
                      Colors.white.withOpacity(
                          callController.speakerOn.value ? .7 : .2)),
                )
              ],
            ),
            spY(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    callController.toggleBluetooth();
                  },
                  child: buttonBG(
                      const Icon(Icons.bluetooth, color: backGroundColor),
                      Colors.white.withOpacity(
                          callController.bluetoothOn.value ? .7 : .2)),
                ),
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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Get.width * .12)),
                        context: context,
                        isScrollControlled: true,
                        builder: (_) {
                          return SafeArea(
                            child: Container(
                                height: Get.height * .8,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: backGroundColor,
                                    borderRadius:
                                        BorderRadius.circular(Get.width * .1)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(Get.width * .06),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Refer call to :",
                                            style: textTitleLarge,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.width * .12)),
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (_) {
                                                    return inCallDialPadWidget(
                                                        callController,
                                                        makeCall: callController
                                                            .transferCall);
                                                  });
                                            },
                                            child: const Icon(
                                              Icons.dialpad,
                                              color: dialColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: backGroundColor,
                                          borderRadius: BorderRadius.circular(
                                              Get.width * .1)),
                                      padding: EdgeInsets.all(Get.width * .06),
                                      child: RefreshIndicator(
                                        color: primaryColor,
                                        onRefresh: () async {
                                          await _controller.getExtensions();
                                        },
                                        child: repo.extensions != null
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: repo.extensions?.data
                                                        ?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  return extensionsItemBody(
                                                      repo.extensions
                                                          ?.data?[index],
                                                      true);
                                                },
                                              )
                                            : const Center(
                                                child: Text("No Team mate"),
                                              ),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        });
                    // callController.transferCall(target: "target");
                  },
                  child: buttonBG(
                      const Icon(Icons.phone_forwarded_outlined,
                          color: backGroundColor),
                      Colors.white.withOpacity(.2)),
                )
              ],
            )
          ],
        ));
  }

  Widget inCallDialPadWidget(CallBloc callController,
      {void Function(String value)? makeCall}) {
    return SafeArea(
      child: Container(
        height: Get.height * .8,
        width: Get.width,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(Get.width * .5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DialPad(
              hideSubtitle: true,
              enableDtmf: true,
              buttonColor: hintBackGroundColor,
              backspaceButtonIconColor: hintColor,
              dialButtonColor: dialColor,
              makeCall: (value) {
                return makeCall!(value);
              },
              // makeCall: (number) {
              // print(number);
              // callController.sendDTMF(dtmf: number);
              // Get.back();
              //   // dialPadController.makeCall(true, number);
              // },
            ),
          ],
        ),
      ),
    );
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
