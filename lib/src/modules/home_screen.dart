import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/home_screen_bloc.dart';
import 'package:voipmax/src/modules/Messages/messages.dart';
import 'package:voipmax/src/modules/Contact/contact.dart';
import 'package:voipmax/src/modules/Recent/recent.dart';
import 'package:voipmax/src/modules/Voice%20Mail/voice_mail_screen.dart';
import 'package:voipmax/src/modules/dialpad.dart';
import '../core/theme/color_theme.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List mainPages = [
    RecentScreen(),
    DialPadScreen(),
    Contact(),
    MessagesScreen(),
    VoiceMailScreen(),
  ];

  var index = 0;

  @override
  Widget build(BuildContext context) {
    var homeScreenController = Get.put(HomeScreenBloc());
    homeScreenController.showHomeScreenTutorial(context);
    // if (index == 2) {
    //   homeScreenController.showContactScreenTutorial(context);
    // }
    return CupertinoTabScaffold(
        controller: homeScreenController.controller,
        tabBar: CupertinoTabBar(
          currentIndex: 0,
          height: Get.width * 0.13,
          activeColor: primaryColor,
          inactiveColor: muteColor,
          backgroundColor: Colors.white,
          border: const Border(),
          onTap: (itemIndex) {
            setState(() {
              index = itemIndex;
            });
          },
          items: [
            const BottomNavigationBarItem(
                activeIcon: Icon(Icons.watch_later),
                icon: Icon(Icons.watch_later),
                label: "Recent"),
            const BottomNavigationBarItem(
                activeIcon: Icon(Icons.dialpad),
                icon: Icon(Icons.dialpad),
                label: "Keypad"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.perm_contact_cal),
                icon: Icon(
                  Icons.perm_contact_cal,
                  key: homeScreenController.contactTabIconKey,
                ),
                label: "Contact"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.chat_bubble),
                icon: Icon(
                  Icons.chat_bubble,
                  key: homeScreenController.messagesTabIconKey,
                ),
                label: "Chat"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.voicemail),
                icon: Icon(
                  Icons.voicemail,
                  key: homeScreenController.voiceMailTabIconKey,
                ),
                label: "Voicemail"),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return mainPages[index];
            },
          );
        });
  }
}
