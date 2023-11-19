import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/views/dashboard/dashboard_page.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/form_input_with_hint_on_top.dart';
import '../../../widgets/rounded_edged_button.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  String _groupValue = '';
  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            SizedBox(
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
              "Avi",
              style: GoogleFonts.crimsonText(
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
                          value: 'Option1',
                          groupValue: _groupValue,
                          onChanged: (value) {
                            checkRadio(value as String);
                          }),
                      Text(
                        'Specialist',
                        style: GoogleFonts.inter (
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
            const FormInputWithHint(
              label: 'First Name',
              hintText: ' Enter your first name',
              prefixIcon: Icon(
                Icons.person,
                size: 18,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const FormInputWithHint(
              label: 'Last Name',
              hintText: ' Enter your last name',
              prefixIcon: Icon(
                Icons.person,
                size: 18,
              ),
            ),
            const SizedBox(
              height: 15,
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
              height: 15,
            ),
            const FormInputWithHint(
              label: 'Password',
              hintText: ' Enter your password',
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock,
                size: 18,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const FormInputWithHint(
              label: 'Confirm Password',
              hintText: ' Confirm your password',
              obscureText: true,
              prefixIcon: Icon(
                Icons.lock,
                size: 18,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            RoundedEdgedButton(
              buttonText: "Register",
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
                        color: AppColors.primaryColor,
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