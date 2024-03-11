import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/data/models/recent_calls_model.dart';
import 'package:voipmax/src/data/provider/hive_provider.dart';
import 'package:voipmax/src/repo.dart';

class RecentCallsBloc extends Bloc {
  List<RecentCallsModel> recents = [];
  MyTelRepo repo = MyTelRepo();
  HiveDBProvider hiveProvider = Get.put(HiveDBProvider());

  logger({required RecentCallsModel? callLog}) {
    var call = RecentCallsModel(
        callee: callLog?.callee ?? "Unknown",
        caller: callLog?.caller ?? "Unknown");

    recents.insert(0, call);
    hiveProvider.saveRecentCallLog(callLog: recents);

    update();
  }

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    getRecentCalls();
  }

  getRecentCalls() async {
    recents = await hiveProvider.getRecentCalls();
    update();
  }
}
