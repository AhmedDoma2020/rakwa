import 'package:rakwa/Core/utils/extensions.dart';
import 'package:rakwa/model/user_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {
  static SharedPrefController? _instance;
  late SharedPreferences _sharedPreferences;

  SharedPrefController._();

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setVerifiedEmail({required String emailVerification}) async {
    await _sharedPreferences.setString('email_verified_at', emailVerification);
  }

  Future<void> saveData({
    required var userLoginModel,
    required String? token,
    required bool isLogined,
  }) async {
    print(userLoginModel['role_id']);
    await _sharedPreferences.setBool('isLogined', isLogined);
    if (token != null) {
      await _sharedPreferences.setString('token', 'Bearer ${token}');
    }
    await _sharedPreferences.setString('name', userLoginModel['name']);
    await _sharedPreferences.setString('id', userLoginModel['id'].toString());
    await _sharedPreferences.setString('email', userLoginModel['email']);
    await _sharedPreferences.setInt('role_id', userLoginModel['role_id']);
    await _sharedPreferences.setString(
        'user_image', userLoginModel['user_image'] ?? '');
    await _sharedPreferences.setInt(
        'user_suspended', userLoginModel['user_suspended']);
    await _sharedPreferences.setString(
        'created_at', userLoginModel['created_at']);
    await _sharedPreferences.setString(
        'updated_at', userLoginModel['updated_at']);
    await _sharedPreferences.setString('email_verified_at', userLoginModel['email_verified_at'].toString());
    await _sharedPreferences.setString('phone', userLoginModel['phone'].toString());
    await _sharedPreferences.setString('user_prefer_country_id', userLoginModel['user_prefer_country_id'].toString());
   printDM("userLoginModel['user_prefer_country_id'] ${userLoginModel['user_prefer_country_id']??""}");
    if(userLoginModel['country']!=null){
    await saveCountryName(userLoginModel['country']['country_name']);
   }else{
     await saveCountryName('');
   }
    // await _sharedPreferences.setString('user_prefer_country_id', userLoginModel['country']["id"].toString());
    // await _sharedPreferences.setString('country_name', userLoginModel['country']["country_name"].toString());
    print(userLoginModel['email_verified_at']);
    print(token);
    print('============================================');
  }
  Future<void> saveCountryName( String countryName) async{
    if(countryName.isNotEmpty && countryName!=""){
      await _sharedPreferences.setString('country_name', countryName);
    }else{
      await _sharedPreferences.setString('country_name', '');
    }
  }

  bool get isLogined {
    return _sharedPreferences.getBool('isLogined') ?? false;
  }

  String get token {
    return _sharedPreferences.getString('token') ?? '';
  }

  String get userPreferCountryId {
    return _sharedPreferences.getString('user_prefer_country_id') ?? '';
  }
 String get countryName {
    return _sharedPreferences.getString('country_name') ?? '';
  }

  String get phone {
    return _sharedPreferences.getString('phone') ?? '';
  }

  String? get createdAt {
    return _sharedPreferences.getString('created_at') ?? null;
  }

  String? get verifiedEmail {
    return _sharedPreferences.getString('email_verified_at') ?? null;
  }

  int get roleId {
    return _sharedPreferences.getInt('role_id') ?? 0;
  }

  String get name {
    return _sharedPreferences.getString('name') ?? '';
  }

  String get image {
    return _sharedPreferences.getString('user_image') ?? '';
  }

  String get email {
    return _sharedPreferences.getString('email') ?? '';
  }

  String get updatedAt {
    return _sharedPreferences.getString('updated_at') ?? '';
  }

  String get id {
    return _sharedPreferences.getString('id') ?? '';
  }

  Future<void> savePosition({
    required double? lat,
    required double? lng,
  }) async {
    printDM("lat in SharedPrefController is => $lat");
    printDM("lng in SharedPrefController is => $lng");

    await _sharedPreferences.setString('lat', lat!=null ? lat.toString():"");
    await _sharedPreferences.setString('lng', lng!=null ? lng.toString():"");
  }
  String get lat {
    return _sharedPreferences.getString('lat') ?? '';
  }String get lng {
    return _sharedPreferences.getString('lng') ?? '';
  }
  Future<bool> clear() async => _sharedPreferences.clear();
}
