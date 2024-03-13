// ignore_for_file: unnecessary_nullable_for_final_variable_declarations, unused_field
import 'dart:async';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:uuid/uuid.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/repo.dart';
import 'package:voipmax/src/routes/routes.dart';

class CallBloc extends Bloc with GetSingleTickerProviderStateMixin {
  late RTCVideoRenderer? localRenderer = RTCVideoRenderer();
  late RTCVideoRenderer? remoteRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  RxString callStatus = "".obs;
  Call? callStateController;
  RxBool isOnlyVoice = false.obs;
  Timer? _timer;
  RxString timeLabel = '00:00'.obs;
  RxBool audioMuted = false.obs;
  RxBool videoMuted = false.obs;
  RxBool speakerOn = false.obs;
  RxBool bluetoothOn = false.obs;
  RxString connectedBluetoothDevice = "Not connected".obs;
  RxBool hold = false.obs;
  String currentCallUUID = "";

  int secondsElapsed = 0;
  late int hours;
  late int minutes;
  late int seconds;

  MyTelRepo repo = MyTelRepo();

  Future<void> initRenderers() async {
    if (localRenderer != null) {
      await localRenderer!.initialize();
    }
    if (remoteRenderer != null) {
      await remoteRenderer!.initialize();
    }
  }

  void callOnStreams(CallState event) async {
    MediaStream? stream = event.stream;
    if (event.originator == 'local') {
      if (localRenderer != null) {
        localRenderer!.srcObject = stream;
      }

      _localStream = stream;
    }
    if (event.originator == 'remote') {
      if (remoteRenderer != null) {
        remoteRenderer!.srcObject = stream;
      }
      _remoteStream = stream;
    }

    update();
  }

  onHangUp() async {
    if (callStateController != null) {
      if (callStateController!.state != CallStateEnum.ENDED &&
          callStateController!.state != CallStateEnum.FAILED) {
        callStateController?.hangup();
      }
    }

    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    // await FlutterCallkitIncoming.endCall(currentCallUUID);
    await FlutterCallkitIncoming.endAllCalls();

    timeLabel.value = '00:00';
    _resetActionButtons();
    _cleanUp();
    Get.back();
  }

  void _cleanUp() {
    if (_localStream == null) return;
    _localStream?.getTracks().forEach((track) {
      track.stop();
    });
    _localStream!.dispose();
    _localStream = null;
  }

  void _resetActionButtons() {
    audioMuted.value = false;
    videoMuted.value = false;
    speakerOn.value = false;
    hold.value = false;
    connectedBluetoothDevice.value = "Not connected";
  }

  startTimer() async {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      secondsElapsed++;
      hours = secondsElapsed ~/ 3600;
      minutes = (secondsElapsed % 3600) ~/ 60;
      seconds = secondsElapsed % 60;
      timeLabel.value =
          '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    });
  }

  void switchCamera() {
    if (_localStream != null) {
      Helper.switchCamera(_localStream!.getVideoTracks()[0]);
      // setState(() {
      //   _mirror = !_mirror;
      // });
    }
  }

  void muteAudio({bool? mute}) {
    if (mute != null) {
      audioMuted.value = mute;
      return;
    }
    if (audioMuted.value) {
      audioMuted.value = false;
      callStateController!.unmute(true, false);
    } else {
      audioMuted.value = true;
      callStateController!.mute(true, false);
    }
  }

  void muteVideo() {
    if (videoMuted.value) {
      callStateController!.unmute(false, true);
    } else {
      callStateController!.mute(false, true);
    }
  }

  void handleHold({bool? doHold}) {
    if (doHold != null) {
      hold.value = doHold;
      return;
    }
    if (hold.value) {
      hold.value = false;
      callStateController!.unhold();
    } else {
      hold.value = true;
      callStateController!.hold();
    }
  }

  void toggleSpeaker() {
    if (_localStream != null) {
      speakerOn.value = !speakerOn.value;
      _localStream!.getAudioTracks()[0].enableSpeakerphone(speakerOn.value);
    }
  }

  void toggleBluetooth() async {
    if (await Permission.bluetooth.status != PermissionStatus.granted) {
      await Permission.bluetooth.request();
    }
    if (!bluetoothOn.value) {
      BluetoothEnable.enableBluetooth;
    }
    runBluetoothListeners();
  }

  runBluetoothListeners() async {
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      print(state);
      if (state == BluetoothAdapterState.on) {
        bluetoothOn.value = true;
        // usually start scanning, connecting, etc
      } else {
        bluetoothOn.value = false;
        // show an error to the user, etc
      }
    });

    // FlutterBluePlus.events.onConnectionStateChanged.listen((event) {
    //   if (event.connectionState == BluetoothConnectionState.connected) {
    //     connectedBluetoothDevice.value = event.device.platformName;
    //   }
    // });
  }

  void showIncomeCall({
    required String caller,
    required String callee,
  }) async {
    currentCallUUID = Uuid().v4();
    CallKitParams callKitParams = CallKitParams(
      id: currentCallUUID,
      nameCaller: callee,
      appName: 'My tel',
      // avatar: callee[0],
      handle: caller,
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: const NotificationParams(
        showNotification: true,
        isShowCallback: false,
        subtitle: 'Missed call',
        // callbackText: 'Call back',
      ),
      duration: 30000,
      android: const AndroidParams(
          isCustomNotification: true,
          isShowLogo: false,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: '#0955fa',
          actionColor: '#4CAF50',
          textColor: '#ffffff',
          incomingCallNotificationChannelName: "My tel Incoming Call",
          missedCallNotificationChannelName: "My tel Missed Call",
          isShowCallID: true),
      ios: const IOSParams(
        iconName: 'My tel',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 1,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: false,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );

    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
  }

  void saveRemoteUserDetails({required String callee, required String caller}) {
    repo.remoteUserDetails = {"callee": callee, "caller": caller};
    update();
  }

  void transferCall(String target) {
    callStateController!.refer(target);
  }

  void sendDTMF(String dtmf) {
    callStateController!.sendDTMF(dtmf);
  }

  @override
  void onInit() {
    super.onInit();
    FlutterCallkitIncoming.onEvent.listen((event) async {
      switch (event!.event) {
        case Event.actionCallIncoming:
          break;
        case Event.actionCallStart:
          break;
        case Event.actionCallAccept:
          await initRenderers();
          Get.toNamed(Routes.OUTGOING_CALL);
          await FlutterCallkitIncoming.setCallConnected(currentCallUUID);
          if (callStateController!.state != CallStateEnum.ENDED &&
              callStateController!.state != CallStateEnum.FAILED) {
            callStateController!.answer(
                {"audio": isOnlyVoice.value, "video": !isOnlyVoice.value});
          }
          break;
        case Event.actionCallDecline:
          onHangUp();
          break;
        case Event.actionCallEnded:
          onHangUp();
          break;
        case Event.actionCallTimeout:
          onHangUp();
          break;
        case Event.actionCallCallback:
          break;
        case Event.actionCallToggleHold:
          break;
        case Event.actionCallToggleMute:
          break;
        case Event.actionCallToggleDmtf:
          break;
        case Event.actionCallToggleGroup:
          break;
        case Event.actionCallToggleAudioSession:
          break;
        case Event.actionDidUpdateDevicePushTokenVoip:
          break;
        case Event.actionCallCustom:
          break;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    localRenderer!.dispose();
    remoteRenderer!.dispose();
  }

  static final CallBloc _instance = CallBloc.internal();
  factory CallBloc() => _instance;
  CallBloc.internal();
}
