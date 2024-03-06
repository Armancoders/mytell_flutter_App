import 'package:device_imei/device_imei.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/data/models/sip_server_model.dart';

class MyTelRepo extends Bloc {
  SIPServerModel? sipServer;
  String? imei;

  Future getIMEI() async {
    try {
      Permission.phone.request();
      imei = await UniqueIdentifier.serial;
      print(imei);
    } catch (e) {
      imei = null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getIMEI();
  }

  static final MyTelRepo _instance = MyTelRepo.internal();
  factory MyTelRepo() => _instance;
  MyTelRepo.internal();
}
