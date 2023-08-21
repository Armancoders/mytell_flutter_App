
import 'package:get/route_manager.dart';
import 'package:voipmax/src/modules/OnBoarding/on_boarding.dart';
import 'package:voipmax/src/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.ON_BOARDING, page: ()=> const OnBoarding()),
  ];
}