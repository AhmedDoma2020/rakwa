class PaidItemsModel {
  dynamic id;
  dynamic userId;
  dynamic categoryId;
  dynamic itemStatus;
  dynamic itemFeatured;
  dynamic itemFeaturedByAdmin;
  dynamic itemTitle;
  dynamic itemSlug;
  dynamic itemDescription;
  dynamic itemImage;
  dynamic itemAddress;
  dynamic itemAddressHide;
  dynamic cityId;
  dynamic stateId;
  dynamic countryId;
  dynamic itemPostalCode;
  dynamic itemPrice;
  dynamic itemWebsite;
  dynamic itemPhone;
  dynamic itemLat;
  dynamic itemLng;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic itemSocialFacebook;
  dynamic itemSocialTwitter;
  dynamic itemSocialLinkedin;
  dynamic itemFeaturesString;
  dynamic itemImageMedium;
  dynamic itemImageSmall;
  dynamic itemImageTiny;
  dynamic itemCategoriesString;
  dynamic itemImageBlur;
  dynamic itemYoutubeId;
  dynamic itemAverageRating;
  dynamic itemLocationStr;
  dynamic itemType;
  dynamic itemHourTimeZone;
  dynamic itemHourShowHours;
  dynamic itemSocialWhatsapp;
  dynamic itemSocialInstagram;
  dynamic email;
  StateModel? state;
  City? city;
  User? user;

  PaidItemsModel(
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
      this.email,
      this.state,
      this.city,
      this.user});

  PaidItemsModel.fromJson(Map<String, dynamic> json) {
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
    state =
        json['state'] != null ? new StateModel.fromJson(json['state']) : null;
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
    data['email'] = this.email;
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
  dynamic id;
  dynamic countryId;
  dynamic stateName;
  dynamic stateAbbr;
  dynamic stateSlug;
  dynamic stateCountryAbbr;
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
  dynamic id;
  dynamic stateId;
  dynamic cityName;
  dynamic cityState;
  dynamic citySlug;
  dynamic cityLat;
  dynamic cityLng;
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
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic roleId;
  dynamic userImage;
  dynamic userAbout;
  dynamic userSuspended;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic userPreferLanguage;
  dynamic userPreferCountryId;
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
