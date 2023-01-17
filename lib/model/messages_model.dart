class MessagesModel {
  int? code;
  bool? status;
  Data? data;
  Message? message;

  MessagesModel({this.code, this.status, this.data, this.message});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? subject;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Data({this.id, this.subject, this.createdAt, this.updatedAt, this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject'] = this.subject;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Message {
  int? id;
  int? threadId;
  int? userId;
  String? body;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Message(
      {this.id,
      this.threadId,
      this.userId,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    threadId = json['thread_id'];
    userId = json['user_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['thread_id'] = this.threadId;
    data['user_id'] = this.userId;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}