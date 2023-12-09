import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:avi/models/record_screenshots/record_screenshots_model.dart';
import 'package:avi/models/records/record_model.dart';
import 'package:avi/utils/baseClass.dart';
import 'package:avi/utils/local_keys.dart';

import '../../models/user_data/user_model.dart';

class NewRecordController extends GetxController with BaseClass {
  String recordTimeOnScreen = "00:00";
  int currentRecordTime = 0;

  updateRecordTime() {
    if (currentRecordTime != 60) {
      currentRecordTime = currentRecordTime + 3;
      recordTimeOnScreen = "00:$currentRecordTime";
      update();
    }
  }

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String recordId = "";
  List<RecordModel>? recordsList;
  List<RecordScreenshotsModel>? recordScreenShotsList;

  Future<void> getPreviousAddedRecords({required String projectId}) async {
    try {
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);
      QuerySnapshot<Map<String, dynamic>> recordData = await _firebaseFirestore
          .collection("records")
          .where(
            "projectId",
            isEqualTo: projectId,
          )
          .get();
      print(recordData.docs.length);
      recordsList = recordData.docs
          .map(
            (data) => RecordModel.fromJson(data.data()),
          )
          .toList();
      update();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> addNewRecord({
    required String name,
    required String comment,
    required String projectId,
    required String clientId,
  }) async {
    try {
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);

      CollectionReference<Map<String, dynamic>> collectionReference =
          _firebaseFirestore.collection("records");
      String docId = collectionReference.doc().id;
      Map<String, dynamic> userDetail = {
        "freelancerEmail": result.getEmail(),
        "freelancerName": "${result.getFirstName()!} ${result.getLastName()!}",
        "freelancerId": result.userId,
        "projectId": projectId,
        "clientId": clientId,
        "recordId": docId,
        "recordName": name,
        "recordComment": comment,
        "startTime": DateTime.now().toString(),
        "endTime": "00:00",
      };

      recordId = docId;

      userDetail.putIfAbsent("createdOn", () => FieldValue.serverTimestamp());

      collectionReference.doc(docId).set(userDetail);
      /*} else {}*/
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateArray({
    required String endTime,
  }) async {
    final prefData = localStorage.read(LocalKeys.userData);
    var result = UserDataModel.fromJson(prefData);
    QuerySnapshot<Map<String, dynamic>> recordData = await _firebaseFirestore
        .collection("records")
        .where(
          "recordId",
          isEqualTo: recordId,
        )
        .get();
    CollectionReference<Map<String, dynamic>> collectionReference =
        _firebaseFirestore.collection("records");

    if (recordData.docs.isNotEmpty) {
      await collectionReference
          .doc(recordData.docs.elementAt(0)["recordId"])
          .update({"endTime": endTime});
    }
    update();
  }

  Future<void> uploadScreenCapturedScreeShots(
      String imageUrl, String projectId, String recordId) async {
    try {
      print(recordId);
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);

      CollectionReference<Map<String, dynamic>> collectionReference =
          _firebaseFirestore.collection("recordsScreenShots");

      String docId = collectionReference.doc().id;
      Map<String, dynamic> userDetail = {
        "projectId": projectId,
        "recordId": recordId,
        "screenshotDocumentId": docId,
        "capturedScreeShot": imageUrl
      };

      userDetail.putIfAbsent("createdOn", () => FieldValue.serverTimestamp());

      collectionReference.doc(docId).set(userDetail);
      /*} else {}*/
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> getScreenShots(String projectId, String recordId) async {
    try {
      print(recordId);
      recordScreenShotsList = null;
      final prefData = localStorage.read(LocalKeys.userData);
      var result = UserDataModel.fromJson(prefData);

      QuerySnapshot<Map<String, dynamic>> recordData = await _firebaseFirestore
          .collection("recordsScreenShots")
          .where(
            "projectId",
            isEqualTo: projectId,
          )
          .where(
            "recordId",
            isEqualTo: recordId,
          )
          .get();

      print(recordData.docs.length);
      recordScreenShotsList = recordData.docs
          .map(
            (data) => RecordScreenshotsModel.fromJson(data.data()),
      )
          .toList();
      update();
      /*} else {}*/
    } catch (e) {
      throw e.toString();
    }
  }
}
