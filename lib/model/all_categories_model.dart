
class AllCategoriesModel {
 late int id;
 late String categoryName;
 late String categorySlug;
 late dynamic categoryIcon;
 late String createdAt;
 late String updatedAt;
 late dynamic categoryParentId;
 late String? categoryDescription;
 late String? categoryImage;
 late int categoryThumbnailType;
 late int categoryHeaderBackgroundType;
 late dynamic categoryHeaderBackgroundColor;
 late dynamic categoryHeaderBackgroundImage;
 late dynamic categoryHeaderBackgroundYoutubeVideo;
 late dynamic allItemsCount;

  AllCategoriesModel(
 {
  required this.id,
  required this.categoryName,
  required this.categoryImage,

}
      );
  AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categorySlug = json['category_slug'];
    categoryIcon = json['category_icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryParentId = json['category_parent_id'];
    categoryDescription = json['category_description'];
    // categoryImage = json['category_image'];
     categoryImage = json['category_image']??"";
    categoryThumbnailType = json['category_thumbnail_type'];
    categoryHeaderBackgroundType = json['category_header_background_type'];
    categoryHeaderBackgroundColor = json['category_header_background_color'];
    categoryHeaderBackgroundImage = json['category_header_background_image'];
    categoryHeaderBackgroundYoutubeVideo =
        json['category_header_background_youtube_video'];
    allItemsCount = json['all_items_count'];
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
    data['all_items_count'] = this.allItemsCount;
    return data;
  }
}