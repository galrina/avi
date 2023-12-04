import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/utils/app_constants.dart';
import 'package:avi/views/new_record/new_record_page.dart';

import '../../utils/app_colors.dart';

class ProjectOverviewPage extends StatelessWidget {
  const ProjectOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      index == 0 ? "Week x" : "Date, time ,duration",
                      style:
                          GoogleFonts.inter(color: AppColors.backgroundColor),
                    ),
                    subtitle: Text(
                      index == 0 ? "3 h 50 min" : "Enter Title",
                      style:
                          GoogleFonts.inter(color: AppColors.backgroundColor),
                    ),
                  );
                }),
          ),
          AppConstants.isSpecialist
              ? GestureDetector(
                  onTap: () {
                    Get.to(() => NewRecordPage());
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: AppColors.primaryColor,
                    child: Center(
                      child: Text(
                        "Add new record",
                        style: GoogleFonts.inter(color: AppColors.bgWhite),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
