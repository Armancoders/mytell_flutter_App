class Extensions {
  List<ExtensionsData>? data;

  Extensions({this.data});

  Extensions.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ExtensionsData>[];
      json['data'].forEach((v) {
        data!.add(new ExtensionsData.fromJson(v));
      });
    }
  }
}

class ExtensionsData {
  String? extension;
  String? status;

  ExtensionsData({this.extension, this.status});

  ExtensionsData.fromJson(Map<String, dynamic> json) {
    extension = json['extension'];
    status = json['status'];
  }
}
