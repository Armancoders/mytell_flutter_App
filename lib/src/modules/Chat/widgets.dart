import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

Widget chatAppBar() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Expanded(
        child: SizedBox(
          child: Container(
            padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
            color: backGroundColor,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //back & name
                  Row(
                    children: [
                      backBtn(),
                      spX(10),
                      Text(
                        "Name Holder",
                        style: textSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  //search & options
                  Row(
                    children: [
                      Icon(Icons.search),
                      spX(10),
                      Icon(Icons.more_vert_rounded),
                      // Icon(Icons.)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ],
  );
}

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

Widget chatBody() {
  return Container(
    color: hintBackGroundColor,
    height: Get.height,
    child: Center(
      child: Text(
        "messages holder \n here will be implemented Soon.",
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget chatTextField() {
  return SafeArea(
    bottom: false,
    child: Container(
        height: Get.height * .1,
        color: backGroundColor,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: muteColor,
            ),
            //field
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
                child: Container(
                  // width: Get.width * .7,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: hintBackGroundColor,
                      borderRadius: BorderRadius.circular(Get.width * .06)),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                        hintStyle: textSmall.copyWith(color: hintColor)),
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.send,
              color: Colors.blue,
            ),
          ],
        )),
  );
}
