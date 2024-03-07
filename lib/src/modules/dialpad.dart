import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/dialpad_bloc.dart';

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
          top: Get.height * .15,
          left: Get.width * .06,
          right: Get.width * .06,
        ),
        height: Get.height,
        width: Get.width,
        color: backGroundColor,
        child: DialPad(
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
      ),
    ));
  }
}
