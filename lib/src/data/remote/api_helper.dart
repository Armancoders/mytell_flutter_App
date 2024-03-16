import 'dart:convert';
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:voipmax/src/core/values/values.dart';
import 'package:voipmax/src/data/models/extensions.dart';
import 'package:voipmax/src/data/models/sip_server_model.dart';
import 'package:voipmax/src/data/models/voicemail_model.dart';
import 'package:voipmax/src/repo.dart';

class AipHelper extends Bloc {
  // MyTelRepo repo = MyTelRepo();
  final _baseUrl = "https://core.mytell.org";

  static Future<SIPServerModel?> authenticateDevice(
      {required String userName, required String password}) async {
    SIPServerModel? sipServer;
    var endPoint = "/authenticate_device/";

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      "X-Api-Token": MytelValues.apiKey
    };

    var body = {
      "imei": MyTelRepo().uniqueDeviceId ?? "",
      // "imei": "35160581066102601",
      "password": password,
      // "password": "Missani.3018",
      "username": userName,
      // "username": "nima@webrtc.ertebaat.com"
    };

    try {
      var response = await http.post(
          Uri.parse("${AipHelper()._baseUrl}$endPoint"),
          body: json.encode(body),
          headers: headers);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        sipServer = SIPServerModel.fromJson(data);
      } else {
        sipServer = null;
      }
    } catch (e) {
      sipServer = null;
    }

    return sipServer;
  }

  static Future<void> deviceStatus({
    required String status,
  }) async {
    var endPoint = "/device_status/";

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      "X-Api-Token": MytelValues.apiKey
    };

    var body = {
      "extension":
          "${MyTelRepo().sipServer?.data?.extension ?? ""}@${MyTelRepo().sipServer?.data?.wssDomain}",
      // "imei": "35160581066102601",
      "imei": MyTelRepo().uniqueDeviceId ?? "",
      "status": status,
      "token_push": MyTelRepo().fcmToken
    };

    try {
      await http.post(Uri.parse("${AipHelper()._baseUrl}$endPoint"),
          body: json.encode(body), headers: headers);
    } catch (e) {
      print(e);
    }
  }

  static Future<Extensions?> extensionsStatus({
    required String domain,
  }) async {
    var endPoint = "/extensions_status/?domain=$domain";
    Extensions? extentions;
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      "X-Api-Token": MytelValues.apiKey
    };

    try {
      var response = await http
          .get(Uri.parse("${AipHelper()._baseUrl}$endPoint"), headers: headers);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        extentions = Extensions.fromJson(data);
      } else {
        extentions = null;
      }
    } catch (e) {
      print(e);
      extentions = null;
    }
    return extentions;
  }

  static Future<VoiceMailModel?> getVoiceMails({
    required String domain,
  }) async {
    var endPoint = "/list_voicemails/?username=$domain";
    VoiceMailModel? voiceMails;
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      "X-Api-Token": MytelValues.apiKey
    };

    try {
      var response = await http
          .get(Uri.parse("${AipHelper()._baseUrl}$endPoint"), headers: headers);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        voiceMails = VoiceMailModel.fromJson(data);
      } else {
        voiceMails = null;
      }
    } catch (e) {
      print(e);
      voiceMails = null;
    }
    return voiceMails;
  }

  static Future<VoiceMailModel?> doanloadVoiceMail(
      {required String domain, required String mUUID}) async {
    var endPoint = "/get_voicemail_message/?domain=$domain&message_uuid=$mUUID";
    VoiceMailModel? voiceMails;
    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      "X-Api-Token": MytelValues.apiKey
    };

    try {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      var path = await Directory("${appDocDirectory.path}/Voice Mails")
          .create(recursive: true);
      print(path.absolute);

      final taskId = await FlutterDownloader.enqueue(
          url: "${AipHelper()._baseUrl}$endPoint",
          headers: headers,
          savedDir: path.absolute.path,
          showNotification: false,
          openFileFromNotification: false,
          saveInPublicStorage: true);
      print(taskId);
    } catch (e) {
      print(e);
    }
    return voiceMails;
  }
}
