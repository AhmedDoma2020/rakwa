class CountryModel {
  late int id;
  late String countryName;
  late String countryAbbr;
  late String countrySlug;
  late dynamic createdAt;
  late dynamic updatedAt;
  late int countryStatus;

  CountryModel();

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    countryAbbr = json['country_abbr'];
    countrySlug = json['country_slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryStatus = json['country_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_name'] = this.countryName;
    data['country_abbr'] = this.countryAbbr;
    data['country_slug'] = this.countrySlug;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['country_status'] = this.countryStatus;
    return data;
  }
}
