import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/routes/routes.dart';

Widget messagesItemBody() {
  return GestureDetector(
    onTap: () {
      Get.toNamed(Routes.CHAT);
    },
    child: Container(
      margin: EdgeInsets.only(bottom: Get.height * .015, top: 5),
      child: Column(
        children: [
          Row(
            children: [
              //avatar
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: hintColor.withOpacity(.3)),
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: backGroundColor,
                  ),
                ),
              ),
              spX(10),
              //name & last message & time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * .5,
                          child: Text(
                            "Name Holder",
                            style: textSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "yesterday",
                          style: textSmall.copyWith(color: muteColor),
                        )
                      ],
                    ),
                    spY(5),
                    SizedBox(
                      width: Get.width,
                      child: Text(
                        "last Message Holder",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textSmall.copyWith(color: hintColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //dividers
          Container(
            height: 1,
            width: Get.width * .7,
            margin: EdgeInsets.only(
              top: Get.height * .01,
              // bottom: 5,
              left: Get.width * .09,
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: hintBackGroundColor)),
          )
        ],
      ),
    ),
  );
}
