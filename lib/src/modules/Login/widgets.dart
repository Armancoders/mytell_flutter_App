import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

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
              border: Border.all(
                color: hintColor,
                width: .5
              )),
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
  return Container(
    decoration:
        const BoxDecoration(shape: BoxShape.circle, color: hintBackGroundColor),
    padding: EdgeInsets.all(10),
    child: Container(
        margin: EdgeInsets.all(Get.height * .02),
        height: Get.height * .07,
        child: Hero(
          tag: "onB_logo",
          child: Image.asset(
            "assets/onB_logo.png",
            fit: BoxFit.contain,
          ),
        )),
  );
}

Widget loginTitle() {
  return Row(
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
      )
    ],
  );
}

Widget userNameField() {
  return Column(
    children: [
      Row(
        children: [
          Text(
            "Username",
            style: textMedium,
          )
        ],
      ),
      spY(10),
      Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: hintBackGroundColor,
            borderRadius: BorderRadius.circular(Get.width * .08)),
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05, vertical: 2),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your username",
              hintStyle: textMedium.copyWith(color: hintColor)),
        ),
      )
    ],
  );
}

Widget passwordField() {
  return Column(
    children: [
      Row(
        children: [
          Text(
            "Password",
            style: textMedium,
          )
        ],
      ),
      spY(10),
      Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: hintBackGroundColor,
            borderRadius: BorderRadius.circular(Get.width * .08)),
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05, vertical: 2),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter password",
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
        child: Text("Or Login with",style: textSmall.copyWith(color: hintColor),),
      )
    ],
  );
}

Widget loginOptions(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: Get.width * .4,
        padding: EdgeInsets.symmetric(vertical: Get.height * .02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Get.width * .08),
          border: Border.all(
            color: hintColor,
            width: .5
          )
        ),
        child: Center(
          child: Text("F"),
        ),
      ),
      Container(
        width: Get.width * .4,
        padding: EdgeInsets.symmetric(vertical: Get.height * .02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Get.width * .08),
          border: Border.all(
            color: hintColor,
            width: .5
          )
        ),
        child: Center(
          child: Text("G"),
        ),
      ),
    ],
  );
}

Widget register(){
  return Text.rich(
    TextSpan(
      text: "Don't hav an account?",
      style: textSmall.copyWith(color: hintColor),
      children: [
        TextSpan(
          text: " Register",
          style: textSmall.copyWith(color: primaryColor,fontWeight: FontWeight.bold)
        )
      ]
    )
  );
}