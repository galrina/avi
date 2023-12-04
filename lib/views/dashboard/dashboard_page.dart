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
  ClientDashboardController clientDashboardController =
  Get.put(ClientDashboardController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientProjects();
  }

  getClientProjects() async {
    await clientDashboardController.getClientProjects();
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
      body: Column(
          children: [
      Expanded(
          child: GetBuilder<ClientDashboardController>(
          init: clientDashboardController,
          builder: (snapshot) {
            return snapshot.clientProjectsModel == null
                ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.bgGreen,
                ),
              ),
            )
                : snapshot.clientProjectsModel!.isEmpty
                ? Center(
              child: Text(
                "No Projects Found",
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            )
                : ListView.builder(
                itemCount:
                snapshot.clientProjectsModel?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Get.to(() => const ProjectOverviewPage());
                    },
                    title: Text(
                      snapshot.clientProjectsModel
                          ?.elementAt(index)
                          .title ?? "",
                      style: GoogleFonts.poppins(
                          color: AppColors.primaryColor),
                    ),
                    subtitle: Text(
                      snapshot.clientProjectsModel
                          ?.elementAt(index)
                          .isApproved ==
                          "waiting"
                          ? "Waiting for approval"
                          : snapshot.clientProjectsModel
                          ?.elementAt(index)
                          .freelancerEmail ??
                          '',
                      style: GoogleFonts.inter(
                          color: AppColors.primaryColor),
                    ),
                    trailing: snapshot.clientProjectsModel
                        ?.elementAt(index)
                        .isApproved == "waiting"
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
                              snapshot.clientProjectsModel
                                  ?.elementAt(
                                  index)
                                  .projectId ?? "",
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
                    ),
                  );
                });
          }),
    )
    ]
    );
  }
}