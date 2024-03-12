import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/dialpad_bloc.dart';
import 'package:voipmax/src/component/mytell_dialpad.dart';
import 'package:voipmax/src/component/sip_register_statusbar.dart';

import '../core/theme/color_theme.dart';

class DialPadScreen extends StatelessWidget {
  final SIPUAHelper? sipHelper;
  const DialPadScreen({super.key, this.sipHelper});

  @override
  Widget build(BuildContext context) {
    var dialPadController = Get.put(DialPadBloc());
    return Scaffold(
        appBar: AppBar(
          actions: const [
            SafeArea(child: SipRegisterStatusBar()),
          ],
        ),
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
                MyTellDialPad(
                  hideSubtitle: false,
                  enableDtmf: true,
                  outputMask: "***************",
                  buttonColor: hintBackGroundColor,
                  backspaceButtonIconColor: hintColor,
                  dialButtonColor: dialColor,
                  makeCall: (number) {
                    if (number.isEmpty) return;
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
