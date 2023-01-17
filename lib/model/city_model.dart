class CityModel {
  late dynamic id;
  late dynamic stateId;
  late dynamic cityName;
  late dynamic cityState;
  late dynamic citySlug;
  late dynamic cityLat;
  late dynamic cityLng;
  late dynamic createdAt;
  late dynamic updatedAt;

  CityModel();

  CityModel.fromJson(Map<String, dynamic> json) {
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
