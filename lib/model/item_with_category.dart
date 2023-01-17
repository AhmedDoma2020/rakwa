class ItemWithCategory {
  int? id;
  String? categoryName;
  String? categorySlug;
  String? categoryIcon;
  String? createdAt;
  String? updatedAt;
  dynamic categoryParentId;
  String? categoryDescription;
  dynamic categoryImage;
  int? categoryThumbnailType;
  int? categoryHeaderBackgroundType;
  dynamic categoryHeaderBackgroundColor;
  dynamic categoryHeaderBackgroundImage;
  dynamic categoryHeaderBackgroundYoutubeVideo;
  List<AllItems>? allItems;

  ItemWithCategory(
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
      this.allItems});

  ItemWithCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    categoryIcon = json['category_icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryParentId = json['category_parent_id'];
    categoryDescription = json['category_description'];
    categoryImage = json['category_image'];
    categoryThumbnailType = json['category_thumbnail_type'];
    categoryHeaderBackgroundType = json['category_header_background_type'];
    categoryHeaderBackgroundColor = json['category_header_background_color'];
    categoryHeaderBackgroundImage = json['category_header_background_image'];
    categoryHeaderBackgroundYoutubeVideo =
        json['category_header_background_youtube_video'];
    if (json['all_items'] != null) {
      allItems = <AllItems>[];
      json['all_items'].forEach((v) {
        allItems!.add(new AllItems.fromJson(v));
      });
    }
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
    if (this.allItems != null) {
      data['all_items'] = this.allItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllItems {
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
  String? itemSocialInstagram;
  String? email;
  Pivot? pivot;

  AllItems(
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
      this.pivot});

  AllItems.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? categoryId;
  int? itemId;
  String? createdAt;
  String? updatedAt;

  Pivot({this.categoryId, this.itemId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    itemId = json['item_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['item_id'] = this.itemId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
