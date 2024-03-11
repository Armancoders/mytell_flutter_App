// import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/recent_bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/data/models/recent_calls_model.dart';
import 'package:voipmax/src/repo.dart';

class DialPadBloc extends Bloc {
  final SIPBloc sipController = Get.find();
  // final _sipController = Get.put(SIPBloc(), permanent: true);
  RecentCallsBloc recentCallsController = Get.find();
  MyTelRepo repo = MyTelRepo();

  Future makeCall([bool voiceOnly = false, String? dest]) async {
    sipController.makeCall(voiceOnly, dest);
    recentCallsController.logger(
        callLog: RecentCallsModel(callee: dest, caller: dest));
  }

  @override
  void onInit() {
    super.onInit();
  }
}
