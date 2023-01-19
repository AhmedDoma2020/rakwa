class CustomFieldModel {
  int? code;
  bool? status;
  List<Data>? data;
  List<String>? keysCustomFields;

  CustomFieldModel({this.code, this.status, this.data, this.keysCustomFields});

  CustomFieldModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    keysCustomFields = json['customFields'].cast<String>();
  }

}

class Data {
  int? id;
  Null? categoryId;
  String? customFieldName;
  String? customFieldType;
  String? customFieldSeedValue;
  int? customFieldOrder;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.categoryId,
    this.customFieldName,
    this.customFieldType,
    this.customFieldSeedValue,
    this.customFieldOrder,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    customFieldName = json['custom_field_name'];
    customFieldType = json['custom_field_type'];
    customFieldSeedValue = json['custom_field_seed_value'];
    customFieldOrder = json['custom_field_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
