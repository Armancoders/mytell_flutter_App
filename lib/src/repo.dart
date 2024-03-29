import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/core/utils/utils.dart';
import 'package:voipmax/src/data/models/extensions.dart';
import 'package:voipmax/src/data/models/recent_calls_model.dart';
import 'package:voipmax/src/data/models/sip_server_model.dart';
import 'package:voipmax/src/data/models/voicemail_model.dart';
import 'package:voipmax/src/routes/routes.dart';

class MyTelRepo extends Bloc {
  SIPServerModel? sipServer;
  String? uniqueDeviceId;
  String? fcmToken;
  Extensions? extensions;
  var remoteUserDetails = {};
  List<Contact>? contacts = [];
  List<RecentCallsModel> recents = [];
  VoiceMailModel? voiceMails;
  RxBool loggingOut = false.obs;

  Future getUniqueId() async {
    try {
      // Permission.phone.request();
      // uniqueDeviceId = await UniqueIdentifier.serial;
      // print(uniqueDeviceId);
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        var iosDeviceInfo = await deviceInfo.iosInfo;
        uniqueDeviceId = iosDeviceInfo.identifierForVendor;
      } else if (Platform.isAndroid) {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        uniqueDeviceId = androidDeviceInfo.id;
      }
    } catch (e) {
      uniqueDeviceId = null;
    }
  }

  onLogOut(BuildContext context) {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Logout",
              style: textMedium,
            ),
            content: Text(
              "Are you sure you want to logout?",
              style: textSmall,
            ),
            actions: [
              Obx(
                () => CupertinoDialogAction(
                  onPressed: () {
                    logOut().then((value) {
                      Get.offAllNamed(Routes.SPLASH);
                    });
                  },
                  child: loggingOut.value
                      ? spinKitButton
                      : Text(
                          "yes",
                          style: textSmall,
                        ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  if (loggingOut.value) return;
                  Get.back();
                },
                child: Text(
                  "cancel",
                  style: textSmall.copyWith(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  Future<void> logOut() async {
    loggingOut.value = true;
    var prefs = await SharedPreferences.getInstance();
    SIPBloc sipController = Get.find();
    sipController.unRegister();
    prefs.clear();
    sipServer = null;
    // uniqueDeviceId = null;
    fcmToken = null;
    extensions = null;
    contacts = null;
    voiceMails = null;
    remoteUserDetails = {};
    await Get.deleteAll(force: true).then((value) {
      loggingOut.value = false;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getUniqueId();
  }

  static final MyTelRepo _instance = MyTelRepo.internal();
  factory MyTelRepo() => _instance;
  MyTelRepo.internal();
}
