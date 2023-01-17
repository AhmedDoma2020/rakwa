// class ArticalModel {
//   int? code;
//   bool? status;
//   DataModel? data;

//   ArticalModel({this.code, this.status, this.data});

//   ArticalModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     status = json['status'];
//     data = json['data'] != null ? new DataModel.fromJson(json['data']) : null;
//   }

  
// }

// class DataModel {
//  late Posts? posts;

//   DataModel();

//   DataModel.fromJson(Map<String, dynamic> json) {
//     posts = json['posts'] != null ? new Posts.fromJson(json['posts']) : null;
//   }


// }

// class Posts {
//   int? currentPage;
//   List<Data>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   Null? nextPageUrl;
//   String? path;
//   int? perPage;
//   Null? prevPageUrl;
//   int? to;
//   int? total;

//   Posts(
//       {this.currentPage,
//       this.data,
//       this.firstPageUrl,
//       this.from,
//       this.lastPage,
//       this.lastPageUrl,
//       this.nextPageUrl,
//       this.path,
//       this.perPage,
//       this.prevPageUrl,
//       this.to,
//       this.total});

//   Posts.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }

class ArticalModel {
  String? id;
  String? slug;
  String? title;
  String? summary;
  String? body;
  String? publishedAt;
  String? featuredImage;
  String? featuredImageCaption;
  int? userId;
  Meta? meta;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  String? readTime;

  ArticalModel();

  ArticalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    summary = json['summary'];
    body = json['body'];
    publishedAt = json['published_at'];
    featuredImage = json['featured_image'];
    featuredImageCaption = json['featured_image_caption'];
    userId = json['user_id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    readTime = json['read_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['body'] = this.body;
    data['published_at'] = this.publishedAt;
    data['featured_image'] = this.featuredImage;
    data['featured_image_caption'] = this.featuredImageCaption;
    data['user_id'] = this.userId;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['read_time'] = this.readTime;
    return data;
  }
}

class Meta {
  String? description;
  String? title;
  String? canonicalLink;

  Meta({this.description, this.title, this.canonicalLink});

  Meta.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
    canonicalLink = json['canonical_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['title'] = this.title;
    data['canonical_link'] = this.canonicalLink;
    return data;
  }
}