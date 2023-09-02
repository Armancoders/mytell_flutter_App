import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voipmax/src/routes/pages.dart';
import 'package:voipmax/src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "VoipMax",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}
