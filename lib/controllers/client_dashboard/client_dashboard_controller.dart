import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:avi/models/client_projects/client_projects_model.dart';
import 'package:avi/utils/baseClass.dart';

import '../../models/user_data/user_model.dart';
import '../../utils/local_keys.dart';

class ClientDashboardController extends GetxController with BaseClass {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<ClientProjectsModel>? clientProjectsModel;

  Future<void> getClientProjects() async {
    try {
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);

      QuerySnapshot projectData = await _firebaseFirestore
          .collection("projects")
          .where(
            "userId",
            isEqualTo: result.userId,
          )
          .orderBy('createdOn', descending: true)
          .get();
      if (projectData.docs.isNotEmpty) {
        clientProjectsModel = projectData.docs
            .map(
              (data) => ClientProjectsModel.fromJson(
                  data.data() as Map<String, dynamic>),
            )
            .toList();
      } else {
        clientProjectsModel = [];
      }
      update();
    } catch (e) {
      clientProjectsModel = [];
      update();
    }
  }

  /// Removing project from firebase then locally from above arraylist
  Future<void> deleteUnApprovedProject(String documentId, int index) async {
    try {
      if (documentId.isEmpty) return;
      await _firebaseFirestore.collection("projects").doc(documentId).delete();
      clientProjectsModel?.removeAt(index);
      update();
    } catch (e) {
      throw e.toString();
    }
  }
}
