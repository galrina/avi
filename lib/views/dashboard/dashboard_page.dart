import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avi/controllers/client_dashboard/client_dashboard_controller.dart';
import 'package:avi/utils/app_colors.dart';
import 'package:avi/utils/baseClass.dart';
import 'package:avi/utils/local_keys.dart';
import 'package:avi/views/login/login_page.dart';
import 'package:avi/views/new_project/new_project_page.dart';

import '../../utils/app_constants.dart';
import '../project_overview/project_overview_page.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with BaseClass {
  ProjectDashboardController projectDashboardController =
      Get.put(ProjectDashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientProjects();
  }

  getClientProjects() async {
    await projectDashboardController.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Projects",
              style: GoogleFonts.inter(
                  color: AppColors.backgroundColor,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await localStorage.remove(LocalKeys.userData);
              Get.offAll(
                const LoginPage(),
              );
            },
            child: Text(
              "Log Out",
              style: GoogleFonts.inter(color: Colors.black),
            ),
          )
        ],
      ),
    );
    body:
    Column(
      children: [
        Expanded(
          child: GetBuilder<ProjectDashboardController>(
              init: projectDashboardController,
              builder: (snapshot) {
                return snapshot.projectsModel == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.bgGreen,
                          ),
                        ),
                      )
                    : snapshot.projectsModel!.isEmpty
                        ? Center(
                            child: Text(
                              "No Projects Found",
                              style: GoogleFonts.poppins(color: Colors.red),
                            ),
                          )
                        : ListView.builder(
                            itemCount: snapshot.projectsModel?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                onTap: () {
                                  if (getRole() == "freelancer") {
                                    if (snapshot.projectsModel
                                            ?.elementAt(index)
                                            .isApproved ==
                                        "waiting") {
                                      showError(
                                          title: snapshot.projectsModel
                                                  ?.elementAt(index)
                                                  .title ??
                                              "",
                                          message:
                                              "Please approve project to add the record");
                                    } else if (snapshot.projectsModel
                                            ?.elementAt(index)
                                            .isApproved ==
                                        "rejected") {
                                      showError(
                                          title: snapshot.projectsModel
                                                  ?.elementAt(index)
                                                  .title ??
                                              "",
                                          message:
                                              "You cannot add record as you have rejected the project");
                                    } else {
                                      Get.to(() => ProjectOverviewPage(
                                            projectId: snapshot.projectsModel
                                                    ?.elementAt(index)
                                                    .projectId ??
                                                "",
                                            clientId: snapshot.projectsModel
                                                    ?.elementAt(index)
                                                    .userId ??
                                                "",
                                          ));
                                    }
                                  }
                                },
                                title: getRole() == "client"
                                    ? Text(
                                        snapshot.projectsModel
                                                ?.elementAt(index)
                                                .title ??
                                            "",
                                        style: GoogleFonts.poppins(
                                            color: AppColors.primaryColor),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              snapshot.projectsModel
                                                      ?.elementAt(index)
                                                      .title ??
                                                  "",
                                              style: GoogleFonts.poppins(
                                                  color:
                                                      AppColors.primaryColor),
                                            ),
                                          ),
                                          snapshot.projectsModel
                                                      ?.elementAt(index)
                                                      .isApproved ==
                                                  "waiting"
                                              ? Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        try {
                                                          showCircularDialog(
                                                              context);
                                                          await snapshot
                                                              .changeProjectStatus(
                                                                  index, true);
                                                          if (mounted) {
                                                            popToPreviousScreen(
                                                                context:
                                                                    context);
                                                          }
                                                        } catch (e) {
                                                          if (mounted) {
                                                            popToPreviousScreen(
                                                                context:
                                                                    context);
                                                          }
                                                          showError(
                                                              title: "Error",
                                                              message:
                                                                  e.toString());
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.check),
                                                      color: Colors.green,
                                                    ),
                                                    IconButton(
                                                      onPressed: () async {
                                                        try {
                                                          showCircularDialog(
                                                              context);
                                                          await snapshot
                                                              .changeProjectStatus(
                                                                  index, false);
                                                          if (mounted) {
                                                            popToPreviousScreen(
                                                                context:
                                                                    context);
                                                          }
                                                        } catch (e) {
                                                          if (mounted) {
                                                            popToPreviousScreen(
                                                                context:
                                                                    context);
                                                          }
                                                          showError(
                                                              title: "Error",
                                                              message:
                                                                  e.toString());
                                                        }
                                                      },
                                                      icon: const Icon(Icons
                                                          .cancel_outlined),
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                subtitle: Text(
                                  getRole() == "client"
                                      ? snapshot.projectsModel
                                                  ?.elementAt(index)
                                                  .isApproved ==
                                              "waiting"
                                          ? "Waiting for approval"
                                          : snapshot.projectsModel
                                                  ?.elementAt(index)
                                                  .freelancerName ??
                                              ''
                                      : snapshot.projectsModel
                                              ?.elementAt(index)
                                              .clientName ??
                                          '',
                                  style: GoogleFonts.inter(
                                      color: AppColors.primaryColor),
                                ),
                                trailing: getRole() == "client"
                                    ? snapshot.projectsModel
                                                ?.elementAt(index)
                                                .isApproved ==
                                            "waiting"
                                        ? const SizedBox()
                                        : IconButton(
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ),
                                            onPressed: () async {
                                              try {
                                                showCircularDialog(context);
                                                await snapshot
                                                    .deleteUnApprovedProject(
                                                        snapshot.projectsModel
                                                                ?.elementAt(
                                                                    index)
                                                                .projectId ??
                                                            "",
                                                        index);
                                                if (mounted) {
                                                  popToPreviousScreen(
                                                      context: context);
                                                }

                                                showSuccess(
                                                    title: "Deleted",
                                                    message:
                                                        "Project Deleted Successfully");
                                              } catch (e) {
                                                if (mounted) {
                                                  popToPreviousScreen(
                                                      context: context);
                                                }
                                                showError(
                                                    title: "Error",
                                                    message: e.toString());
                                              }
                                            },
                                          )
                                    : SizedBox(),
                              );
                            });
              }),
        ),
        getRole() == "client"
            ? Container()
            : GestureDetector(
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
                      style: GoogleFonts.poppins(color: AppColors.bgWhite),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
