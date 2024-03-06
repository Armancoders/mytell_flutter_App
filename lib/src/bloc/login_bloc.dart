import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';
import 'package:voipmax/src/routes/routes.dart';

class LoginBloc extends Bloc {
  MyTelRepo repo = MyTelRepo();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool logging = false.obs;
  Future<void> login() async {
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
            userName: userNameController.text,
            password: passwordController.text)
        .then((value) {
      if (value != null) {
        repo.sipServer = value;
        logging.value = false;
        Get.offAllNamed(Routes.HOME);
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
}
