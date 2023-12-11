import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:avi/views/new_record/new_record_page.dart';
import 'package:avi/utils/baseClass.dart';

import '../../controllers/new_record/new_record_controller.dart';
import '../../utils/app_colors.dart';
import '../project_screenshots/project_screenshots_page.dart';

class ProjectOverviewPage extends StatefulWidget {
  final String projectId;
  final String projectName;

  final String clientId;

  const ProjectOverviewPage(
      {super.key, required this.projectId, required this.clientId, required this.projectName});

  @override
  State<ProjectOverviewPage> createState() => _ProjectOverviewPageState();
}

class _ProjectOverviewPageState extends State<ProjectOverviewPage>
    with BaseClass {
  NewRecordController newRecordController = Get.put(NewRecordController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newRecordController.getPreviousAddedRecords(projectId: widget.projectId);
  }

  String formatAndGetDateDifference(
      {required String startDateTime, required String endDateTime}) {
    if (startDateTime.isEmpty || endDateTime.isEmpty) {
      return "";
    } else if (endDateTime == "00:00") {
      return "00:00";
    }
    print(startDateTime);
    print(endDateTime);
    DateTime startTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(startDateTime);

    DateTime parseDate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(endDateTime);

    int data = parseDate.difference(startTime).inMinutes;
    print(data);
    var d = Duration(minutes: data);
    List<String> parts = d.toString().split(':');
    print("parts");
    print(parts);
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<NewRecordController>(
                init: newRecordController,
                builder: (snapshot) {
                  return newRecordController.recordsList == null
                      ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.bgBlue,
                      ),
                    ),
                  )
                      : ListView.builder(
                      itemCount:
                      newRecordController.recordsList?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            pushToNextScreen(
                                context: context,
                                destination: ProjectScreenShotsPage(
                                  recordId: snapshot.recordsList!
                                      .elementAt(index)
                                      .recordId ??
                                      "",
                                  projectId: widget.projectId,
                                  comment: snapshot.recordsList!
                                      .elementAt(index)
                                      .recordComment ??
                                      "",
                                  title: widget.projectName,
                                ));
                          },
                          title: Text(
                            formatAndGetDateDifference(
                              startDateTime: snapshot.recordsList
                                  ?.elementAt(index)
                                  .startTime ??
                                  "",
                              endDateTime: snapshot.recordsList
                                  ?.elementAt(index)
                                  .endTime ??
                                  "",
                            ),
                            style: GoogleFonts.inter(
                                color: AppColors.primaryColor),
                          ),
                          subtitle: Text(
                            snapshot.recordsList
                                ?.elementAt(index)
                                .recordName ??
                                "",
                            style: GoogleFonts.inter(
                                color: AppColors.backgroundColor),
                          ),
                        );
                      });
                }),
          ),
          getRole() == "freelancer"
              ? GestureDetector(
                  onTap: () {
                    Get.to(() => NewRecordPage(
                          projectId: widget.projectId,
                          clientId: widget.clientId,
                        ));
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    color: AppColors.primaryColor,
                    child: Center(
                      child: Text(
                        "ADD NEW RECORD",
                        style: GoogleFonts.inter(color: AppColors.backgroundColor),
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
