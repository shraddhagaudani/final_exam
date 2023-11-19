import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../models/theme_model.dart';
import '../utills/utills.dart';



class Themecontroller extends GetxController {
  ThemeModel themeModel = ThemeModel(isdark: box.read('isDarkMode') ?? false);


  changeTheme({required bool Val}) {
    themeModel.isdark = Val;
    box.write('isDarkMode', themeModel.isdark);
    (themeModel.isdark)
        ? Get.changeTheme(ThemeData.dark(
            useMaterial3: true,
          ))
        : Get.changeTheme(ThemeData.light(
            useMaterial3: true,
          ));
    update();
  }
}
