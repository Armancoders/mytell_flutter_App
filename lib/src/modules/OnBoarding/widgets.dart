import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';

Widget voipMaxBanner() {
  return SizedBox(
    height: Get.height * .35,
    child: Hero(
        tag: "onB_voipMax",
        child: Image.asset(
          "assets/mytell_onboard.png",
          filterQuality: FilterQuality.high,
          fit: BoxFit.contain,
        )),
  );
}

Widget voipMaxTitle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
              text: "My",
              style: textLarge.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: "Tell", style: textLarge),
              ],
            ),
          )
        ],
      ),
      spY(15),
      Text(
        "Secure, Fast, User friendly",
        style: textXLarge.copyWith(fontWeight: FontWeight.w600),
        maxLines: 2,
      )
    ],
  );
}

Widget voipMaxPrivacyPolicy() {
  return Text(
    "Discover our easy to install soft phone  compatible with any PBX system, enjoy a secure, fast, and high quality VoIP experience with minimal setup",
    style: textMedium,
  );
}
