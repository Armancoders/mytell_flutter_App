
import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';

abstract class Bloc extends GetxController{
  final SIPUAHelper baseSipUaHelper = SIPUAHelper();
}