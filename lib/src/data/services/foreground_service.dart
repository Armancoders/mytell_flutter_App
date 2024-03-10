import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:voipmax/src/bloc/bloc.dart';

class MyTellForeGroundService extends Bloc {
  final notificationChannelId = 'MyTellForeGroundChannel';
  final notificationId = 01;
  late FlutterBackgroundService service;
  Future<void> startForeGroundService() async {
    await service.startService();
  }

  Future<void> stopService() async {
    service.invoke("stopService");
  }

  Future<void> initializeService() async {
    service = FlutterBackgroundService();

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      notificationChannelId, // id
      'MyTell foreGround service', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.low,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStartForeGround,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: notificationChannelId,
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: notificationId,
      ),
      iosConfiguration: IosConfiguration(autoStart: false),
    );
  }

  static Future<void> onStartForeGround(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(
      MyTellForeGroundService().notificationId,
      'COOL SERVICE',
      'Awesome ${DateTime.now()}',
      NotificationDetails(
        android: AndroidNotificationDetails(
          MyTellForeGroundService().notificationChannelId,
          'MY FOREGROUND SERVICE',
          icon: null,
          ongoing: true,
        ),
      ),
    );

    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   if (service is AndroidServiceInstance) {
    //     if (await service.isForegroundService()) {
    //       flutterLocalNotificationsPlugin.show(
    //         notificationId,
    //         'COOL SERVICE',
    //         'Awesome ${DateTime.now()}',
    //         const NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             notificationChannelId,
    //             'MY FOREGROUND SERVICE',
    //             icon: 'ic_bg_service_small',
    //             ongoing: true,
    //           ),
    //         ),
    //       );
    //     }
    //   }
    // });
  }

  @override
  void onInit() {
    super.onInit();
    initializeService();
  }
}
