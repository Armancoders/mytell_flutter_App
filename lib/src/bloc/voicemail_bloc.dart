import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/data/models/voicemail_model.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';

class VoiceMailBloc extends Bloc {
  MyTelRepo repo = MyTelRepo();
  final player = AudioPlayer();
  RxString remainedPlayerTime = "".obs;
  VoiceMailData voiceMail = VoiceMailData();
  Duration? playerDuration;

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
    initDownloader();
    runPlayerListeners();
  }

  void initDownloader() async {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  }

  Future<void> handlePlayVoiceMail() async {
    var tasks = await FlutterDownloader.loadTasks();
    if (voiceMail.playing!.value) {
      await player.pause();
      return;
    }
    if (playerDuration != null) {
      if (playerDuration!.inSeconds > 0) {
        await player.resume();
        return;
      }
    }

    voiceMail.downloading!.value = false;
    voiceMail.playing!.value = false;
    if (tasks != null) {
      var task = tasks.firstWhereOrNull(
          (task) => task.url.contains(voiceMail.voicemailMessageUuid ?? ""));

      if (task != null) {
        voiceMail.playing!.value = true;
        await player
            .play(DeviceFileSource("${task.savedDir}/${task.filename}"));
        return;
      }
    }

    voiceMail.downloading!.value = true;

    await AipHelper.doanloadVoiceMail(
            domain: repo.sipServer?.data?.wssDomain ?? "",
            mUUID: voiceMail.voicemailMessageUuid ?? "")
        .then((value) {
      handlePlayVoiceMail();
    });
  }

  void runPlayerListeners() {
    player.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.paused) {
        voiceMail.playing!.value = false;
      } else if (event == PlayerState.playing) {
        voiceMail.playing!.value = true;
      }
    });
    player.eventStream.listen((event) {
      try {
        playerDuration = event.position;
        var test = int.parse(voiceMail.messageLength ?? "0") -
            event.position!.inSeconds;
        int sec = test % 60;
        int min = (test / 60).floor();
        String minute = min.toString().length <= 1 ? "0$min" : "$min";
        String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
        remainedPlayerTime.value = "$minute:$second";
      } catch (e) {
        print(e);
      }
    });

    player.onPlayerComplete.listen((event) {
      voiceMail.playing!.value = false;
      remainedPlayerTime.value = "";
    });
  }
}
