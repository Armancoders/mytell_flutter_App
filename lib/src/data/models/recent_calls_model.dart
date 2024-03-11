import 'package:hive/hive.dart';
part 'recent_calls_model.g.dart';

@HiveType(typeId: 0)
class RecentCallsModel extends HiveObject {
  @HiveField(0)
  late var callee;
  @HiveField(1)
  late var caller;

  RecentCallsModel({this.callee, this.caller});
}
