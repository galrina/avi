import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/utils/app_colors.dart';
import 'package:avi/views/new_project/new_project_page.dart';

import '../../utils/app_constants.dart';
import '../project_overview/project_overview_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              "Projects",
              style: GoogleFonts.crimsonText(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Log Out",
              style: GoogleFonts.inter(color: Colors.red),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Get.to(() => const ProjectOverviewPage());
                    },
                    title: Text(
                      "Project title",
                      style: GoogleFonts.inter(color: AppColors.primaryColor),
                    ),
                    subtitle: Text(
                      AppConstants.isSpecialist?"Employer Name":   index != 4 ? "Waiting for approval" : "Specialist Name",
                      style: GoogleFonts.inter (color: AppColors.primaryColor),
                    ),
                    trailing: index != 4
                        ? const SizedBox()
                        : IconButton(
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  );
                }),
          ),
          AppConstants.isSpecialist?Container():     GestureDetector(
            onTap: () {
              Get.to(() => NewProjectPage());
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: AppColors.primaryColor,
              child: Center(
                child: Text(
                  "New Project",
                  style: GoogleFonts.crimsonText (color: AppColors.bgWhite),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}