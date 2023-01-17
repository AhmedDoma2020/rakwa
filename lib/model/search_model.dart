class SearchModel {
  int? code;
  bool? status;
  dynamic filterCity;
  dynamic filterState;
  List<String>? filterClassifiedcategories;
  List<String>? filterCategories;
  dynamic searchQuery;
  String? filterSortBy;
  List<dynamic>? paidItems;
  List<FreeItems>? freeItems;
  List<dynamic>? paidClassified;
  List<dynamic>? freeClassified;

  SearchModel(
      {this.code,
      this.status,
      this.filterCity,
      this.filterState,
      this.filterClassifiedcategories,
      this.filterCategories,
      this.searchQuery,
      this.filterSortBy,
      this.paidItems,
      this.freeItems,
      this.paidClassified,
      this.freeClassified});

  SearchModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    filterCity = json['filter_city'];
    filterState = json['filter_state'];
    filterClassifiedcategories =
        json['filter_classifiedcategories'].cast<String>();
    filterCategories = json['filter_categories'].cast<String>();
    searchQuery = json['search_query'];
    filterSortBy = json['filter_sort_by'];
    if (json['paid_items'] != null) {
      paidItems = <FreeItems>[];
      json['paid_items'].forEach((v) {
        paidItems!.add(new FreeItems.fromJson(v));
      });
    }
    if (json['free_items'] != null) {
      freeItems = <FreeItems>[];
      json['free_items'].forEach((v) {
        freeItems!.add(new FreeItems.fromJson(v));
      });
    }
    if (json['paid_classified'] != null) {
      paidClassified = <FreeItems>[];
      json['paid_classified'].forEach((v) {
        paidClassified!.add(new FreeItems.fromJson(v));
      });
    }
    if (json['free_classified'] != null) {
      freeClassified = <FreeItems>[];
      json['free_classified'].forEach((v) {
        freeClassified!.add(new FreeItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['filter_city'] = this.filterCity;
    data['filter_state'] = this.filterState;
    data['filter_classifiedcategories'] = this.filterClassifiedcategories;
    data['filter_categories'] = this.filterCategories;
    data['search_query'] = this.searchQuery;
    data['filter_sort_by'] = this.filterSortBy;
    if (this.paidItems != null) {
      data['paid_items'] = this.paidItems!.map((v) => v.toJson()).toList();
    }
    if (this.freeItems != null) {
      data['free_items'] = this.freeItems!.map((v) => v.toJson()).toList();
    }
    if (this.paidClassified != null) {
      data['paid_classified'] =
          this.paidClassified!.map((v) => v.toJson()).toList();
    }
    if (this.freeClassified != null) {
      data['free_classified'] =
          this.freeClassified!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FreeItems {
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
  String? itemSocialTwitter;
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
  dynamic itemSocialInstagram;
  StateModel? state;
  City? city;
  User? user;

  FreeItems();

  FreeItems.fromJson(Map<String, dynamic> json) {
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
    state = json['state'] != null ? new StateModel.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
  dynamic createdAt;
  dynamic updatedAt;

  StateModel(
      {this.id,
      this.countryId,
      this.stateName,
      this.stateAbbr,
      this.stateSlug,
      this.stateCountryAbbr,
      this.createdAt,
      this.updatedAt});

  StateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    stateName = json['state_name'];
    stateAbbr = json['state_abbr'];
    stateSlug = json['state_slug'];
    stateCountryAbbr = json['state_country_abbr'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['state_name'] = this.stateName;
    data['state_abbr'] = this.stateAbbr;
    data['state_slug'] = this.stateSlug;
    data['state_country_abbr'] = this.stateCountryAbbr;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  dynamic createdAt;
  dynamic updatedAt;

  City(
      {this.id,
      this.stateId,
      this.cityName,
      this.cityState,
      this.citySlug,
      this.cityLat,
      this.cityLng,
      this.createdAt,
      this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    cityName = json['city_name'];
    cityState = json['city_state'];
    citySlug = json['city_slug'];
    cityLat = json['city_lat'];
    cityLng = json['city_lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
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
  dynamic apiToken;
  dynamic phone;

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
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    userImage = json['user_image'];
    userAbout = json['user_about'];
    userSuspended = json['user_suspended'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userPreferLanguage = json['user_prefer_language'];
    userPreferCountryId = json['user_prefer_country_id'];
    apiToken = json['api_token'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['role_id'] = this.roleId;
    data['user_image'] = this.userImage;
    data['user_about'] = this.userAbout;
    data['user_suspended'] = this.userSuspended;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_prefer_language'] = this.userPreferLanguage;
    data['user_prefer_country_id'] = this.userPreferCountryId;
    data['api_token'] = this.apiToken;
    data['phone'] = this.phone;
    return data;
  }
}