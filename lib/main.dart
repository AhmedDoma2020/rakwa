import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rakwa/app_colors/app_colors.dart';
import 'package:rakwa/controller/fb_notifications_controller.dart';
import 'package:rakwa/firebase_options.dart';
import 'package:rakwa/screens/Auth/screens/forget_password_screen.dart';
import 'package:rakwa/screens/Auth/screens/sign_in_screen.dart';
import 'package:rakwa/screens/launch_screen/launch_screen.dart';
import 'package:rakwa/screens/main_screens/main_screen.dart';
import 'package:rakwa/shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FBNotificationsController.initNotifications();
  await SharedPrefController().initPreferences();
  runApp(
      // const MyApp(),
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('ar'),
          theme: SharedPrefController().roleId == 2
              ? ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  timePickerTheme: const TimePickerThemeData(
                    dialHandColor: AppColors.mainColor,
                  ),
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      iconTheme: IconThemeData(color: Colors.black)))
              : ThemeData(
                  timePickerTheme: const TimePickerThemeData(
                    dialHandColor: AppColors.mainColor,
                  ),
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      iconTheme: IconThemeData(color: Colors.black))),
          initialRoute: '/',
          // home: const LaunchScreen(),
          // home: DetailsScreen(id: 1476),
          getPages: [
            GetPage(name: '/', page: () => const LaunchScreen()),
            GetPage(name: '/sign_in_screen', page: () =>  SignInScreen()),
            GetPage(name: '/main_screen', page: () => const MainScreen()),
            GetPage(
                name: '/forget_password_screen',
                page: () =>  ForgetPasswordScreen()),
          ],
        );
      },
    );
  }
}

// new packge name
// com.app.rakwa

// iOS bundle identifier
// com.example.rakwa

// SHA1
// 5B:BC:F1:25:3D:EB:10:5D:C3:9B:14:50:1D:3D:B9:6D:B0:98:54:1C

// android packge
// com.example.rakwa

// list and classified images url
//https://www.rakwa.com/laravel_project/public/storage/item/
//https://www.rakwa.com/laravel_project/public/storage/item/gallery/

// list and calssified category images url
//https://www.rakwa.com/laravel_project/public/storage/category/

// if list and classified has no images url
//https://rakwa.com/theme_assets/frontend_assets/lduruo10_dh_frontend_city_path/placeholder/

// user images url
// https://www.rakwa.com/laravel_project/public/storage/user/

// sign in uer hnynwydt@gmail.com password 12345678
