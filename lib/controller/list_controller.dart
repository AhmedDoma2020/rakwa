import 'package:get/get.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/city_model.dart';
import 'package:rakwa/model/country_model.dart';
import 'package:rakwa/model/paid_items_model.dart';

class ListController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCitys(id: "296560");
    getStates(id: '399');
    getCountrys();
  }

  List<CountryModel> countrys = [];
  List<CityModel> citys = [];
  List<StateModel> states = [];


  Future<void> getCountrys() async {
    printDM("Get Countries step 1");
    countrys = await ListApiController().getCountrys();
    printDM("Get Countries step 2 $countrys");

    countrys.sort((a, b) {
      return a.countryName.toLowerCase().compareTo(b.countryName.toLowerCase());

    });
    update();
  }

  Future<void> getCitys({required String id}) async {
    citys = await ListApiController().getCitys(id: id);
    citys.sort((a, b) {
      return a.cityName.toLowerCase().compareTo(b.cityName.toLowerCase());
    });
    update();
  }

  Future<void> getStates({required String id}) async {
    states = await ListApiController().getState(id: id);
    states.sort((a, b) {
      return a.stateName.toLowerCase().compareTo(b.stateName.toLowerCase());
    });
    update();
  }
}
