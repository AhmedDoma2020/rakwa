import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:rakwa/screens/google_maps_services/place_search.dart';

class PlacesService {
  final key = 'AIzaSyBGOvwzbb9UAQ5K2ECo1Jtb5rH9N9YRaF8';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  // Future<Place> getPlace(String placeId) async {
  //   Uri url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key');
  //   var response = await http.get(url);
  //   var json = convert.jsonDecode(response.body);
  //   var jsonResult = json['result'] as Map<String, dynamic>;
  //   return Place.fromJson(jsonResult);
  // }

  // Future<List<Place>> getPlaces(
  //     double lat, double lng, String placeType) async {
  //   Uri url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key');
  //   var response = await http.get(url);
  //   var json = convert.jsonDecode(response.body);
  //   var jsonResults = json['results'] as List;
  //   return jsonResults.map((place) => Place.fromJson(place)).toList();
  // }
}
