import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/classified_api_controller.dart';
import 'package:rakwa/api/api_controllers/item_api_controller.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/model/all_categories_model.dart';
import 'package:rakwa/model/classified_with_category.dart';
import 'package:rakwa/model/item_with_category.dart';

class AllItemGetxController extends GetxController {
  List<ItemWithCategory> itemWithCategory = [];
  List<AllCategoriesModel> subCategory = [];
  List<AllCategoriesModel> classifeidSubCategory = [];
  List<ClassifiedWithCategory> classifiedWithCategory = [];
  int classifiedStatus = 1;
  int itemStatus = 1;
  int classifiedSubCategryStatus = 1;
  int itemSubCategryStatus = 1;

  List<Marker> marker = [];
  List<Marker> markerClassified = [];

  List<Marker> list = [];
  List<Marker> listClassifeid = [];

  addMarkers() {
    for (int i = 0; i <= itemWithCategory[0].allItems!.length / 2 - 1; i++) {
      list.add(Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: LatLng(
              double.parse(
                  itemWithCategory[0].allItems![i].itemLat ?? '41.0082'),
              double.parse(
                  itemWithCategory[0].allItems![i].itemLng ?? '28.9784')),
          infoWindow: InfoWindow(
              title:
                  itemWithCategory[0].allItems![i].itemAddress ?? 'İstanbul')));
    }
    marker.addAll(list);
    update();
  }

  addClassifiedMarkers() {
    for (int i = 0; i <= classifiedWithCategory[0].allItems!.length - 1; i++) {
      listClassifeid.add(Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: LatLng(
              double.parse(
                  classifiedWithCategory[0].allItems![i].itemLat ?? '41.0082'),
              double.parse(
                  classifiedWithCategory[0].allItems![i].itemLng ?? '28.9784')),
          infoWindow: InfoWindow(
              title: classifiedWithCategory[0].allItems![i].itemAddress ??
                  'İstanbul')));
    }
    markerClassified.addAll(listClassifeid);
    update();
  }

  Future<void> getItem({required String id}) async {
    itemWithCategory = [];
    marker = [];
    itemStatus = 1;
    var data = await ItemApiController().getItemWithCategory(id: id);
    if (data[0].allItems != null && data[0].allItems!.isNotEmpty) {
      itemWithCategory.addAll(data);
      classifiedStatus = 2;
      addMarkers();
    } else {
      itemWithCategory = [];
      itemStatus = 3;
    }

    update();
  }

  Future<void> getSubCategory({required int id}) async {
    subCategory = [];
    itemSubCategryStatus = 1;
    var data = await ListApiController().getSubCategory(id: id);
    if (data.isNotEmpty) {
      subCategory.addAll(data);
    } else {
      subCategory = [];
      itemSubCategryStatus = 3;
    }

    update();
  }

  Future<void> getClassifiedSubCategory({required int id}) async {
    classifeidSubCategory = [];
    classifiedSubCategryStatus = 1;
    var data = await ListApiController().getClassifiedSubCategory(id: id);
    if (data.isNotEmpty) {
      classifeidSubCategory.addAll(data);
    } else {
      classifeidSubCategory = [];
      classifiedSubCategryStatus = 3;
    }

    update();
  }

  Future<void> getClassified({required String id}) async {
    classifiedWithCategory = [];
    markerClassified = [];

    classifiedStatus = 1;
    var data = await ClassifiedApiController().getClassifedWithCategory(id: id);

    printDM("data[0].allItems classified-categorys is => ${data}");

    if (data[0].allItems != null && data[0].allItems!.isNotEmpty) {
      classifiedWithCategory.addAll(data);
      classifiedStatus = 2;
      addClassifiedMarkers();
    } else {
      classifiedWithCategory = [];
      classifiedStatus = 3;
    }
    update();
  }
}
