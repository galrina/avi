import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/views/dashboard/dashboard_page.dart';
import 'package:avi/controllers/register/register_controller.dart';
import 'package:avi/utils/baseClass.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/form_input_with_hint_on_top.dart';
import '../../../widgets/rounded_edged_button.dart';
import '../../utils/app_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with BaseClass {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _groupValue = '';

  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  final RegisterUserController _registerUserController =
      Get.put(RegisterUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Image(
              image: AssetImage("assets/logo.png"),
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Klaar",
              style: GoogleFonts.inter(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.bgWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio(
                          value: 'freelancer',
                          groupValue: _groupValue,
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
                          value: 'client',
                          groupValue: _groupValue,
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
              height: 15,
            ),
            FormInputWithHint(
              label: 'First Name',
              hintText: ' Enter your first name',
              controller: _firstNameController,
              prefixIcon: const Icon(
                Icons.person,
                size: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            FormInputWithHint(
              label: 'Last Name',
              hintText: ' Enter your last name',
              controller: _lastNameController,
              prefixIcon: const Icon(
                Icons.person,
                size: 16,
              ),
            ),
            const SizedBox(
              height: 15,
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
              height: 15,
            ),
            FormInputWithHint(
              label: 'Password',
              hintText: ' Enter your password',
              controller: _passwordController,
              obscureText: true,
              prefixIcon: const Icon(
                Icons.lock,
                size: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            FormInputWithHint(
              label: 'Confirm Password',
              hintText: ' Confirm your password',
              controller: _confirmPasswordController,
              obscureText: true,
              prefixIcon: const Icon(
                Icons.lock,
                size: 16,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundedEdgedButton(
              buttonText: "Register",
              onButtonClick: () async {
                String firstName = _firstNameController.text.trim();
                String lastName = _lastNameController.text.trim();
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();
                String confirmPassword = _confirmPasswordController.text.trim();
                if (_groupValue.isEmpty) {
                  AppConstants.showError(
                      title: "Role", message: "Please select your role");
                } else if (firstName.isEmpty) {
                  AppConstants.showError(
                      title: "First Name",
                      message: "First Name cannot be empty");
                } else if (lastName.isEmpty) {
                  AppConstants.showError(
                      title: "Last Name", message: "Last Name cannot be empty");
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
                } else if (password.isEmpty) {
                  AppConstants.showError(
                      title: "Confirm Password",
                      message: "Confirm Password cannot be empty");
                } else {
                  try {
                    showCircularDialog(context);

                    await _registerUserController.createUser(
                        email: email,
                        password: password,
                        firstName: firstName,
                        lastName: lastName,
                        role: _groupValue);
                    if (mounted) {
                      popToPreviousScreen(context: context);
                      popToPreviousScreen(context: context);
                    }
                    showSuccess(
                        title: "Success", message: "Registered Successfully");
                  } on FirebaseAuthException catch (e) {
                    if (mounted) {
                      popToPreviousScreen(context: context);
                    }
                    if (kDebugMode) {
                      print(e.toString());
                    }
                    showError(title: "Error", message: e.message.toString());
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
                    "Already have an account?",
                    style: GoogleFonts.inter(
                      color: AppColors.hintGrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      ' Login!',
                      style: GoogleFonts.inter(
                        color: AppColors.backgroundColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
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
