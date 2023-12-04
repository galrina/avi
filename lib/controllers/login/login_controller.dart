import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:avi/utils/baseClass.dart';
import '../../models/login/login_model.dart';
import '../../models/user_data/user_model.dart';
import '../../utils/local_keys.dart';

class LoginController extends GetxController with BaseClass {
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  Future<UserDataModel?> getUserDetail(
      String email, String password, String role) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      QuerySnapshot<Map<String, dynamic>> userData = await _firebaseFireStore
          .collection("users")
          .where(
            "email",
            isEqualTo: email,
          )
          .get();

      if (userData.docs.isNotEmpty) {
        LoginModel loginModel = LoginModel.fromJson(
          userData.docs.elementAt(0).data(),
        );
        if (loginModel.role != role) {
          throw "Please choose correct Role";
        }
        UserDataModel userDataModel = UserDataModel();
        userDataModel.firstName = loginModel.firstName;
        userDataModel.lastName = loginModel.lastName;
        userDataModel.userEmail = loginModel.email;
        userDataModel.isLoggedIn = true;
        userDataModel.userId = loginModel.userId;
        await localStorage.write(
            LocalKeys.userData, userDataModel.toMap(userDataModel));
        return userDataModel;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'We do not have an account for this e-mail address.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password. Please check your password or create a new password by tapping forgot password.';
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        throw 'Invalid user credentials';
      } else {
        if (kDebugMode) {
          print(e.toString());
        }
        throw e.message.toString();
      }
    }
  }
}
