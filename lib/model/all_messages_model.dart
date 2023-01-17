class AllMessagesModel {
  int? id;
  String? subject;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  AllMessagesModel();

  AllMessagesModel.fromJson(Map<String, dynamic> json) {
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
