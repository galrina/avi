import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:avi/utils/baseClass.dart';
import 'package:avi/utils/local_keys.dart';

import '../../models/user_data/user_model.dart';

class NewRecordController extends GetxController with BaseClass {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addNewRecord({
    required String name,
    required String comment,
    required String projectId,
    required String clientId,
  }) async {
    try {
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);
      QuerySnapshot<Map<String, dynamic>> recordData = await _firebaseFirestore
          .collection("records")
          .where(
            "freelancerId",
            isEqualTo: result.userId,
          )
          .where("projectId", isEqualTo: projectId)
          .get();
      CollectionReference<Map<String, dynamic>> collectionReference =
          _firebaseFirestore.collection("records");
      if (recordData.docs.isEmpty) {
        String docId = collectionReference.doc().id;
        Map<String, dynamic> userDetail = {
          "freelancerEmail": result.getEmail(),
          "freelancerName":
              "${result.getFirstName()!} ${result.getLastName()!}",
          "freelancerId": result.userId,
          "projectId": projectId,
          "clientId": clientId,
          "recordId": docId,
          "recordDetails": [
            {
              "recordName": name,
              "recordComment": comment,
              "startTime": FieldValue.serverTimestamp(),
              "endTime": FieldValue.serverTimestamp(),
            }
          ],
        };

        userDetail.putIfAbsent("createdOn", () => FieldValue.serverTimestamp());

        collectionReference.doc(docId).set(userDetail);
      } else {}
    } catch (e) {
      throw e.toString();
    }
  }
}
