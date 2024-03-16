import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';

class VoiceMailBloc extends Bloc {
  MyTelRepo repo = MyTelRepo();

  Future<void> getVoiceMails() async {
    repo.voiceMails = await AipHelper.getVoiceMails(
        domain:
            "${repo.sipServer?.data?.extension ?? ""}@${repo.sipServer?.data?.wssDomain ?? ""}");
    setMessageLngthTimeLabel();
    update();
  }

  setMessageLngthTimeLabel() {
    if (repo.voiceMails != null) {
      if (repo.voiceMails?.data?.isNotEmpty ?? false) {
        for (var voice in repo.voiceMails!.data!) {
          int sec = int.parse(voice.messageLength ?? "0") % 60;
          int min = (int.parse(voice.messageLength ?? "0") / 60).floor();
          String minute = min.toString().length <= 1 ? "0$min" : "$min";
          String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
          voice.timeLengthLabel = "$minute:$second";

          voice.createdDate = DateTime.fromMillisecondsSinceEpoch(
              (int.parse(voice.createdEpoch ?? "0") * 1000));
          update();
        }
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    getVoiceMails();
  }
}
