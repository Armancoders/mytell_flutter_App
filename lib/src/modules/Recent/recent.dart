import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/home_screen_bloc.dart';
import 'package:voipmax/src/bloc/recent_bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/component/search_bar.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/core/theme/dimensions.dart';
import 'package:voipmax/src/core/utils/utils.dart';
import 'package:voipmax/src/core/values/values.dart';
import 'package:voipmax/src/modules/Recent/widgets.dart';
import 'package:voipmax/src/repo.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var recentController = Get.put(RecentCallsBloc());
    return GetBuilder(
        init: recentController,
        builder: (contextx) {
          return Scaffold(
            appBar: AppBar(
              elevation: .2,
              backgroundColor: backGroundColor,
              actions: [
                SafeArea(child: recentScreenAppBar(context)),
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

  recentScreenAppBar(BuildContext context) {
    SIPBloc sipController = Get.find();
    HomeScreenBloc homeScreenController = Get.find();
    MyTelRepo repo = MyTelRepo();
    return Padding(
      key: homeScreenController.statusBarKey,
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onLongPress: () {
          repo.onLogOut(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => sipController.registering.value
                  ? spinKitButtonPrimary
                  : sipController.registrationStatus.value ==
                          MytelValues.deviceRegisteredStatus
                      ? Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(3)),
                        )
                      : GestureDetector(
                          onTap: () {
                            sipController.register();
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
            ),
            Obx(() => Text(sipController.registrationStatus.value))
          ],
        ),
      ),
    );
  }
}
