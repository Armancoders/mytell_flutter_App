import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/contact_bloc.dart';
import 'package:voipmax/src/component/search_bar.dart';
import 'package:voipmax/src/component/sip_register_statusbar.dart';
import 'package:voipmax/src/modules/Contact/widgets.dart';
import 'package:voipmax/src/repo.dart';

import '../../core/theme/color_theme.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    ContactBloc _controller = Get.put(ContactBloc());
    MyTelRepo repo = MyTelRepo();
    // _controller.onInit();
    return GetBuilder(
        init: _controller,
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              elevation: .2,
              backgroundColor: backGroundColor,
              actions: const [
                SafeArea(child: SipRegisterStatusBar()),
              ],
              title: const CustomSearchBar(),
              // flexibleSpace: Padding(
              //   padding: const EdgeInsets.only(bottom: 15.0),
              //   child: const CustomSearchBar(),
              // ),
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
                    child: RefreshIndicator(
                      color: primaryColor,
                      onRefresh: () {
                        return _controller.getContacts();
                      },
                      child: repo.contacts != null && repo.contacts!.isNotEmpty
                          ? ListView.builder(
                              itemCount: repo.contacts?.length ?? 0,
                              itemBuilder: (context, index) {
                                return contactItemBody(repo.contacts?[index]);
                              },
                            )
                          : const Center(
                              child: Text("No Contact"),
                            ),
                    )),
                Container(
                  color: backGroundColor,
                  padding: EdgeInsets.only(
                    left: Get.width * .06,
                    right: Get.width * .06,
                  ),
                  child: RefreshIndicator(
                    color: primaryColor,
                    onRefresh: () async {
                      await _controller.getExtensions();
                    },
                    child: repo.extensions != null
                        ? ListView.builder(
                            itemCount: repo.extensions?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return extensionsItemBody(
                                  repo.extensions?.data?[index]);
                            },
                          )
                        : const Center(
                            child: Text("No Team mate"),
                          ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
