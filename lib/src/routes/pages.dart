
import 'package:get/route_manager.dart';
import 'package:voipmax/src/modules/Chat/chat.dart';
import 'package:voipmax/src/modules/Messages/messages.dart';
import 'package:voipmax/src/modules/Contact/contact.dart';
import 'package:voipmax/src/modules/Login/login.dart';
import 'package:voipmax/src/modules/OnBoarding/on_boarding.dart';
import 'package:voipmax/src/modules/Recent/recent.dart';
import 'package:voipmax/src/modules/dialpad.dart';
import 'package:voipmax/src/modules/home_screen.dart';
import 'package:voipmax/src/modules/splash.dart';
import 'package:voipmax/src/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.ON_BOARDING, page: ()=> const OnBoarding()),
    GetPage(name: Routes.LOGIN, page: ()=> const LoginScreen()),
    GetPage(name: Routes.HOME, page: ()=>  HomeScreen()),
    GetPage(name: Routes.DIALPAD, page: ()=>  const DialPadScreen()),
    GetPage(name: Routes.SPLASH, page: ()=>  const SplashScreen()),
    GetPage(name: Routes.RECENT, page: ()=>  const RecentScreen()),
    GetPage(name: Routes.CONTACT, page: ()=>  const Contact()),
    GetPage(name: Routes.MESSAGES, page: ()=>  const MessagesScreen()),
    GetPage(name: Routes.CHAT, page: ()=>  const ChatScreen()),
  ];
}