import 'package:get/get.dart';
import 'package:sip_ua/sip_ua.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:voipmax/src/bloc/call_bloc.dart';
import 'package:voipmax/src/bloc/recent_bloc.dart';
import 'package:voipmax/src/core/values/values.dart';
import 'package:voipmax/src/data/models/recent_calls_model.dart';
import 'package:voipmax/src/data/provider/sip_provider.dart';
import 'package:voipmax/src/data/remote/api_helper.dart';
import 'package:voipmax/src/data/services/foreground_service.dart';
import 'package:voipmax/src/repo.dart';
import 'package:voipmax/src/routes/routes.dart';

class SIPBloc extends Bloc {
  final _sipProvider = Get.put(SIPProvider(), permanent: true);
  RxString callState = "".obs;
  CallBloc callController = Get.find();
  MyTelRepo repo = MyTelRepo();
  RxString registrationStatus = MytelValues.deviceNotRegisteredStatus.obs;
  MyTellForeGroundService foreGroundService = Get.find();
  RxBool registering = false.obs;
  String? outGoingCalleeName = "";
  register() {
    if (repo.sipServer == null) return;
    registering.value = true;
    final Map<String, String> wsExtraHeaders = {
      "${repo.sipServer?.data?.stun?.replaceRange(repo.sipServer?.data?.stun?.indexOf(":") ?? 0, null, "")}":
          "${repo.sipServer?.data?.stun?.replaceRange(0, repo.sipServer?.data?.stun?.indexOf(":"), "")}"
    };
    try {
      _sipProvider.sipRegister(
          webSocketUrl:
              "wss://${repo.sipServer?.data?.wssDomain ?? ""}${repo.sipServer?.data?.wssPort.toString().isNotEmpty ?? false ? ":${repo.sipServer?.data?.wssPort.toString()}/" : ""}",
          extraHeaders: wsExtraHeaders,
          authorizationUser: repo.sipServer?.data?.extension ?? "",
          password: repo.sipServer?.data?.password,
          uri:
              "${repo.sipServer?.data?.extension ?? ""}@${repo.sipServer?.data?.wssDomain}",
          displayName: repo.sipServer?.data?.extension ?? "");
    } catch (e) {
      registering.value = false;
      registrationStatus.value = MytelValues.deviceNotRegisteredStatus;
    }
  }

  unRegister() {
    _sipProvider.unRegister();
  }

  makeCall([bool voiceOnly = false, String? dest, String? calle]) {
    callController.isOnlyVoice.value = voiceOnly;
    RecentCallsBloc recentCallsController = Get.find();
    outGoingCalleeName = calle;
    recentCallsController.logger(
        callLog: RecentCallsModel(callee: calle ?? "", caller: dest));
    _sipProvider.makeCall(voiceOnly, dest);
  }

  onCallStateChanged(Call call, CallState state) async {
    callController.callStatus.value = call.state.name;
    callController.callStateController = call;
    switch (call.state) {
      case CallStateEnum.STREAM:
        if (callController.localRenderer != null ||
            callController.remoteRenderer != null) {
          await callController.initRenderers();
        }
        callController.callOnStreams(state);
        break;
      case CallStateEnum.ENDED:
      case CallStateEnum.FAILED:
        callController.onHangUp();
        await foreGroundService.stopService();

        ///Todo
        // await callController.initRenderers();
        // callController.callOnStreams(state);
        break;
      case CallStateEnum.UNMUTED:
        break;
      case CallStateEnum.MUTED:
        break;
      case CallStateEnum.CONNECTING:
        break;
      case CallStateEnum.PROGRESS:
        break;
      case CallStateEnum.ACCEPTED:
        break;
      case CallStateEnum.CONFIRMED:
        callController.startTimer();
        break;
      case CallStateEnum.HOLD:
        break;
      case CallStateEnum.UNHOLD:
        break;
      case CallStateEnum.NONE:
        break;
      case CallStateEnum.CALL_INITIATION:
        callController.saveRemoteUserDetails(
            callee: call.direction != 'INCOMING'
                ? outGoingCalleeName ?? call.remote_display_name ?? "Unknown"
                : call.remote_display_name ?? "Unknown",
            caller: call.remote_identity ?? "Unknown");
        if (callController.callStatus.value !=
            CallStateEnum.CALL_INITIATION.name) return;
        foreGroundService.startForeGroundService();
        if (call.direction == 'INCOMING') {
          callController.showIncomeCall(
              caller: call.remote_display_name ?? "Unknown",
              callee: call.remote_identity ?? "Unknown");
          return;
        }
        await callController.initRenderers();
        Get.toNamed(Routes.OUTGOING_CALL);
        break;
      case CallStateEnum.REFER:
        break;
    }
  }

  Future<void> onRegisterStateChanged(RegistrationState state) async {
    registering.value = false;
    registrationStatus.value = state.state == RegistrationStateEnum.REGISTERED
        ? MytelValues.deviceRegisteredStatus
        : MytelValues.deviceNotRegisteredStatus;
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
