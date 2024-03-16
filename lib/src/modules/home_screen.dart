import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/modules/Messages/messages.dart';
import 'package:voipmax/src/modules/Contact/contact.dart';
import 'package:voipmax/src/modules/Recent/recent.dart';
import 'package:voipmax/src/modules/Voice%20Mail/voice_mail_screen.dart';
import 'package:voipmax/src/modules/dialpad.dart';
import '../core/theme/color_theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List mainPages = [
    RecentScreen(),
    DialPadScreen(),
    Contact(),
    MessagesScreen(),
    VoiceMailScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: 0,
          height: Get.width * 0.13,
          activeColor: primaryColor,
          inactiveColor: muteColor,
          backgroundColor: Colors.white,
          border: const Border(),
          onTap: (itemIndex) {},
          items: const [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.watch_later),
                icon: Icon(Icons.watch_later),
                label: "Recent"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.dialpad),
                icon: Icon(Icons.dialpad),
                label: "Keypad"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.perm_contact_cal),
                icon: Icon(Icons.perm_contact_cal),
                label: "Contact"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.chat_bubble),
                icon: Icon(Icons.chat_bubble),
                label: "Chat"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.voicemail),
                icon: Icon(Icons.voicemail),
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
