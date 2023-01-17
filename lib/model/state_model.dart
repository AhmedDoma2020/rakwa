class StateModel {
  dynamic id;
  dynamic countryId;
  dynamic stateName;
  dynamic stateAbbr;
  dynamic stateSlug;
  dynamic stateCountryAbbr;
  dynamic createdAt;
  dynamic updatedAt;

  StateModel();

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
