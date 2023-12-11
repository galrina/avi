import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/controllers/new_record/new_record_controller.dart';

import '../../utils/app_colors.dart';

class ProjectScreenShotsPage extends StatefulWidget {
  final String projectId;

  final String recordId;
  final String comment;
  final String title;

  const ProjectScreenShotsPage(
      {super.key,
        required this.recordId,
        required this.projectId,
        required this.title,
        required this.comment});

  @override
  State<ProjectScreenShotsPage> createState() => _ProjectScreenShotsPageState();
}

class _ProjectScreenShotsPageState extends State<ProjectScreenShotsPage> {
  final NewRecordController recordController = Get.put(NewRecordController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    recordController.getScreenShots(widget.projectId, widget.recordId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: GoogleFonts.lato(color: Colors.black),
          ),
        ),
        body: GetBuilder<NewRecordController>(
            init: recordController,
            builder: (snapshot) {
              return recordController.recordScreenShotsList == null
                  ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.bgBlue,
                  ),
                ),
              )
                  : Column(
                children: [
                  Text(
                    widget.comment,
                    style: GoogleFonts.lato(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount:
                      snapshot.recordScreenShotsList?.length ?? 0,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(snapshot
                              .recordScreenShotsList!
                              .elementAt(index)
                              .capturedScreeShot!),
                        );
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}