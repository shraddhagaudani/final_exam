import 'package:final_exam/controller/theme_controller.dart';
import 'package:final_exam/views/screens/cart_page.dart';
import 'package:final_exam/views/screens/coupon_page.dart';
import 'package:final_exam/views/screens/home_page.dart';
import 'package:final_exam/views/screens/login_page.dart';
import 'package:final_exam/views/screens/setting_page.dart';
import 'package:final_exam/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Themecontroller themecontroller = Get.put(Themecontroller());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (themecontroller.themeModel.isdark)
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      // darkTheme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/splash_screen',
      getPages: [
        GetPage(name: '/', page: () => const Home_page()),
        GetPage(name: '/login_page', page: () => const Login_page()),
        GetPage(name: '/splash_screen', page: () => const Splash_screen()),
        GetPage(name: '/cart_page', page: () => const Cart_page()),
        GetPage(name: '/coupon_page', page: () => const Coupon_page()),
        GetPage(name: '/setting_page', page: () => const Setting_page()),
      ],
    ),
  );
}
