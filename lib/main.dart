import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:voipmax/src/routes/pages.dart';
import 'package:voipmax/src/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "VoipMax",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}
