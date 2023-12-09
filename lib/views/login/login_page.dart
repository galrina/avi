import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/utils/app_constants.dart';
import 'package:avi/utils/baseClass.dart';
import 'package:avi/views/dashboard/dashboard_page.dart';
import 'package:avi/widgets/form_input_with_hint_on_top.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/rounded_edged_button.dart';
import '../../controllers/login/login_controller.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with BaseClass {
  String _groupValue = '';

  void checkRadio(String value) {
    setState(() {
      if (value == "freelancer") {
        AppConstants.isFreelancer = true;
      } else {
        AppConstants.isFreelancer = false;
      }

      _groupValue = value;
    });
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LoginController _loginController = Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              const Image(
                image: AssetImage("assets/logo.png"),
                height: 30,
                width: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "Klaar",
                style: GoogleFonts.inter(
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                          value: 'freelancer',
                          groupValue: _groupValue,
                          activeColor: AppColors.primaryColor,
                          onChanged: (value) {
                            checkRadio(value as String);
                          }),
                      Text(
                        'Freelancer',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                          value: 'client',
                          groupValue: _groupValue,
                          activeColor: AppColors.primaryColor,
                          onChanged: (value) {
                            checkRadio(value as String);
                          }),
                      Text(
                        'Client',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            FormInputWithHint(
              label: 'Email',
              hintText: ' Enter your email',
              controller: _emailController,
              prefixIcon: const Icon(
                Icons.email,
                size: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FormInputWithHint(
              label: 'Password',
              hintText: ' Enter your password',
              obscureText: true,
              controller: _passwordController,
              prefixIcon: const Icon(
                Icons.lock,
                size: 16,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundedEdgedButton(
              buttonText: "Login",
              onButtonClick: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                if (_groupValue.isEmpty) {
                  AppConstants.showError(
                      title: "Role", message: "Please select your role");
                } else if (email.isEmpty) {
                  AppConstants.showError(
                      title: "Email", message: "Email cannot be empty");
                } else if (!EmailValidator.validate(email)) {
                  AppConstants.showError(
                      title: "Email", message: "Email format is not correct");
                } else if (password.isEmpty) {
                  AppConstants.showError(
                      title: "Password", message: "Password cannot be empty");
                } else if (password.length < 7) {
                  AppConstants.showError(
                      title: "Password", message: "Password is too short");
                } else {
                  try {
                    showCircularDialog(context);
                    await _loginController.getUserDetail(
                        email, password, _groupValue);
                    if (mounted) {
                      popToPreviousScreen(context: context);
                    }
                    Get.offAll(() => DashboardPage());
                  } catch (e) {
                    if (mounted) {
                      popToPreviousScreen(context: context);
                    }
                    showError(title: "Error", message: e.toString());
                  }
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 22.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.inter(
                      color: AppColors.hintGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      ' Register now!',
                      style: GoogleFonts.inter(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Get.to(() => const RegisterPage());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
