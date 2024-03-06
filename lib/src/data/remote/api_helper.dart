import 'dart:convert';
import 'package:voipmax/src/bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:voipmax/src/core/values/values.dart';
import 'package:voipmax/src/data/models/sip_server_model.dart';
import 'package:voipmax/src/repo.dart';

class AipHelper extends Bloc {
  MyTelRepo repo = MyTelRepo();
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
      "imei": MyTelRepo().imei ?? "",
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
}
