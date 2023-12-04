import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:avi/views/dashboard/dashboard_page.dart';

import '../../models/user_data/user_model.dart';
import '../../utils/local_keys.dart';
import '../../views/login/login_page.dart';

class CheckLoginStatusController extends GetxController {
  final localStorage = GetStorage();

  checkLogin() async {
    final prefData = localStorage.read(LocalKeys.userData);

    if (prefData != null) {
      var result = UserDataModel.fromJson(prefData);

      if (result.isLoggedIn == null || result.isLoggedIn == false) {
        Get.offAll(() => LoginPage());
      } else {
        Get.offAll(() => DashboardPage());
      }
    } else {
      Get.offAll(() => LoginPage());
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 3000), () {
      checkLogin();
    });
  }
}