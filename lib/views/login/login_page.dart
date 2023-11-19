import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/utils/app_constants.dart';
import 'package:avi/views/register/register_page.dart';
import 'package:avi/views/dashboard/dashboard_page.dart';
import 'package:avi/widgets/form_input_with_hint_on_top.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screen_capturer/screen_capturer.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../widgets/rounded_edged_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  String _groupValue = '';
  void checkRadio(String value) {
    setState(() {
      if (value == "Option1") {
        AppConstants.isSpecialist = true;
      } else {
        AppConstants.isSpecialist = false;
      }
      _groupValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
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
                "Avi",
                style: GoogleFonts.crimsonText (
                    color: AppColors.primaryColor, fontWeight: FontWeight.w700),
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
                          value: 'Option1',
                          groupValue: _groupValue,
                          activeColor: AppColors.primaryColor,
                          onChanged: (value) {
                            checkRadio(value as String);
                          }),
                      Text(
                        'Specialist',
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
                          value: 'Option2',
                          groupValue: _groupValue,
                          activeColor: AppColors.primaryColor,
                          onChanged: (value) {
                            checkRadio(value as String);
                          }),
                      Text(
                        'Client',
                        style: GoogleFonts.inter (
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
            const FormInputWithHint(
              label: 'Email',
              hintText: ' Enter your email',
              prefixIcon: Icon(
                Icons.email,
                size: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const FormInputWithHint(
              label: 'Password',
              hintText: ' Enter your password',
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock,
                size: 18,
              ),
              suffixIcon: Icon(Icons.visibility_off),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundedEdgedButton(
              buttonText: "Login",
              onButtonClick: () {
                Get.offAll(() => DashboardPage());
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
                      Get.to(() => RegisterPage());
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