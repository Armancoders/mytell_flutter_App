import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';

class ContactBloc extends Bloc with GetTickerProviderStateMixin {
  late TabController tabController;
  MyTelRepo repo = MyTelRepo();
  final SIPBloc sipController = Get.find();

  Future makeCall([bool voiceOnly = false, String? dest]) async {
    sipController.makeCall(voiceOnly, dest);
  }

  @override
  void onInit() {
    super.onInit();
    initTabController();
    getExtensions();
  }

  initTabController() {
    tabController = TabController(length: 2, vsync: this);
    update();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> getExtensions() async {
    repo.extensions = await AipHelper.extensionsStatus(
      domain: repo.sipServer?.data?.wssDomain ?? "",
    );
    update();
  }
}
