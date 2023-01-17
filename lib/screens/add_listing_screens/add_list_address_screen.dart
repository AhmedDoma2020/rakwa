import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:rakwa/api/api_controllers/list_api_controller.dart';
import 'package:rakwa/controller/list_controller.dart';
import 'package:rakwa/model/autocomplete_model.dart';
import 'package:rakwa/model/city_model.dart';
import 'package:rakwa/model/country_model.dart';
import 'package:rakwa/model/create_item_model.dart';
import 'package:rakwa/model/paid_items_model.dart';
import 'package:rakwa/screens/add_listing_screens/Controllers/add_work_controller.dart';
import 'package:rakwa/screens/add_listing_screens/Widget/bottom_sheet_city.dart';
import 'package:rakwa/screens/add_listing_screens/Widget/bottom_sheet_country.dart';
import 'package:rakwa/screens/add_listing_screens/Widget/bottom_sheet_state.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_images_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_subcategory_screen.dart';
import 'package:rakwa/screens/add_listing_screens/add_list_work_days_screen.dart';
import 'package:rakwa/screens/google_maps_services/places_service.dart';
import 'package:rakwa/Core/utils/helpers.dart';
import 'package:rakwa/widget/TextFields/text_field_default.dart';
import 'package:rakwa/widget/TextFields/validator.dart';
import 'package:rakwa/widget/appbars/app_bars.dart';
import 'package:rakwa/widget/my_text_field.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:shimmer/shimmer.dart';

import '../../app_colors/app_colors.dart';
import '../../widget/next_step_button.dart';
import '../../widget/steps_widget.dart';
import '../google_maps_services/place_search.dart';

class AddListAddressScreen extends StatefulWidget {
  final bool isList;

  AddListAddressScreen({required this.isList});

  @override
  State<AddListAddressScreen> createState() => _AddListAddressScreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _AddListAddressScreenState extends State<AddListAddressScreen>
    with Helpers {
  Mode _mode = Mode.overlay;

  List<PlaceSearch>? searchResults = [];

  var kGoogleApiKey = "AIzaSyBauBUw7ABmSkqpsx0yLM73Eqehz1guZS0";

  final Set<Marker> _marker = {};
  var location = {'lat': 41.8781, 'lng': -87.6298};
  final Completer<GoogleMapController> _controller = Completer();

  Future<void> moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(double.parse(location['lat'].toString()),
            double.parse(location['lng'].toString())))));
  }

  bool value = true;

  bool businessIs = true;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ListController listController = Get.put(ListController());
    AddWorkController addWordController = Get.find();
    var node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBars.appBarDefault(
          title: widget.isList ? 'إضافة عمل' : 'اضافة اعلان'),
      floatingActionButton: FloatingActionButtonNext(
        onTap: () {
          addWordController.navigationAfterAddAddress(globalKey,location['lat'],location['lng']);
        },
      ),
      body: GetBuilder<AddWorkController>(
        id: 'update_address_screen',
        builder: (_) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 24,
            ),
            StepsWidget(selectedStep: 2),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    GetBuilder<ListController>(
                      builder: (controller) => GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            BottomSheetCountry(
                              country: listController.countrys,
                              bottomSheetTitle: "الدول",
                              countrySelectedId: _.countryID,
                              onSelect: (country) {
                                _.setCountryID(country);
                                listController.getStates(
                                    id: _.countryID.toString());
                              },
                            ),
                          );
                        },
                        child: TextFieldDefault(
                          enable: false,
                          upperTitle: "الدولة",
                          hint: 'اختار الدولة',
                          prefixIconSvg: "country",
                          suffixIconData: Icons.arrow_drop_down_sharp,
                          controller: _.countryController,
                          validation: locationValidator,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<ListController>(
                      builder: (controller) => GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            BottomSheetState(
                              state: listController.states,
                              bottomSheetTitle: "الولايات",
                              stateSelectedId: _.stateID ,
                              onSelect: (state) {
                                  _.setStateID(state);
                                listController.getCitys(id: _.stateID.toString());
                              },
                            ),
                          );
                        },
                        child: TextFieldDefault(
                          enable: false,
                          upperTitle: "الولاية",
                          hint: 'اختار ولاية',
                          prefixIconSvg: "state",
                          suffixIconData: Icons.arrow_drop_down_sharp,
                          controller: _.stateController,
                          validation: locationValidator,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: businessIs,
                      child: GetBuilder<ListController>(
                        builder: (controller) => GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              BottomSheetCity(
                                cities: listController.citys,
                                bottomSheetTitle: "المدن",
                                citySelectedId: _.stateID ,
                                onSelect: (city) {
                                  _.setCity(city);
                                },
                              ),
                            );
                          },
                          child: TextFieldDefault(
                            enable: false,
                            upperTitle: "المدينة",
                            hint: 'اختار المدينة',
                            prefixIconSvg: "city",
                            suffixIconData: Icons.arrow_drop_down_sharp,
                            controller: _.cityController,
                            validation: locationValidator,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: businessIs,
                      child: TextFieldDefault(
                        upperTitle: "الموقع",
                        hint: 'ادخل الموقع',
                        suffixIconUrl: "location",
                        controller: _.locationController,
                        keyboardType: TextInputType.text,
                        onChanged: (p0) {
                          setState(() {
                            value = true;
                          });
                        },
                        onComplete: () {
                          node.nextFocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _.locationController.text.isNotEmpty && value
                ? SizedBox(
                    height: 200,
                    child: FutureBuilder<List<AutoCompleteModel>>(
                      future: ListApiController()
                          .getAddress(input: _.locationController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade100,
                                    highlightColor: Colors.grey.shade300,
                                    child: const ListTile(
                                      title: Text(''),
                                    ));
                              },
                              itemCount: 4);
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return ListView.separated(
                              padding: EdgeInsets.zero,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () async {
                                    setState(() {
                                      _.locationController.text =
                                          snapshot.data![index].description ??
                                              '';
                                      value = false;
                                    });
                                    location = await ListApiController()
                                        .getAddressDetails(
                                            id: snapshot.data![index].placeId ??
                                                '');
                                    _setMarker(
                                        lat: double.parse(
                                            location['lat'].toString()),
                                        lng: double.parse(
                                            location['lng'].toString()));
                                    moveCamera();
                                  },
                                  leading: const Icon(Icons.location_pin),
                                  title: Text(
                                      snapshot.data![index].description ?? ''),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
                                );
                              },
                              itemCount: snapshot.data!.length);
                        } else {
                          print(snapshot.data!);
                          print('====================================');
                          return const Text('لا توجد بيانات');
                        }
                      },
                    ),
                  )
                : SizedBox(),
            const SizedBox(
              height: 32,
            ),
            Visibility(
              visible: businessIs,
              child: Container(
                width: Get.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    markers: _marker,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(double.parse(location['lat'].toString()),
                            double.parse(location['lng'].toString()))),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _setMarker({required double lat, required double lng}) {
    setState(() {
      _marker.add(Marker(
        markerId: const MarkerId('value'),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }


  //
  // CreateItemModel get createItemModel {
  //   CreateItemModel createItemModel = widget.createItemModel;
  //   createItemModel.countryId = countryID.toString();
  //   createItemModel.stateId = stateID.toString();
  //   createItemModel.cityId = cityID.toString();
  //   createItemModel.itemLat = location['lat'];
  //   createItemModel.itemLng = location['lng'];
  //   createItemModel.itemAddress = _locationController.text;
  //   createItemModel.itemHourTimeZone = _locationController.text;
  //
  //   return createItemModel;
  // }
}
