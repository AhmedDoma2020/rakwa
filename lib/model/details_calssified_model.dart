import 'package:rakwa/Core/utils/extensions.dart';

class DetailsClassifiedModel {
  int? code;
  bool? status;
  Classified? classified;
  List<NearbyItems>? nearbyItems;
  List<SimilarItems>? similarItems;
  List<Reviews>? reviews;
  String? url;
  DetailsClassifiedModel(
      {this.code,
      this.status,
      this.classified,
      this.nearbyItems,
      this.similarItems,
      this.reviews,
      this.url});

  DetailsClassifiedModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    printDM("enter =>  B1");

    classified = json['classified'] != null
        ? new Classified.fromJson(json['classified'])
        : null;
    printDM("enter =>  B2");

    if (json['nearby_items'] != null) {
      nearbyItems = <NearbyItems>[];
      json['nearby_items'].forEach((v) {
        nearbyItems!.add(new NearbyItems.fromJson(v));
      });
    }
    printDM("enter =>  B3");
    if (json['similar_items'] != null) {
      similarItems = <SimilarItems>[];
      json['similar_items'].forEach((v) {
        similarItems!.add(new SimilarItems.fromJson(v));
      });
    }
    printDM("enter =>  B4");
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    printDM("enter =>  B5");
    url = json['url'];
  }

}

class Classified {
  int? id;
  int? userId;
  dynamic categoryId;
  int? itemStatus;
  int? itemFeatured;
  int? itemFeaturedByAdmin;
  String? itemTitle;
  String? itemSlug;
  String? itemDescription;
  String? itemImage;
  dynamic itemAddress;
  int? itemAddressHide;
  int? cityId;
  int? stateId;
  int? countryId;
  dynamic itemPostalCode;
  dynamic itemPrice;
  dynamic itemWebsite;
  String? itemPhone;
  String? itemLat;
  String? itemLng;
  String? createdAt;
  String? updatedAt;
  dynamic itemSocialFacebook;
  dynamic itemSocialTwitter;
  dynamic itemSocialLinkedin;
  String? itemFeaturesString;
  String? itemImageMedium;
  String? itemImageSmall;
  String? itemImageTiny;
  String? itemCategoriesString;
  String? itemImageBlur;
  dynamic itemYoutubeId;
  dynamic itemAverageRating;
  String? itemLocationStr;
  int? itemType;
  dynamic itemHourTimeZone;
  int? itemHourShowHours;
  String? itemSocialWhatsapp;
  dynamic itemSocialInstagram;
  dynamic price;
  dynamic email;
  List<Galleries>? galleries;
  List<AllCategories>? allCategories;
  List<Features>? features;
  List? claims;
  StateModel? state;
  City? city;
  Country? country;
  List? itemHours;
  List? itemHourExceptions;
  List? savedByUsers;

  Classified(
      {this.id,
      this.userId,
      this.categoryId,
      this.itemStatus,
      this.itemFeatured,
      this.itemFeaturedByAdmin,
      this.itemTitle,
      this.itemSlug,
      this.itemDescription,
      this.itemImage,
      this.itemAddress,
      this.itemAddressHide,
      this.cityId,
      this.stateId,
      this.countryId,
      this.itemPostalCode,
      this.itemPrice,
      this.itemWebsite,
      this.itemPhone,
      this.itemLat,
      this.itemLng,
      this.createdAt,
      this.updatedAt,
      this.itemSocialFacebook,
      this.itemSocialTwitter,
      this.itemSocialLinkedin,
      this.itemFeaturesString,
      this.itemImageMedium,
      this.itemImageSmall,
      this.itemImageTiny,
      this.itemCategoriesString,
      this.itemImageBlur,
      this.itemYoutubeId,
      this.itemAverageRating,
      this.itemLocationStr,
      this.itemType,
      this.itemHourTimeZone,
      this.itemHourShowHours,
      this.itemSocialWhatsapp,
      this.itemSocialInstagram,
      this.price,
      this.email,
      this.galleries,
      this.allCategories,
      this.features,
      this.claims,
      this.state,
      this.city,
      this.country,
      this.itemHours,
      this.itemHourExceptions,
      this.savedByUsers});

