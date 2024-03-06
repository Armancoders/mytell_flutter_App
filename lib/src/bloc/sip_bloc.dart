import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/call_bloc.dart';
import 'package:voipmax/src/core/values/values.dart';
import 'package:voipmax/src/data/provider/sip_provider.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/repo.dart';
import 'package:voipmax/src/routes/routes.dart';

class SIPBloc extends Bloc {
  final _sipProvider = Get.put(SIPProvider(), permanent: true);
  RxString callState = "".obs;
  CallBloc callController = Get.find();
  MyTelRepo repo = MyTelRepo();

  register() {
    final Map<String, String> wsExtraHeaders = {
      "${repo.sipServer?.data?.stun?.replaceRange(repo.sipServer?.data?.stun?.indexOf(":") ?? 0, null, "")}":
          "${repo.sipServer?.data?.stun?.replaceRange(0, repo.sipServer?.data?.stun?.indexOf(":"), "")}"
    };
    _sipProvider.sipRegister(
        // webSocketUrl: "wss://webrtc.ertebaat.com:7443/",
        webSocketUrl:
            "wss://${repo.sipServer?.data?.wssDomain ?? ""}${repo.sipServer?.data?.wssPort.toString().isNotEmpty ?? false ? ":${repo.sipServer?.data?.wssPort.toString()}/" : ""}",
        extraHeaders: wsExtraHeaders,
        // authorizationUser: "1000",
        authorizationUser: repo.sipServer?.data?.extension ?? "",
        // password: "v2jL4Gk%%uBVEcbbcnL4",
        password: repo.sipServer?.data?.password,
        // uri: "1000@webrtc.ertebaat.com",
        uri:
            "${repo.sipServer?.data?.extension ?? ""}@${repo.sipServer?.data?.wssDomain}",
        displayName: "Navid");
  }

  makeCall([bool voiceOnly = false]) {
    callController.isOnlyVoice.value = voiceOnly;
    _sipProvider.makeCall(voiceOnly);
  }

  onCallStateChanged(Call call, CallState state) async {
    callController.callStatus.value = call.state.name;
    callController.callStateController = call;
    switch (call.state) {
      case CallStateEnum.STREAM:
        Get.toNamed(Routes.OUTGOING_CALL);
        await callController.initRenderers();
        callController.callOnStreams(state);
        break;
      case CallStateEnum.ENDED:
      case CallStateEnum.FAILED:
        callController.onHangUp();

        ///Todo
        // await callController.initRenderers();
        // callController.callOnStreams(state);
        break;
      case CallStateEnum.UNMUTED:
      case CallStateEnum.MUTED:
      case CallStateEnum.CONNECTING:
      case CallStateEnum.PROGRESS:
      case CallStateEnum.ACCEPTED:
      case CallStateEnum.CONFIRMED:
      case CallStateEnum.HOLD:
      case CallStateEnum.UNHOLD:
      case CallStateEnum.NONE:
      case CallStateEnum.CALL_INITIATION:
      case CallStateEnum.REFER:
        break;
    }
  }

  Future<void> onRegisterStateChanged(RegistrationState state) async {
    await AipHelper.deviceStatus(
        status: state.state == RegistrationStateEnum.REGISTERED
            ? MytelValues.deviceRegisteredStatus
            : MytelValues.deviceNotRegisteredStatus);
  }

  @override
  void onInit() {
    super.onInit();
    register();
  }
}
