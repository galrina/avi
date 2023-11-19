import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/utils/app_colors.dart';

import '../../widgets/form_input_with_hint_on_top.dart';
import '../../widgets/rounded_edged_button.dart';

class NewRecordPage extends StatelessWidget {
  const NewRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Record",
          style: GoogleFonts.poppins(color: AppColors.primaryColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryColor),
              child: Center(
                child: Text(
                  "Start/Stop",
                  style: GoogleFonts.poppins(color: AppColors.bgWhite),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              "Timer",
              style: GoogleFonts.inter(color: AppColors.primaryColor),
            ),
            const SizedBox(height: 20,),
            const FormInputWithHint(
              label: 'Name',
              hintText: 'Enter Name',

            ),
            const SizedBox(height: 30,),
            const FormInputWithHint(
              maxLine: 5,
              label: 'Comments',
              hintText: 'Add Comment',
            ),
            const SizedBox(height: 30,),
            Row(children: [
              Expanded(
                child: RoundedEdgedButton(
                  buttonText: "Cancel",
                  buttonBackground: Colors.white,
                  buttonTextColor: Colors.black,
                  onButtonClick: () {},
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: RoundedEdgedButton(
                  buttonText: "Submit",
                  onButtonClick: () {},
                ),
              ),
            ],)
          ],
        ),
      ),
    );
  }
}