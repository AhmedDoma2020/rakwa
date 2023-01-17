// class ContactModel {
//   int? code;
//   bool? status;
//   List<Data>? data;

//   ContactModel({this.code, this.status, this.data});

//   ContactModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class ContactModel {
  int? id;
  String? faqsQuestion;
  String? faqsAnswer;
  int? faqsOrder;
  String? createdAt;
  String? updatedAt;

  ContactModel(
      {this.id,
      this.faqsQuestion,
      this.faqsAnswer,
      this.faqsOrder,
      this.createdAt,
      this.updatedAt});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    faqsQuestion = json['faqs_question'];
    faqsAnswer = json['faqs_answer'];
    faqsOrder = json['faqs_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['faqs_question'] = this.faqsQuestion;
    data['faqs_answer'] = this.faqsAnswer;
    data['faqs_order'] = this.faqsOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}