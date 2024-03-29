import 'package:flutter_webrtc/flutter_webrtc.dart' as webRtc;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/sip_bloc.dart';
import 'package:voipmax/src/routes/routes.dart';

class SIPProvider extends Bloc implements SipUaHelperListener {
  final UaSettings _settings = UaSettings();

  @override
  void callStateChanged(Call call, CallState state) {
    SIPBloc sipController = Get.find();
    sipController.onCallStateChanged(call, state);
  }

  @override
  void onNewMessage(SIPMessageRequest msg) {}

  @override
  void onNewNotify(Notify ntf) {}

  @override
  void registrationStateChanged(RegistrationState state) {
    SIPBloc sipController = Get.find();
    sipController.onRegisterStateChanged(state);
  }

  @override
  void transportStateChanged(TransportState state) {}

  Future makeCall([bool voiceOnly = false, String? dest]) async {
    try {
      if (await Permission.microphone.status != PermissionStatus.granted) {
        await Permission.microphone.request();
      }
      if (!voiceOnly) {
        if (await Permission.microphone.status != PermissionStatus.granted) {
          await Permission.camera.request();
        }
      }
      final mediaConstraints = <String, dynamic>{
        'audio': true,
        'video': {
          'width': Get.width.toInt().toString(),
          'height': Get.height.toInt().toString(),
          'facingMode': 'user',
        }
      };

      webRtc.MediaStream mediaStream;
      if (voiceOnly) {
        mediaConstraints['video'] = !voiceOnly;
      }
      mediaStream =
          await webRtc.navigator.mediaDevices.getUserMedia(mediaConstraints);
      Get.toNamed(Routes.OUTGOING_CALL);
      baseSipUaHelper.call(dest ?? "",
          voiceonly: voiceOnly, mediaStream: mediaStream);
    } catch (e) {
      print(e);
    }
    return null;
  }

  void handleHangup() {}

  sipRegister(
      {String? webSocketUrl,
      Map<String, dynamic>? extraHeaders,
      bool? allowBadCertificate,
      String? uri,
      String? authorizationUser,
      String? password,
      String? displayName,
      String? userAgent,
      DtmfMode? dtmfMode}) {
    _settings.webSocketUrl = webSocketUrl ?? "";
    _settings.webSocketSettings.extraHeaders = extraHeaders ?? {};

    _settings.webSocketSettings.allowBadCertificate =
        allowBadCertificate ?? true;

    _settings.uri = uri ?? "";
    _settings.authorizationUser = authorizationUser ?? "";
    _settings.password = password ?? "";
    _settings.displayName = displayName ?? "";
    _settings.userAgent = userAgent ?? 'Dart SIP Client v1.0.0';
    _settings.dtmfMode = dtmfMode ?? DtmfMode.RFC2833;
    print(webSocketUrl);
    print(extraHeaders);
    print(authorizationUser);
    print(password);
    print(displayName);
    try {
      baseSipUaHelper.start(_settings);
    } catch (e) {
      print(e);
      rethrow;
    }
    // _settings.
  }

  unRegister() {
    baseSipUaHelper.unregister();
  }

  @override
  void onInit() {
    super.onInit();
    baseSipUaHelper.addSipUaHelperListener(this);
    // _loadSettings();
  }

  static final SIPProvider _instance = SIPProvider.internal();
  factory SIPProvider() => _instance;
  SIPProvider.internal();
}
