import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/recent_bloc.dart';
import 'package:voipmax/src/component/search_bar.dart';
import 'package:voipmax/src/component/sip_register_statusbar.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/modules/Recent/widgets.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var recentController = Get.put(RecentCallsBloc());
    return GetBuilder(
        init: recentController,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              elevation: .2,
              backgroundColor: backGroundColor,
              actions: const [
                SafeArea(child: SipRegisterStatusBar()),
              ],
              title: CustomSearchBar(
                onSearch: recentController.search,
                hintText: "Search Recent calls",
              ),
            ),
            body: Container(
              color: backGroundColor,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(
                    left: Get.width * .06,
                    // right: Get.width * .06,
                  ),
                  color: backGroundColor,
                  child: Column(
                    children: [
                      spY(10),
                      recentTitle(),
                      spY(10),
                      GetBuilder(
                          init: recentController,
                          builder: (_) {
                            return Expanded(
                              child: recentController.recents.isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          recentController.recents.length,
                                      itemBuilder: (context, index) {
                                        return recentItemsBody(
                                            recentController.recents[index],
                                            recentController);
                                      },
                                    )
                                  : const Center(
                                      child: Text("No recent call"),
                                    ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