  Classified.fromJson(Map<String, dynamic> json) {
    printDM("enter =>  1");
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    itemStatus = json['item_status'];
    itemFeatured = json['item_featured'];
    itemFeaturedByAdmin = json['item_featured_by_admin'];
    itemTitle = json['item_title'];
    itemSlug = json['item_slug'];
    itemDescription = json['item_description'];
    itemImage = json['item_image'];
    itemAddress = json['item_address'];
    itemAddressHide = json['item_address_hide'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    printDM("enter =>  1>2");
    itemPostalCode = json['item_postal_code'];
    itemPrice = json['item_price'];
    itemWebsite = json['item_website'];
    itemPhone = json['item_phone'];
    itemLat = json['item_lat'];
    itemLng = json['item_lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemSocialFacebook = json['item_social_facebook'];
    itemSocialTwitter = json['item_social_twitter'];
    itemSocialLinkedin = json['item_social_linkedin'];
    itemFeaturesString = json['item_features_string'];
    itemImageMedium = json['item_image_medium'];
    itemImageSmall = json['item_image_small'];
    itemImageTiny = json['item_image_tiny'];
    itemCategoriesString = json['item_categories_string'];
    itemImageBlur = json['item_image_blur'];
    itemYoutubeId = json['item_youtube_id'];
    itemAverageRating = json['item_average_rating'];
    itemLocationStr = json['item_location_str'];
    printDM("enter =>  1>3");
    itemType = json['item_type'];
    itemHourTimeZone = json['item_hour_time_zone'];
    itemHourShowHours = json['item_hour_show_hours'];
    itemSocialWhatsapp = json['item_social_whatsapp'];
    itemSocialInstagram = json['item_social_instagram'];
    price = json['price'];
    email = json['email'];
    printDM("enter =>  1>4");
    if (json['galleries'] != null) {
      galleries = <Galleries>[];
      json['galleries'].forEach((v) {
        galleries!.add(new Galleries.fromJson(v));
      });
    }
    printDM("enter =>  1>5");
    if (json['all_categories'] != null) {
      allCategories = <AllCategories>[];
      json['all_categories'].forEach((v) {
        allCategories!.add(new AllCategories.fromJson(v));
      });
    }
    printDM("enter =>  1>6");
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    printDM("enter =>  1>7");
    // if (json['claims'] != null) {
    //   claims = <Null>[];
    //   json['claims'].forEach((v) {
    //     claims!.add(new Null.fromJson(v));
    //   });
    // }
    state =
        json['state'] != null ? new StateModel.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    printDM("enter =>  1>8");
    // if (json['item_hours'] != null) {
    //   itemHours = <Null>[];
    //   json['item_hours'].forEach((v) {
    //     itemHours!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['item_hour_exceptions'] != null) {
    //   itemHourExceptions = <Null>[];
    //   json['item_hour_exceptions'].forEach((v) {
    //     itemHourExceptions!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['saved_by_users'] != null) {
    //   savedByUsers = <Null>[];
    //   json['saved_by_users'].forEach((v) {
    //     savedByUsers!.add(new Null.fromJson(v));
    //   });
    // }
  }

}

class Galleries {
  int? id;
  int? itemId;
  dynamic classifiedId;
  String? itemImageGalleryName;
  String? itemImageGalleryThumbName;
  dynamic itemImageGallerySize;
  String? createdAt;
  String? updatedAt;

  Galleries(
      {this.id,
      this.itemId,
      this.classifiedId,
      this.itemImageGalleryName,
      this.itemImageGalleryThumbName,
      this.itemImageGallerySize,
      this.createdAt,
      this.updatedAt});

  Galleries.fromJson(Map<String, dynamic> json) {
    printDM("enter =>  2");

    id = json['id'];
    itemId = json['item_id'];
    classifiedId = json['classified_id'];
    itemImageGalleryName = json['item_image_gallery_name'];
    itemImageGalleryThumbName = json['item_image_gallery_thumb_name'];
    itemImageGallerySize = json['item_image_gallery_size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['classified_id'] = this.classifiedId;
    data['item_image_gallery_name'] = this.itemImageGalleryName;
    data['item_image_gallery_thumb_name'] = this.itemImageGalleryThumbName;
    data['item_image_gallery_size'] = this.itemImageGallerySize;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AllCategories {
  int? id;
  String? categoryName;
  String? categorySlug;
  String? categoryIcon;
  String? createdAt;
  String? updatedAt;
  int? categoryParentId;
  String? categoryDescription;
  String? categoryImage;
  int? categoryThumbnailType;
  int? categoryHeaderBackgroundType;
  String? categoryHeaderBackgroundColor;
  String? categoryHeaderBackgroundImage;
  String? categoryHeaderBackgroundYoutubeVideo;
  Pivot? pivot;

  AllCategories(
      {this.id,
      this.categoryName,
      this.categorySlug,
      this.categoryIcon,
      this.createdAt,
      this.updatedAt,
      this.categoryParentId,
      this.categoryDescription,
      this.categoryImage,
      this.categoryThumbnailType,
      this.categoryHeaderBackgroundType,
      this.categoryHeaderBackgroundColor,
      this.categoryHeaderBackgroundImage,
      this.categoryHeaderBackgroundYoutubeVideo,
      this.pivot});

  AllCategories.fromJson(Map<String, dynamic> json) {
    printDM("enter =>  1>5");

    id = json['id'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    categoryIcon = json['category_icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryParentId = json['category_parent_id'];
    categoryDescription = json['category_description'];
    categoryImage = json['category_image']??"";
    categoryThumbnailType = json['category_thumbnail_type'];
    categoryHeaderBackgroundType = json['category_header_background_type'];
    categoryHeaderBackgroundColor = json['category_header_background_color']??"";
    categoryHeaderBackgroundImage = json['category_header_background_image']??"";
    categoryHeaderBackgroundYoutubeVideo =
        json['category_header_background_youtube_video']??"";
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['category_slug'] = this.categorySlug;
    data['category_icon'] = this.categoryIcon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_parent_id'] = this.categoryParentId;
    data['category_description'] = this.categoryDescription;
    data['category_image'] = this.categoryImage;
    data['category_thumbnail_type'] = this.categoryThumbnailType;
    data['category_header_background_type'] = this.categoryHeaderBackgroundType;
    data['category_header_background_color'] =
        this.categoryHeaderBackgroundColor;
    data['category_header_background_image'] =
        this.categoryHeaderBackgroundImage;
    data['category_header_background_youtube_video'] =
        this.categoryHeaderBackgroundYoutubeVideo;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? classifiedId;
  int? classifiedCategoryId;
  String? createdAt;
  String? updatedAt;

  Pivot(
      {this.classifiedId,
      this.classifiedCategoryId,
      this.createdAt,
      this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    classifiedId = json['classified_id'];
    classifiedCategoryId = json['classified_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classified_id'] = this.classifiedId;
    data['classified_category_id'] = this.classifiedCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Features {
  int? id;
  int? itemId;
  int? customFieldId;
  String? itemFeatureValue;
  String? createdAt;
  String? updatedAt;
  int? classifiedId;

  Features(
      {this.id,
      this.itemId,
      this.customFieldId,
      this.itemFeatureValue,
      this.createdAt,
      this.updatedAt,
      this.classifiedId});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    customFieldId = json['custom_field_id'];
    itemFeatureValue = json['item_feature_value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    classifiedId = json['classified_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['custom_field_id'] = this.customFieldId;
    data['item_feature_value'] = this.itemFeatureValue;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['classified_id'] = this.classifiedId;
    return data;
  }
}

class StateModel {
  int? id;
  int? countryId;
  String? stateName;
  String? stateAbbr;
  String? stateSlug;
  String? stateCountryAbbr;


  StateModel(
      {this.id,
      this.countryId,
      this.stateName,
      this.stateAbbr,
      this.stateSlug,
      this.stateCountryAbbr,
     });

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    stateName = json['state_name'];
    stateAbbr = json['state_abbr'];
    stateSlug = json['state_slug'];
    stateCountryAbbr = json['state_country_abbr'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['state_name'] = this.stateName;
    data['state_abbr'] = this.stateAbbr;
    data['state_slug'] = this.stateSlug;
    data['state_country_abbr'] = this.stateCountryAbbr;

    return data;
  }
}

class City {
  int? id;
  int? stateId;
  String? cityName;
  String? cityState;
  String? citySlug;
  String? cityLat;
  String? cityLng;


  City(
      {this.id,
      this.stateId,
      this.cityName,
      this.cityState,
      this.citySlug,
      this.cityLat,
      this.cityLng,
     });

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
    cityState = json['city_state'];
    citySlug = json['city_slug'];
    cityLat = json['city_lat'];
    cityLng = json['city_lng'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_id'] = this.stateId;
    data['city_name'] = this.cityName;
    data['city_state'] = this.cityState;
    data['city_slug'] = this.citySlug;
    data['city_lat'] = this.cityLat;
    data['city_lng'] = this.cityLng;

    return data;
  }
}

class Country {
  int? id;
  String? countryName;
  String? countryAbbr;
  String? countrySlug;

  int? countryStatus;

  Country(
      {this.id,
      this.countryName,
      this.countryAbbr,
      this.countrySlug,

      this.countryStatus});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    countryAbbr = json['country_abbr'];
    countrySlug = json['country_slug'];

    countryStatus = json['country_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_name'] = this.countryName;
    data['country_abbr'] = this.countryAbbr;
    data['country_slug'] = this.countrySlug;

    data['country_status'] = this.countryStatus;
    return data;
  }
}

class NearbyItems {
  int? id;
  int? userId;
  int? categoryId;
  int? itemStatus;
  int? itemFeatured;
  int? itemFeaturedByAdmin;
  String? itemTitle;
  String? itemSlug;
  String? itemDescription;
  String? itemImage;
  String? itemAddress;
  int? itemAddressHide;
  int? cityId;
  int? stateId;
  int? countryId;
  String? itemPostalCode;
  String? itemPrice;
  String? itemWebsite;
  String? itemPhone;
  String? itemLat;
  String? itemLng;
  String? createdAt;
  String? updatedAt;
  String? itemSocialFacebook;
  String? itemSocialTwitter;
  String? itemSocialLinkedin;
  String? itemFeaturesString;
  String? itemImageMedium;
  String? itemImageSmall;
  String? itemImageTiny;
  String? itemCategoriesString;
  String? itemImageBlur;
  String? itemYoutubeId;
  dynamic itemAverageRating;
  String? itemLocationStr;
  int? itemType;
  String? itemHourTimeZone;
  int? itemHourShowHours;
  String? itemSocialWhatsapp;
  dynamic itemSocialInstagram;
  int? price;
  String? email;
  dynamic distance;
  StateModel? state;
  City? city;
  User? user;

  NearbyItems(
      {this.id,
      this.userId,
      this.categoryId,
      this.itemStatus,
      this.itemFeatured,
      this.itemFeaturedByAdmin,
      this.itemTitle,
      this.itemSlug,
      this.itemDescription,
      this.itemImage,
      this.itemAddress,
      this.itemAddressHide,
      this.cityId,
      this.stateId,
      this.countryId,
      this.itemPostalCode,
      this.itemPrice,
      this.itemWebsite,
      this.itemPhone,
      this.itemLat,
      this.itemLng,
      this.createdAt,
      this.updatedAt,
      this.itemSocialFacebook,
      this.itemSocialTwitter,
      this.itemSocialLinkedin,
      this.itemFeaturesString,
      this.itemImageMedium,
      this.itemImageSmall,
      this.itemImageTiny,
      this.itemCategoriesString,
      this.itemImageBlur,
      this.itemYoutubeId,
      this.itemAverageRating,
      this.itemLocationStr,
      this.itemType,
      this.itemHourTimeZone,
      this.itemHourShowHours,
      this.itemSocialWhatsapp,
      this.itemSocialInstagram,
      this.price,
      this.email,
      this.distance,
      this.state,
      this.city,
      this.user});

  NearbyItems.fromJson(Map<String, dynamic> json) {
    printDM("enter =>  B2 1");
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id']??0;
    itemStatus = json['item_status'];
    itemFeatured = json['item_featured'];
    itemFeaturedByAdmin = json['item_featured_by_admin'];
    itemTitle = json['item_title'];
    itemSlug = json['item_slug'];
    printDM("enter =>  B2 2");
    itemDescription = json['item_description'];
    itemImage = json['item_image'];
    itemAddress = json['item_address'];
    itemAddressHide = json['item_address_hide'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    itemPostalCode = json['item_postal_code'];
    itemPrice = json['item_price'];
    itemWebsite = json['item_website'];
    itemPhone = json['item_phone'];
    itemLat = json['item_lat'];
    itemLng = json['item_lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    printDM("enter =>  B2 3");
    itemSocialFacebook = json['item_social_facebook'];
    itemSocialTwitter = json['item_social_twitter'];
    itemSocialLinkedin = json['item_social_linkedin'];
    itemFeaturesString = json['item_features_string'];
    itemImageMedium = json['item_image_medium'];
    itemImageSmall = json['item_image_small'];
    itemImageTiny = json['item_image_tiny'];
    itemCategoriesString = json['item_categories_string'];
    itemImageBlur = json['item_image_blur'];
    itemYoutubeId = json['item_youtube_id'];
    itemAverageRating = json['item_average_rating'];
    itemLocationStr = json['item_location_str'];
    itemType = json['item_type'];
    itemHourTimeZone = json['item_hour_time_zone'];
    itemHourShowHours = json['item_hour_show_hours'];
    itemSocialWhatsapp = json['item_social_whatsapp'];
    itemSocialInstagram = json['item_social_instagram'];
    price = json['price'];
    email = json['email'];
    distance = json['distance'];
    state =
        json['state'] != null ? new StateModel.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    printDM("enter =>  B2 4");
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  int? roleId;
  String? userImage;
  String? userAbout;
  int? userSuspended;
  String? createdAt;
  String? updatedAt;
  String? userPreferLanguage;
  int? userPreferCountryId;
  String? apiToken;
  String? phone;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.userImage,
      this.userAbout,
      this.userSuspended,
      this.createdAt,
      this.updatedAt,
      this.userPreferLanguage,
      this.userPreferCountryId,
      this.apiToken,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    printDM("enter =>  B2 4 1");
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    userImage = json['user_image']??"";
    userAbout = json['user_about']??"";
    userSuspended = json['user_suspended'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userPreferLanguage = json['user_prefer_language']??"";
    userPreferCountryId = json['user_prefer_country_id']??0;
    apiToken = json['api_token']??"";
    phone = json['phone']!=null? json['phone'].toString():"";
    printDM("enter =>  B2 4 2");
  }

}

class SimilarItems {
  int? id;
  int? userId;
  dynamic categoryId;
  int? itemStatus;
  int? itemFeatured;
  int? itemFeaturedByAdmin;
  String? itemTitle;
  String? itemSlug;
  String? itemDescription;
  String? itemImage;
  String? itemAddress;
  int? itemAddressHide;
  int? cityId;
  int? stateId;
  int? countryId;
  String? itemPostalCode;
  dynamic itemPrice;
  String? itemWebsite;
  String? itemPhone;
  String? itemLat;
  String? itemLng;
  String? createdAt;
  String? updatedAt;
  String? itemSocialFacebook;
  dynamic itemSocialTwitter;
  dynamic itemSocialLinkedin;
  String? itemFeaturesString;
  String? itemImageMedium;
  String? itemImageSmall;
  String? itemImageTiny;
  String? itemCategoriesString;
  String? itemImageBlur;
  dynamic itemYoutubeId;
  dynamic itemAverageRating;
  String? itemLocationStr;
  int? itemType;
  String? itemHourTimeZone;
  int? itemHourShowHours;
  String? itemSocialWhatsapp;
  String? itemSocialInstagram;
  dynamic email;

  SimilarItems(
      {this.id,
      this.userId,
      this.categoryId,
      this.itemStatus,
      this.itemFeatured,
      this.itemFeaturedByAdmin,
      this.itemTitle,
      this.itemSlug,
      this.itemDescription,
      this.itemImage,
      this.itemAddress,
      this.itemAddressHide,
      this.cityId,
      this.stateId,
      this.countryId,
      this.itemPostalCode,
      this.itemPrice,
      this.itemWebsite,
      this.itemPhone,
      this.itemLat,
      this.itemLng,
      this.createdAt,
      this.updatedAt,
      this.itemSocialFacebook,
      this.itemSocialTwitter,
      this.itemSocialLinkedin,
      this.itemFeaturesString,
      this.itemImageMedium,
      this.itemImageSmall,
      this.itemImageTiny,
      this.itemCategoriesString,
      this.itemImageBlur,
      this.itemYoutubeId,
      this.itemAverageRating,
      this.itemLocationStr,
      this.itemType,
      this.itemHourTimeZone,
      this.itemHourShowHours,
      this.itemSocialWhatsapp,
      this.itemSocialInstagram,
      this.email});

  SimilarItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    itemStatus = json['item_status'];
    itemFeatured = json['item_featured'];
    itemFeaturedByAdmin = json['item_featured_by_admin'];
    itemTitle = json['item_title'];
    itemSlug = json['item_slug'];
    itemDescription = json['item_description'];
    itemImage = json['item_image'];
    itemAddress = json['item_address'];
    itemAddressHide = json['item_address_hide'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    itemPostalCode = json['item_postal_code'];
    itemPrice = json['item_price'];
    itemWebsite = json['item_website'];
    itemPhone = json['item_phone'];
    itemLat = json['item_lat'];
    itemLng = json['item_lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itemSocialFacebook = json['item_social_facebook'];
    itemSocialTwitter = json['item_social_twitter'];
    itemSocialLinkedin = json['item_social_linkedin'];
    itemFeaturesString = json['item_features_string'];
    itemImageMedium = json['item_image_medium'];
    itemImageSmall = json['item_image_small'];
    itemImageTiny = json['item_image_tiny'];
    itemCategoriesString = json['item_categories_string'];
    itemImageBlur = json['item_image_blur'];
    itemYoutubeId = json['item_youtube_id'];
    itemAverageRating = json['item_average_rating'];
    itemLocationStr = json['item_location_str'];
    itemType = json['item_type'];
    itemHourTimeZone = json['item_hour_time_zone'];
    itemHourShowHours = json['item_hour_show_hours'];
    itemSocialWhatsapp = json['item_social_whatsapp'];
    itemSocialInstagram = json['item_social_instagram'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['item_status'] = this.itemStatus;
    data['item_featured'] = this.itemFeatured;
    data['item_featured_by_admin'] = this.itemFeaturedByAdmin;
    data['item_title'] = this.itemTitle;
    data['item_slug'] = this.itemSlug;
    data['item_description'] = this.itemDescription;
    data['item_image'] = this.itemImage;
    data['item_address'] = this.itemAddress;
    data['item_address_hide'] = this.itemAddressHide;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['country_id'] = this.countryId;
    data['item_postal_code'] = this.itemPostalCode;
    data['item_price'] = this.itemPrice;
    data['item_website'] = this.itemWebsite;
    data['item_phone'] = this.itemPhone;
    data['item_lat'] = this.itemLat;
    data['item_lng'] = this.itemLng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['item_social_facebook'] = this.itemSocialFacebook;
    data['item_social_twitter'] = this.itemSocialTwitter;
    data['item_social_linkedin'] = this.itemSocialLinkedin;
    data['item_features_string'] = this.itemFeaturesString;
    data['item_image_medium'] = this.itemImageMedium;
    data['item_image_small'] = this.itemImageSmall;
    data['item_image_tiny'] = this.itemImageTiny;
    data['item_categories_string'] = this.itemCategoriesString;
    data['item_image_blur'] = this.itemImageBlur;
    data['item_youtube_id'] = this.itemYoutubeId;
    data['item_average_rating'] = this.itemAverageRating;
    data['item_location_str'] = this.itemLocationStr;
    data['item_type'] = this.itemType;
    data['item_hour_time_zone'] = this.itemHourTimeZone;
    data['item_hour_show_hours'] = this.itemHourShowHours;
    data['item_social_whatsapp'] = this.itemSocialWhatsapp;
    data['item_social_instagram'] = this.itemSocialInstagram;
    data['email'] = this.email;
    return data;
  }
}

class Reviews {
  int? id;
  int? rating;
  int? customerServiceRating;
  int? qualityRating;
  int? friendlyRating;
  int? pricingRating;
  String? recommend;
  String? department;
  String? title;
  String? body;
  int? approved;
  String? reviewrateableType;
  int? reviewrateableId;
  String? authorType;
  int? authorId;
  String? createdAt;
  String? updatedAt;

  Reviews(
      {this.id,
      this.rating,
      this.customerServiceRating,
      this.qualityRating,
      this.friendlyRating,
      this.pricingRating,
      this.recommend,
      this.department,
      this.title,
      this.body,
      this.approved,
      this.reviewrateableType,
      this.reviewrateableId,
      this.authorType,
      this.authorId,
      this.createdAt,
      this.updatedAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    customerServiceRating = json['customer_service_rating'];
    qualityRating = json['quality_rating'];
    friendlyRating = json['friendly_rating'];
    pricingRating = json['pricing_rating'];
    recommend = json['recommend'];
    department = json['department'];
    title = json['title'];
    body = json['body'];
    approved = json['approved'];
    reviewrateableType = json['reviewrateable_type'];
    reviewrateableId = json['reviewrateable_id'];
    authorType = json['author_type'];
    authorId = json['author_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['customer_service_rating'] = this.customerServiceRating;
    data['quality_rating'] = this.qualityRating;
    data['friendly_rating'] = this.friendlyRating;
    data['pricing_rating'] = this.pricingRating;
    data['recommend'] = this.recommend;
    data['department'] = this.department;
    data['title'] = this.title;
    data['body'] = this.body;
    data['approved'] = this.approved;
    data['reviewrateable_type'] = this.reviewrateableType;
    data['reviewrateable_id'] = this.reviewrateableId;
    data['author_type'] = this.authorType;
    data['author_id'] = this.authorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
