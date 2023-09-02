import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/modules/Recent/widgets.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backGroundColor,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: Get.width * .06,
              right: Get.width * .06,
            ),
            color: backGroundColor,
            child: Column(
              children: [
                spY(10),
                recentTitle(),
                spY(10),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return recentItemsBody();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
