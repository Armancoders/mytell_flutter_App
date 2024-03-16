class VoiceMailModel {
  List<VoiceMailData>? data;

  VoiceMailModel({this.data});

  VoiceMailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VoiceMailData>[];
      json['data'].forEach((v) {
        data!.add(VoiceMailData.fromJson(v));
      });
    }
  }
}

class VoiceMailData {
  String? callerIdName;
  String? callerIdNumber;
  String? createdEpoch;
  String? messageLength;
  String? messageStatus;
  String? voicemailMessageUuid;
  String? timeLengthLabel;
  DateTime? createdDate;

  VoiceMailData(
      {this.callerIdName,
      this.callerIdNumber,
      this.createdEpoch,
      this.messageLength,
      this.messageStatus,
      this.voicemailMessageUuid,
      this.timeLengthLabel,
      this.createdDate});

  VoiceMailData.fromJson(Map<String, dynamic> json) {
    callerIdName = json['caller_id_name'];
    callerIdNumber = json['caller_id_number'];
    createdEpoch = json['created_epoch'];
    messageLength = json['message_length'];
    messageStatus = json['message_status'];
    voicemailMessageUuid = json['voicemail_message_uuid'];
    timeLengthLabel = "00:00";
    createdDate = DateTime(DateTime.now().year);
  }
}
