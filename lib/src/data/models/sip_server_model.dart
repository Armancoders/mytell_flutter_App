class SIPServerModel {
  Data? data;

  SIPServerModel({this.data});

  SIPServerModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? wssDomain;
  int? wssPort;
  var wssSuffix;
  String? extension;
  String? password;
  String? stun;

  Data(
      {this.wssDomain,
      this.wssPort,
      this.wssSuffix,
      this.extension,
      this.password,
      this.stun});

  Data.fromJson(Map<String, dynamic> json) {
    wssDomain = json['wss_domain'];
    wssPort = json['wss_port'];
    wssSuffix = json['wss_suffix'];
    extension = json['extension'];
    password = json['password'];
    stun = json['stun'];
  }
}
