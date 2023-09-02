import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

Widget voipMaxBanner() {
  return SizedBox(
    height: Get.height *.35,
    child: Hero(
      tag: "onB_voipMax",
       child: Image.asset("assets/onB_voipMax.png",filterQuality: FilterQuality.high,fit: BoxFit.contain,)),
  );
}

Widget voipMaxTitle() {
  return Column(
    children: [
      Row(
        textDirection: TextDirection.ltr,
        children: [
          SizedBox(
              height: Get.height * .03,
              child: Hero(
                tag: "onB_logo",
                child: Image.asset(
                  "assets/onB_logo.png",
                  fit: BoxFit.contain,
                ),
              )),
          spX(5),
          Text.rich(
            TextSpan(
              text: "VoIP",
              style: textLarge.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: "Max", style: textLarge),
              ],
            ),
          )
        ],
      ),
      spY(15),
      Text(
        "Everything you need is in one place",
        style: textXLarge.copyWith(fontWeight: FontWeight.w600),
        maxLines: 2,
      )
    ],
  );
}

Widget voipMaxPrivacyPolicy() {
  return Text(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque nec feugiat ligula, ornare pretium metus.",
    style: textMedium,
  );
}
