import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/core/utils/utils.dart';
import 'package:voipmax/src/core/values/values.dart';
import 'package:voipmax/src/repo.dart';

class SipRegisterStatusBar extends StatelessWidget {
  const SipRegisterStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    SIPBloc sipController = Get.find();
    MyTelRepo repo = MyTelRepo();
    return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Obx(
          () => GestureDetector(
            onLongPress: () {
              repo.onLogOut(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                sipController.registering.value
                    ? spinKitButtonPrimary
                    : sipController.registrationStatus.value ==
                            MytelValues.deviceRegisteredStatus
                        ? Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(3)),
                          )
                        : GestureDetector(
                            onTap: () {
                              sipController.register();
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(3)),
                            ),
                          ),
                Text(sipController.registrationStatus.value)
              ],
            ),
          ),
        ));
  }
}
