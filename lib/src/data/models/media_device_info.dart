import 'package:get/get.dart';

class BluetoothMediaDeviceInfo {
  String? id;
  String? name;
  String? kind;
  RxBool? isConnected;

  BluetoothMediaDeviceInfo(
      {required this.id,
      required this.name,
      required this.kind,
      required this.isConnected});
}
