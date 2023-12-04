import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterUserController extends GetxController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> createUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    ///  AUTHENTICATE AND Create User On Firebase
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    /// ADD NEW USER DETAILS IN USER COLLECTION
    CollectionReference<Map<String, dynamic>> collectionReference =
        _firebaseFirestore.collection("users");
    String docId = collectionReference.doc().id;
    Map<String, dynamic> userDetail = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "role": role
    };
    userDetail.putIfAbsent("userId", () => docId);
    userDetail.putIfAbsent("createdOn", () => FieldValue.serverTimestamp());
    collectionReference.doc(docId).set(userDetail);
  }
}
