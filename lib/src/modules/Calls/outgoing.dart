import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/modules/Calls/wigets.dart';

class OutGoingCallScreen extends StatelessWidget {
  const OutGoingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: Get.height,
      width: Get.width,
      child: const Stack(
        alignment: Alignment.center,
        children: [
          BluredBackGrpund(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [CallDetails(), CallActionButtons(), HangUpButton()],
          )
        ],
      ),
    ));
  }
}
