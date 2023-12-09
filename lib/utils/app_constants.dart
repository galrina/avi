import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConstants {
  static bool isFreelancer = false;


  static void showError({
  required String title,
  required String message,
}) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade900,
        duration: const Duration(milliseconds: 2000));
  }
}