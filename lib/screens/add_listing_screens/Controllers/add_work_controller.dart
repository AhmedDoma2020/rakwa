import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakwa/Core/services/dialogs.dart';
import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/controller/custom_field_getx_controller.dart';
import 'package:rakwa/model/city_model.dart';
import 'package:rakwa/model/country_model.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_address_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_images_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_social_information_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_title_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_work_days_screen.dart';
import 'package:rakwa/screens/add_listing_screens/done_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';
import 'package:rakwa/widget/SnackBar/custom_snack_bar.dart';

import '../../../model/paid_items_model.dart';

class AddWorkOrAdsController extends GetxController {
  final bool isList;

  AddWorkOrAdsController({required this.isList}); //Category Data
  int parentCategory = -1;

  void setParentCategory(int id) {
    parentCategory = id;
    selectedCategoriesIds.clear();
    printDM("parentCategory is => $parentCategory");
  }

  //Category Data
  List<int> selectedCategoriesIds = [];

  void setCategoriesIds(int id) {
    if (selectedCategoriesIds.contains(id)) {
      selectedCategoriesIds.remove(id);
    } else {
      selectedCategoriesIds.add(id);
    }
    if (isList) {
      update(["update_categories_ids"]);
      printDM(
          "isList $isList selectedSubCategoriesIds is => $selectedCategoriesIds");
    } else {
      update(["update_Classified_categories_ids"]);
      printDM(
          "isList $isList selectedSubCategoriesIds is => $selectedCategoriesIds");
    }
  }

  void navigationAfterSelectSubCategories() {
    Get.off(
      () => AddListTitleScreen(
        isList: isList,
      ),
    );
    _getCustomField();
    printDM("selectedSubID is $selectedCategoriesIds");
  }

  // Get Custom Field
  final GetCustomFieldController _getCustomFieldController =
      Get.put(GetCustomFieldController());

  void _getCustomField() async {
    printDM("_getCustomField is called ");
    await _getCustomFieldController.getCustom(
        isList: isList, categoryIds: selectedCategoriesIds);
  }

  //add job title & description
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void navigationAfterAddJopTitleAndDescription(
      GlobalKey<FormState> globalKey) {
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      Get.to(
        () => AddListAddressScreen(
          isList: isList,
        ),
      );
    }
  }

  // add address
  TextEditingController locationController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  int countryID = 0;

  void setCountryID(CountryModel country) {
    countryID = country.id;
    countryController.text = country.countryName;
    _refreshStateAndCityData();
    update(['update_address_screen']);
  }

  void _refreshStateAndCityData() {
    stateID = 0;
    stateController.clear();
    cityID = 0;
    cityController.clear();
  }

  int stateID = 0;

  void setStateID(StateModel state) {
    stateID = state.id;
    stateController.text = state.stateName;
    _refreshCityData();
    update(['update_address_screen']);
  }

  void _refreshCityData() {
    cityID = 0;
    cityController.clear();
  }

  int cityID = 0;

  void setCity(CityModel city) {
    cityID = city.id;
    cityController.text = city.cityName;
    update(['update_address_screen']);
  }

  double lat = 41.8781;
  double lng = -87.6298;

  void navigationAfterAddAddress(
      GlobalKey<FormState> globalKey, double? lat, double? lng) {
    lat = lat;
    lng = lng;
    if (globalKey.currentState!.validate()) {
      globalKey.currentState!.save();
      if (isList) {
        Get.to(
          () => AddListWorkDaysScreen(
            isList: isList,
          ),
        );
      } else {
        Get.to(
          () => AddListImagesScreen(
            isList: isList,
          ),
        );
      }
    }
  }

  //add Work Day
  List<dynamic> itemHours = [];

  void setItemHours(dynamic itemHour) {}

  TextEditingController priceController = TextEditingController();

  void navigationAfterAddWorkDay(GlobalKey<FormState> globalKey) {
    printDM("itemHours is ${itemHours}");
    if (isList) {
      Get.to(
        () => AddListImagesScreen(
          isList: isList,
        ),
      );
    } else {
      if (isList) {
        Get.to(() => AddListImagesScreen(
              isList: isList,
            ));
      } else {
        if (globalKey.currentState!.validate()) {
          globalKey.currentState!.save();
          Get.to(
            () => AddListImagesScreen(
              isList: isList,
            ),
          );
        }
      }
    }
  }

  // add image
  String? featureImage = '';
  List<dynamic> imageGallery = [];

  void navigationAfterAddImages() {
    Get.to(
      () => AddListSocialInformationScreen(
        isList: isList,
      ),
    );
  }

//add social media links
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();

  CreateItemModel get createItemModel {
    CreateItemModel createItemModel = CreateItemModel();
    createItemModel.itemType = '1';
    createItemModel.itemFeatured = '0';
    createItemModel.itemPostalCode = '34515';
    createItemModel.itemHourShowHours = '1';
    createItemModel.category.addAll(selectedCategoriesIds);
    createItemModel.itemTitle = titleController.text;
    createItemModel.itemDescription = descriptionController.text;
    createItemModel.countryId = countryID.toString();
    createItemModel.stateId = stateID.toString();
    createItemModel.cityId = cityID.toString();
    createItemModel.itemLat = lat;
    createItemModel.itemLng = lng;
    createItemModel.itemAddress = locationController.text;
    createItemModel.itemHourTimeZone = locationController.text;
    if (isList) {
      createItemModel.itemHours.add(itemHours);
    } else {
      createItemModel.price = priceController.text;
    }
    createItemModel.featureImage = featureImage;
    createItemModel.imageGallery = imageGallery;
    createItemModel.itemSocialFacebook = facebookController.text;
    createItemModel.itemSocialInstagram = instagramController.text;
    createItemModel.itemSocialLinkedin = linkedInController.text;
    createItemModel.itemSocialTwitter = twitterController.text;
    createItemModel.itemSocialWhatsapp = phoneController.text;
    createItemModel.itemPhone = phoneController.text;
    createItemModel.itemWebsite = websiteController.text;
    createItemModel.itemYoutubeId = websiteController.text;

    return createItemModel;
  }

// add work

  Future<bool> addWork(
      {required List<dynamic> checkBox,
      required List<dynamic> textFiled}) async {
    setLoading();
    bool status = await ListApiController().addList(
      checkBox: checkBox,
      textFiled: textFiled,
      createItemModel: createItemModel,
      customFileds: _getCustomFieldController.keysCustomFields,
      isList: isList,
    );
    Get.back();
    if (status) {
      _getCustomFieldController.refreshData();
      Get.offAll(
        () => DoneScreen(
          isList: isList,
        ),
      );
      return status;
    } else {
      customSnackBar(
        title: "حدث خطاء ما",
        subtitle: "برجاء المحاوله مره اخرى",
        isWarning: true,
      );
      return status;
    }
  }
}
