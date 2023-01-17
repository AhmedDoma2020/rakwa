// import 'dart:convert';
//
// import 'package:dr_dent/Src/core/utils/extensions.dart';
// import 'package:dr_dent/Src/features/AuthFeature/bloc/Model/user_model.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// class DataBase extends GetxController {
//
//   static final GetStorage _box = GetStorage();
//
//   void loginUser() {
//     _box.write('login', true);
//   }
//   void verifyPhoneStatus(String status) {
//     _box.write('inVerifyPhone', status);
//   }
//   Future<void> initStorage() async {
//     await GetStorage.init();
//   }
//   void storeUserModel(UserModel model) {
//     _box.write('user_model', model.toJson());
//     // printDM('enter storeUserModel step 1');
//   }
//   UserModel restoreUserModel() {
//      Map<String,dynamic> map = {};
//     if(_box.read('user_model')!=null){
//        map = _box.read('user_model');
//     }
//     printDM('enter restoreUserModel map is $map');
//     // printDM('enter restoreUserModel step 1');
//     return UserModel.fromJson(map);
//   }
//
// static Future<void> clearStorage () async {
//     await _box.erase();
//   }
//
// //how to use
// //Get.find<Database>().restoreModel().val
// }
//
// //
// // Future<String> fetchUserName()async{
// //   var authBox = await Hive.openBox('auth');
// //   return authBox.get('name');
// // }
// //
// // Future<String> fetchApiToken()async{
// //   var authBox = await Hive.openBox('auth');
// //   return authBox.get('api_token')??'';
// // }
// //
// //
// // Future<String> fetchEmail()async{
// //   var authBox = await Hive.openBox('auth');
// //   return authBox.get('email')??'';
// // }
// //
// // Future<String> fetchPhone()async{
// //   var authBox = await Hive.openBox('auth');
// //   return authBox.get('phone')??'';
// // }
// //
// //
// // Future<bool> fetchIfLogin()async{
// //   var authBox = await Hive.openBox('auth');
// //   return authBox.get('login')??false;
// // }
// //
// // Future logOut()async{
// //   var authBox = await Hive.openBox('auth');
// //   authBox.clear();
// // }
// //
// //
// //
// // void registerOnBoard()async{
// //   var onBoardBox = await Hive.openBox('onBoard');
// //   onBoardBox.put('onBoard',true);
// // }
// //
// //
// // Future<bool> fetchOnBoard()async{
// //   var onBoardBox = await Hive.openBox('onBoard');
// //   return onBoardBox.get('onBoard')??false;
// // }
//
//
