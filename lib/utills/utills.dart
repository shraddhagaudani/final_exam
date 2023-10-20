import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../models/product_model.dart';

final GlobalKey<FormState> signUpformkey = GlobalKey<FormState>();
final GlobalKey<FormState> signInformkey = GlobalKey<FormState>();

// TextEditingController signupemailController = TextEditingController();
// TextEditingController signuppasswordController = TextEditingController();
//
// TextEditingController signinemailController = TextEditingController();
// TextEditingController signinpasswordController = TextEditingController();
//
// TextEditingController phoneController = TextEditingController();
// //TextEditingController phonepasswordController = TextEditingController();
// TextEditingController otpController = TextEditingController();
//
//
// String? email;
// String? password;

final box = GetStorage();

List<DataBaseProduct> checkout = [];
TextEditingController controller = TextEditingController();

int totalPrice = 0;
String? name;
int coupon1 = 5;
int coupon2 = 10;
int coupon3 = 15;
int coupon4 = 20;

bool apply5 = false;
bool apply10 = false;
bool apply15 = false;
bool apply20 = false;