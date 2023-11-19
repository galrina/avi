import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../widgets/form_input_with_hint_on_top.dart';
import '../../widgets/rounded_edged_button.dart';

class NewProjectPage extends StatelessWidget {
  const NewProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Project",
          style: GoogleFonts.crimsonText(color: AppColors.primaryColor),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(

          children: [
            SizedBox(height: 100,),
            const FormInputWithHint(
              label: 'Project Title',
              hintText: 'Write project title',

            ),
            const SizedBox(height: 30,),
            const FormInputWithHint(
              label: 'Specialist email',
              hintText: 'Assign Specialist (email)',

            ),
            const SizedBox(height: 50,),
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
                  buttonText: "Send Invitation",
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