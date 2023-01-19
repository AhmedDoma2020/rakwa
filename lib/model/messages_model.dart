class BaseMessageModel {
  BaseMessageModel({
    required this.code,
    required this.status,
    required this.subject,
    required this.message,
    required this.item,
  });
  late final int code;
  late final bool status;
  late final List<Subject> subject;
  late final List<Message> message;
  late final List<ItemModel> item;

  BaseMessageModel.fromJson(Map<String, dynamic> json){
    code = json['code']??500;
    status = json['status']??bool;
    subject = List.from(json['subject']).map((e)=>Subject.fromJson(e)).toList();
    message = List.from(json['message']).map((e)=>Message.fromJson(e)).toList();
    item = List.from(json['item']).map((e)=>ItemModel.fromJson(e)).toList();
  }


}

class Subject {
  Subject({
    required this.id,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String subject;
  late final String createdAt;
  late final String updatedAt;

  Subject.fromJson(Map<String, dynamic> json){
    id = json['id'];
    subject = json['subject'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}

class Message {
  Message({
    required this.id,
    required this.threadId,
    required this.userId,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
  late final int id;
  late final int threadId;
  late final int userId;
  late final String body;
  late final String createdAt;
  late final String updatedAt;
  late final User user;

  Message.fromJson(Map<String, dynamic> json){
    id = json['id'];
    threadId = json['thread_id'];
    userId = json['user_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = User.fromJson(json['user']);
  }


}

class User {
  User({
    required this.id,
    required this.name,
    required this.userImage,

  });
  late final int id;
  late final String name;
  late final String userImage;


  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    userImage = json['user_image'];

  }


}


class ItemModel {
  ItemModel({
    required this.id,
    required this.threadId,
    required this.itemId,
    required this.createdAt,
    required this.updatedAt,
    required this.itemCategoriesName,
  });
  late final int id;
  late final int threadId;
  late final int itemId;
  late final String createdAt;
  late final String updatedAt;
  late final String itemCategoriesName;

  ItemModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    threadId = json['thread_id'];
    itemId = json['item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemCategoriesName = json['item']["item_categories_string"];
  }


}

