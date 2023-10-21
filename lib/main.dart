// ignore_for_file: prefer_const_constructors, unused_import

import 'package:ecommerce_app/controllers/product/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/app_string.dart';
import 'constants/colors.dart';
import 'controllers/product/cart_controller.dart';
import 'views/auth/sign_in_view.dart';
import 'views/dashboard/home.dart';
import 'widget/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      themeMode: ThemeMode.light,
      // defaultTransition: Transition.noTransition,
      home: HomePage(),
      initialBinding: BindingsBuilder(() {
        Get.put(DataController());
        Get.put(CartController());
      }),
    );
  }
}
