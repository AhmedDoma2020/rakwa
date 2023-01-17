class AboutModel {
  int? code;
  bool? status;
  String? data;

  AboutModel({this.code, this.status, this.data});

  AboutModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}