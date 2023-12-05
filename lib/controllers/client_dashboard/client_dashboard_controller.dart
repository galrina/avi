import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:avi/models/client_projects/client_projects_model.dart';
import 'package:avi/utils/baseClass.dart';

import '../../models/user_data/user_model.dart';
import '../../utils/local_keys.dart';

class ProjectDashboardController extends GetxController with BaseClass {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<ProjectsModel>? projectsModel;

  Future<void> getProjects() async {
    try {
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);

      print("///");
      print(result.role);
      print(result.userId);
      print("///");

      QuerySnapshot projectData = await _firebaseFirestore
          .collection("projects")
          .where(
            result.role == "client" ? "userId" : "freelancer",
            isEqualTo: result.userId,
          )
          .orderBy('createdOn', descending: true)
          .get();
      print(projectData.docs);
      print(projectData.docs.length);
      if (projectData.docs.isNotEmpty) {
        projectsModel = projectData.docs
            .map(
              (data) =>
                  ProjectsModel.fromJson(data.data() as Map<String, dynamic>),
            )
            .toList();
      } else {
        projectsModel = [];
      }
      update();
    } catch (e) {
      print(e.toString());
      projectsModel = [];
      update();
    }
  }

  /// ---- freelancer can reject or accept the project using this function
  Future<void> changeProjectStatus(int index, bool isAccepted) async {
    try {
      String documentId = projectsModel?.elementAt(index).projectId ?? "";
      if (documentId.isEmpty) return;
      if (projectsModel?.elementAt(index).isApproved == "waiting") {
        await _firebaseFirestore.collection("projects").doc(documentId).update({
          'isApproved': isAccepted ? 'accepted' : "rejected",
        });
      }
      projectsModel?.elementAt(index).isApproved =
          isAccepted ? 'accepted' : "rejected";
      update();
    } catch (e) {
      throw e.toString();
    }
  }

  /// Removing project from firebase then locally from above arraylist
  Future<void> deleteUnApprovedProject(String documentId, int index) async {
    try {
      if (documentId.isEmpty) return;
      await _firebaseFirestore.collection("projects").doc(documentId).delete();
      projectsModel?.removeAt(index);
      update();
    } catch (e) {
      throw e.toString();
    }
  }
}
