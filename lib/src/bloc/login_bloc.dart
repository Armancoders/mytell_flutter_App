import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';
import 'package:voipmax/src/routes/routes.dart';

class LoginBloc extends Bloc {
  MyTelRepo repo = MyTelRepo();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool logging = false.obs;
  late SharedPreferences prefs;
  var onBoardIsDone = false;
  Future<void> login({bool? isPush = false}) async {
    if (userNameController.text.trim().isEmpty) {
      Get.snackbar("", "",
          backgroundColor: Colors.redAccent,
          titleText: Text(
            "Error",
            style: textTitleMedium.copyWith(color: Colors.white),
          ),
          messageText: Text(
            "Please Enter your Username",
            style: textMedium.copyWith(color: Colors.white),
          ));
      return;
    }
    if (passwordController.text.trim().isEmpty) {
      Get.snackbar("", "",
          backgroundColor: Colors.redAccent,
          titleText: Text(
            "Error",
            style: textTitleMedium.copyWith(color: Colors.white),
          ),
          messageText: Text(
            "Please Enter your Password",
            style: textMedium.copyWith(color: Colors.white),
          ));
      return;
    }
    logging.value = true;
    await AipHelper.authenticateDevice(
            userName: userNameController.text.isNotEmpty
                ? userNameController.text
                : prefs.getString("userName") ?? "",
            password: passwordController.text.isNotEmpty
                ? passwordController.text
                : prefs.getString("passWord") ?? "")
        .then((value) async {
      if (value != null) {
        prefs.setBool("onBoardingDone", true);
        repo.sipServer = value;
        logging.value = false;
        print("SALAM-MANSOUR");
        print(value.data!.wssDomain);
        print(value.data!.extension);
        print(value.data!.password);
        print(value.data!.wssPort);

        SIPBloc sipBloc = Get.find();
        sipBloc.register();

        prefs.setString("userName", userNameController.text);
        prefs.setString("passWord", passwordController.text);
        if (!isPush!) {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.snackbar("", "",
            backgroundColor: Colors.redAccent,
            titleText: Text(
              "Error",
              style: textTitleMedium.copyWith(color: Colors.white),
            ),
            messageText: Text(
              "Something went wrong. please trye again",
              style: textMedium.copyWith(color: Colors.white),
            ));
      }
      logging.value = false;
    });
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void autoLogin() async {
    userNameController.text = prefs.getString("userName") ?? "";
    passwordController.text = prefs.getString("passWord") ?? "";

    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      login();
    }
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("onBoardingDone") ?? false) {
      onBoardIsDone = true;
    } else {
      onBoardIsDone = false;
    }
  }
}
