import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/data/models/recent_calls_model.dart';
import 'package:voipmax/src/data/provider/hive_provider.dart';
import 'package:voipmax/src/repo.dart';

class RecentCallsBloc extends Bloc {
  List<RecentCallsModel> tempRecents = [];

  MyTelRepo repo = MyTelRepo();
  HiveDBProvider hiveProvider = Get.put(HiveDBProvider());
  List<RecentCallsModel> get recents => repo.recents;

  logger({required RecentCallsModel? callLog}) {
    var call = RecentCallsModel(
        callee: callLog?.callee ?? "Unknown",
        caller: callLog?.caller ?? "Unknown");

    recents.insert(0, call);
    hiveProvider.saveRecentCallLog(callLog: recents);

    update();
  }

  search({required String? q}) {
    if (q == null) {
      if (tempRecents.isNotEmpty) {
        repo.recents = tempRecents;
        tempRecents = [];
      }
      update();
      return;
    }

    if (tempRecents.isEmpty) {
      tempRecents = repo.recents;
    }
    repo.recents = [];
    for (var recent in tempRecents) {
      if (recent.caller.toLowerCase().contains(q.toLowerCase())) {
        repo.recents.add(recent);
      }
      if (recent.callee.isNotEmpty) {
        if (recent.callee.contains(q)) {
          repo.recents.add(recent);
        }
      }
    }
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
    repo.recents = await hiveProvider.getRecentCalls();
    update();
  }
}
