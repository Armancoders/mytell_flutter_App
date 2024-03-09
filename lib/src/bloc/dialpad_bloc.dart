// import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';

class DialPadBloc extends Bloc {
  final SIPBloc _sipController = Get.find();
  // final _sipController = Get.put(SIPBloc(), permanent: true);

  Future makeCall([bool voiceOnly = false, String? dest]) async {
    _sipController.makeCall(voiceOnly, dest);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
