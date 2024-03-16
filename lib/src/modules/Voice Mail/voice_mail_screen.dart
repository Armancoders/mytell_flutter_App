import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/voicemail_bloc.dart';
import 'package:voipmax/src/component/search_bar.dart';
import 'package:voipmax/src/component/sip_register_statusbar.dart';
import 'package:voipmax/src/core/theme/color_theme.dart';
import 'package:voipmax/src/modules/Voice%20Mail/widgets.dart';

class VoiceMailScreen extends StatelessWidget {
  const VoiceMailScreen({super.key});

  tempSearchFun({required String? q}) {}

  @override
  Widget build(BuildContext context) {
    Get.put(VoiceMailBloc());
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
            top: Get.height * .03,
            left: Get.width * .06,
            right: Get.width * .06,
          ),
          child: const VoiceMailBody()),
    );
  }
}
