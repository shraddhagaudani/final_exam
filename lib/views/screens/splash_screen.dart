import 'package:final_exam/controller/introscreen_controller.dart';
import 'package:final_exam/controller/login_out_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utills/helper/firebase_auth_helper.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  Widget build(BuildContext context) {
    IntroAccessController introAccessController =
        Get.put(IntroAccessController());
    LogINOutController logINOutController = Get.put(LogINOutController());
    Future.delayed(const Duration(seconds: 5)).then(
      (value) => (introAccessController.introAccess_Model.introaccess)
          ? (logINOutController.loginInOutModel.islogin)
              ? Get.offAndToNamed(
                  '/',
                  arguments: FireBaseAuthHelper.firebaseAuth.currentUser,
                )
              : Get.offAndToNamed(
                  '/login_page',
                  // arguments: FirebaseAuthHelper.firebaseAuth.currentUser,
                )
          : Get.offAllNamed(
              '/intro_screen',
              // arguments: FirebaseAuthHelper.firebaseAuth.currentUser,
            ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/shop_logo.png",
              height: 400,
              width: 400,
            ),
          ],
        ),
      ),
    );
  }
}
