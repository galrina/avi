import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avi/controllers/check_login_status/check_login_status_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});
  CheckLoginStatusController checkLoginStatusController =
      Get.put(CheckLoginStatusController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage("assets/logo.png"),
          height: 250,
          width: 250,
        ),
      ),
    );
  }
}
