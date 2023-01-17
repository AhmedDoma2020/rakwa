import 'package:get/get.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/city_model.dart';
import 'package:rakwa/model/country_model.dart';
import 'package:rakwa/model/paid_items_model.dart';

class SearchController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCategory();
    getClassifiedCategory();
  }

  List<AllCategoriesModel> category = [];
  List<AllCategoriesModel> clssifiedCategory = [];

  Future<void> getCategory() async {
    category = await ListApiController().getCategory();
    update();
  }

  Future<void> getClassifiedCategory() async {
    clssifiedCategory = await ListApiController().getClassifiedCategory();
    update();
  }
}
