import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/dialpad_bloc.dart';
import 'package:voipmax/src/core/values/values.dart';

import '../core/theme/color_theme.dart';

class DialPadScreen extends StatelessWidget {
  final SIPUAHelper? sipHelper;
  const DialPadScreen({super.key, this.sipHelper});

  @override
  Widget build(BuildContext context) {
    var dialPadController = Get.put(DialPadBloc());
    return Scaffold(
        body: SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.only(
          top: Get.height * .11,
          left: Get.width * .06,
          right: Get.width * .06,
        ),
        height: Get.height,
        width: Get.width,
        color: backGroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(() => Column(
                  children: [
                    dialPadController.sipController.registrationStatus.value ==
                            MytelValues.deviceRegisteredStatus
                        ? Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(3)),
                          )
                        : Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(3)),
                          ),
                    Text(dialPadController
                        .sipController.registrationStatus.value)
                  ],
                )),
            DialPad(
              hideSubtitle: true,
              enableDtmf: true,
              buttonColor: hintBackGroundColor,
              backspaceButtonIconColor: hintColor,
              dialButtonColor: dialColor,
              makeCall: (number) {
                print(number);
                dialPadController.makeCall(true, number);
              },
            ),
          ],
        ),
      ),
    ));
  }
}
