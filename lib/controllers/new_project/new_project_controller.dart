import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:avi/utils/baseClass.dart';
import 'package:avi/utils/local_keys.dart';

import '../../models/user_data/user_model.dart';

class NewProjectController extends GetxController with BaseClass {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewProject({
    required String title,
    required String freelancerEmail,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> userData = await _firebaseFirestore
          .collection("users")
          .where(
            "email",
            isEqualTo: freelancerEmail,
          )
          .where(
            "role",
            isEqualTo: "freelancer",
          )
          .get();
      if (userData.docs.isEmpty) {
        throw "Freelancer email does not exist";
      }
      CollectionReference<Map<String, dynamic>> collectionReference =
          _firebaseFirestore.collection("projects");
      String docId = collectionReference.doc().id;
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);
      Map<String, dynamic> userDetail = {
        "freelancerEmail": freelancerEmail,
        "freelancerId": userData.docs.elementAt(0)["userId"],
        "projectId": docId,
        "title": title,
        "userId": result.userId,
        "isApproved": "waiting",
      };

      userDetail.putIfAbsent("createdOn", () => FieldValue.serverTimestamp());

      collectionReference.doc(docId).set(userDetail);
    } catch (e) {
      throw e.toString();
    }
  }
}
