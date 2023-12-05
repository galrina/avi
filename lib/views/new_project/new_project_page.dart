import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/controllers/client_dashboard/client_dashboard_controller.dart';
import 'package:avi/controllers/new_project/new_project_controller.dart';
import 'package:avi/utils/baseClass.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/form_input_with_hint_on_top.dart';
import '../../widgets/rounded_edged_button.dart';

class NewProjectPage extends StatelessWidget with BaseClass {
  NewProjectPage({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  NewProjectController newProjectController = Get.put(NewProjectController());
  ProjectDashboardController projectDashboardController =
      Get.put(ProjectDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Project",
          style: GoogleFonts.poppins(color: AppColors.primaryColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            FormInputWithHint(
              label: 'Project Title',
              hintText: 'Write project title',
              controller: _titleController,
            ),
            const SizedBox(
              height: 30,
            ),
            FormInputWithHint(
              label: 'Freelancer email',
              hintText: 'Assign Freelancer (email)',
              controller: _emailController,
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: RoundedEdgedButton(
                    buttonText: "Cancel",
                    buttonBackground: Colors.white,
                    buttonTextColor: Colors.black,
                    onButtonClick: () {
                      _emailController.text = "";
                      _titleController.text = "";
                      popToPreviousScreen(context: context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RoundedEdgedButton(
                    buttonText: "Send Invitation",
                    onButtonClick: () async {
                      String title = _titleController.text.trim();
                      String email = _emailController.text.trim();
                      if (title.isEmpty) {
                        AppConstants.showError(
                            title: "Title", message: "Title cannot be empty");
                      } else if (email.isEmpty) {
                        AppConstants.showError(
                            title: "Email", message: "Email cannot be empty");
                      } else if (!EmailValidator.validate(email)) {
                        AppConstants.showError(
                            title: "Email",
                            message: "Email format is not correct");
                      } else {
                        try {
                          showCircularDialog(context);
                          await newProjectController.addNewProject(
                              title: title, freelancerEmail: email);
                          popToPreviousScreen(context: context);
                          _emailController.text = "";
                          _titleController.text = "";
                          await projectDashboardController.getProjects();
                          showSuccess(
                              title: "Added",
                              message: "Invitation sent successfully");
                        } catch (e) {
                          popToPreviousScreen(context: context);
                          showError(title: "Error", message: e.toString());
                        }
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
