import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/component/search_bar.dart';
import 'package:voipmax/src/component/sip_register_statusbar.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/modules/Messages/widgets.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  tempSearchFun({required String? q}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .2,
        backgroundColor: backGroundColor,
        actions: const [
          SafeArea(child: SipRegisterStatusBar()),
        ],

        title: CustomSearchBar(
          onSearch: tempSearchFun,
        ),
        // flexibleSpace: const SafeArea(child: CustomSearchBar()),
      ),
      body: Container(
        color: backGroundColor,
        padding: EdgeInsets.only(
          left: Get.width * .06,
          right: Get.width * .06,
        ),
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return messagesItemBody();
          },
        ),
      ),
    );
  }
}
