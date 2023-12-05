import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/controllers/new_record/new_record_controller.dart';
import 'package:avi/utils/app_colors.dart';
import 'package:avi/utils/baseClass.dart';

import '../../widgets/form_input_with_hint_on_top.dart';
import '../../widgets/rounded_edged_button.dart';

class NewRecordPage extends StatelessWidget with BaseClass {
  final String projectId;

  final String clientId;

  NewRecordPage({Key? key, required this.projectId, required this.clientId})
      : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  NewRecordController newRecordController = Get.put(NewRecordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Record",
          style: GoogleFonts.inter(color: AppColors.primaryColor),
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
                  "Start",
                  style:
                      GoogleFonts.inter(color: AppColors.bgWhite, fontSize: 27),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Timer",
              style: GoogleFonts.inter(color: AppColors.primaryColor),
            ),
            const SizedBox(
              height: 20,
            ),
            FormInputWithHint(
              label: 'Name',
              hintText: 'Enter Name',
              controller: nameController,
            ),
            const SizedBox(
              height: 30,
            ),
            FormInputWithHint(
              maxLine: 5,
              label: 'Comments',
              controller: commentController,
              hintText: 'Add Comment',
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: RoundedEdgedButton(
                    buttonText: "Cancel",
                    buttonBackground: Colors.white,
                    buttonTextColor: Colors.black,
                    onButtonClick: () {
                      popToPreviousScreen(context: context);
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: RoundedEdgedButton(
                    buttonText: "Submit",
                    onButtonClick: () async {
                      String name = nameController.text.trim();
                      String comment = commentController.text.trim();

                      if (name.isEmpty) {
                        showError(title: "Name", message: "Please add Name");
                      } else if (comment.isEmpty) {
                        showError(
                            title: "Comment", message: "Please add Comment");
                      } else {
                        try {
                          showCircularDialog(context);
                          await newRecordController.addNewRecord(
                              name: name,
                              comment: comment,
                              projectId: projectId,
                              clientId: clientId);
                          popToPreviousScreen(context: context);
                          nameController.text = "";
                          commentController.text = "";
                          showSuccess(
                              title: "New Record",
                              message: "New Record added successfully");
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
