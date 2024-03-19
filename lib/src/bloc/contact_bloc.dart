import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/data/models/extensions.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';

class ContactBloc extends Bloc with GetTickerProviderStateMixin {
  late TabController tabController;
  MyTelRepo repo = MyTelRepo();
  final SIPBloc sipController = Get.find();
  List<Contact>? tempContacts = [];
  Extensions? tempExtensions;

  Future makeCall(
      [bool voiceOnly = false, String? dest, String? callee]) async {
    sipController.makeCall(voiceOnly, dest, callee);
  }

  @override
  void onInit() {
    super.onInit();
    initTabController();
    getExtensions();
    getContacts();
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
    repo.extensions?.data?.sort((a, b) => int.parse(
            a.extension?.replaceRange(a.extension!.indexOf("@"), null, "") ??
                "0")
        .compareTo(int.parse(
            b.extension?.replaceRange(b.extension!.indexOf("@"), null, "") ??
                "0")));
    update();
  }

  Future getContacts() async {
    if (await Permission.contacts.status != PermissionStatus.granted) {
      await Permission.contacts.request();
    }
    repo.contacts = await FlutterContacts.getContacts(
        withProperties: true, withThumbnail: true);
    update();
  }

  search({required String? q}) {
    if (q == null) {
      if (tempContacts?.isNotEmpty ?? false) {
        repo.contacts = tempContacts;
        tempContacts = [];
      }
      if (tempExtensions?.data?.isNotEmpty ?? false) {
        repo.extensions = tempExtensions;
        tempExtensions = Extensions(data: []);
      }
      update();
      return;
    }
    if (tabController.index == 0) {
      //contacts

      if (tempContacts!.isEmpty) {
        tempContacts = repo.contacts;
      }
      repo.contacts = [];
      for (var contact in tempContacts!) {
        if (contact.displayName.toLowerCase().contains(q.toLowerCase())) {
          repo.contacts!.add(contact);
        }
        if (contact.phones.isNotEmpty) {
          if (contact.phones[0].number.contains(q)) {
            repo.contacts!.add(contact);
          }
        }
      }
      update();
    } else if (tabController.index == 1) {
      //team

      if (tempExtensions?.data?.isEmpty ?? true) {
        tempExtensions = repo.extensions;
      }
      repo.extensions = Extensions(data: []);
      for (var extension in tempExtensions!.data!) {
        if (extension.extension!.toLowerCase().contains(q.toLowerCase())) {
          repo.extensions!.data!.add(extension);
        }
      }
      update();
    }
  }
}
