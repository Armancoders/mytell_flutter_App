import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

Widget contactItemBody() {
  return Container(
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
            //name & pNumber
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width * .5,
                    child: Text(
                      "Name Holder",
                      style: textSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  spY(5),
                  Text(
                    "pNumber Holder",
                    style: textSmall.copyWith(color: hintColor),
                  ),
                ],
              ),
            ),

            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                spX(10),
                const Icon(
                  Icons.chat_bubble_rounded,
                  color: Colors.blue,
                )
              ],
            )
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
  );
}
