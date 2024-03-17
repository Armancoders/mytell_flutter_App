import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:voipmax/src/bloc/login_bloc.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/repo.dart';

Widget backBtn() {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: hintColor, width: .5)),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
            size: 20,
          ),
        ),
      )
    ],
  );
}

Widget voipMaxLogo() {
  return SizedBox(
    height: Get.height * .35,
    child: Hero(
      tag: "onB_voipMax",
      child: Image.asset(
        "assets/mytell_onboard.png",
        fit: BoxFit.contain,
      ),
    ),
  );
}

Widget loginTitle() {
  MyTelRepo repo = MyTelRepo();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login",
            style: textTitleLarge,
          ),
          spY(Get.height * .02),
          Text(
            "Login to continue using the app",
            style: textMedium.copyWith(color: hintColor),
          )
        ],
      ),
      GestureDetector(
        onTap: () {
          Share.share("Hello, my unique id is: ${repo.uniqueDeviceId ?? " "}");
        },
        child: const Icon(
          Icons.qr_code_2,
          size: 40,
        ),
      ),
    ],
  );
}

Widget userNameField() {
  LoginBloc loginController = Get.find();
  return Column(
    children: [
      Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: hintBackGroundColor,
            borderRadius: BorderRadius.circular(Get.width * .08)),
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05, vertical: 2),
        child: TextField(
          controller: loginController.userNameController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Username",
              hintStyle: textMedium.copyWith(color: hintColor)),
        ),
      )
    ],
  );
}

Widget passwordField() {
  LoginBloc loginController = Get.find();
  return Column(
    children: [
      Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: hintBackGroundColor,
            borderRadius: BorderRadius.circular(Get.width * .08)),
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05, vertical: 2),
        child: TextField(
          controller: loginController.passwordController,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              hintStyle: textMedium.copyWith(color: hintColor)),
        ),
      )
    ],
  );
}

Widget forgotPass() {
  return Row(
    textDirection: TextDirection.rtl,
    children: [
      Text(
        "Forgot password?",
        style: textSmall.copyWith(color: hintColor),
        textDirection: TextDirection.ltr,
      )
    ],
  );
}

Widget divider() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: .5,
        width: Get.width,
        color: hintColor,
      ),
      Container(
        color: backGroundColor,
        padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
        // margin: EdgeInsets.symmetric(horizontal: Get.w),
        child: Text(
          "Or Login with",
          style: textSmall.copyWith(color: hintColor),
        ),
      )
    ],
  );
}

Widget loginOptions() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: Get.width * .4,
        padding: EdgeInsets.symmetric(vertical: Get.height * .02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.width * .08),
            border: Border.all(color: hintColor, width: .5)),
        child: Center(
          child: Text("F"),
        ),
      ),
      Container(
        width: Get.width * .4,
        padding: EdgeInsets.symmetric(vertical: Get.height * .02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Get.width * .08),
            border: Border.all(color: hintColor, width: .5)),
        child: Center(
          child: Text("G"),
        ),
      ),
    ],
  );
}

Widget register() {
  return Text.rich(TextSpan(
      text: "Don't hav an account?",
      style: textSmall.copyWith(color: hintColor),
      children: [
        TextSpan(
            text: " Register",
            style: textSmall.copyWith(
                color: primaryColor, fontWeight: FontWeight.bold))
      ]));
}
