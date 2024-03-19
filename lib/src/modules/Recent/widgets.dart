import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/recent_bloc.dart';
import 'package:voipmax/src/component/sip_register_statusbar.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/theme/text_theme.dart';
import 'package:voipmax/src/data/models/recent_calls_model.dart';

Widget recentTitle() {
  return Container(
    color: backGroundColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Recent",
          style: textTitleLarge,
        ),
        const SipRegisterStatusBar(),
      ],
    ),
  );
}

Widget recentItemsBody(
    RecentCallsModel recent, RecentCallsBloc recentController) {
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
            GetBuilder(
                init: recentController,
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * .5,
                        child: Text(
                          recent.callee != null &&
                                  recent.callee.toString().isNotEmpty
                              ? recent.callee.toString()
                              : recent.caller ?? "Unknown",
                          style: textSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (recent.callee != null &&
                          recent.callee.toString().isNotEmpty &&
                          recent.caller != null &&
                          recent.caller.toString().isNotEmpty)
                        spY(5),
                      if (recent.callee != null &&
                          recent.callee.toString().isNotEmpty &&
                          recent.caller != null &&
                          recent.caller.toString().isNotEmpty)
                        Text(
                          recent.caller.toString(),
                          style: textSmall.copyWith(color: hintColor),
                        ),
                    ],
                  );
                })
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
