import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar({required String message, String? title}) {
  Get.rawSnackbar(
    title: title ?? "Success",
    message: message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black,
    borderRadius: 8.0,
    duration: const Duration(milliseconds: 1000), // Set the duration for the short message
  );
}
