import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/contact_bloc.dart';
import 'package:voipmax/src/component/search_bar.dart';
import 'package:voipmax/src/modules/Contact/widgets.dart';

import '../../core/theme/color_theme.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    ContactBloc _controller = Get.put(ContactBloc());
    // _controller.onInit();
    return GetBuilder(
        init: ContactBloc(),
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: .2,
              backgroundColor: backGroundColor,
              flexibleSpace: const CustomSearchBar(),
              bottom: TabBar(
                labelColor: primaryColor,
                indicatorColor: primaryColor,
                unselectedLabelColor: muteColor,
                controller: _controller.tabController,
                tabs: const [
                  Tab(
                    text: "People",
                  ),
                  Tab(
                    text: "Team",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller.tabController,
              children: [
                Container(
                  color: backGroundColor,
                  padding: EdgeInsets.only(
                    left: Get.width * .06,
                    right: Get.width * .06,
                  ),
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return contactItemBody();
                    },
                  ),
                ),
                Container(
                  color: backGroundColor,
                  padding: EdgeInsets.only(
                    left: Get.width * .06,
                    right: Get.width * .06,
                  ),
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return contactItemBody();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
