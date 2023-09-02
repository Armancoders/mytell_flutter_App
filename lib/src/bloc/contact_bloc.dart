

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';

class ContactBloc extends Bloc with GetTickerProviderStateMixin{
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    initTabController();
  }

  initTabController(){
    tabController = TabController(length: 2, vsync: this);
    update();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}