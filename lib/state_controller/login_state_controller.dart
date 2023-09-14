import 'package:get/get.dart';

import '../data/models/auth_utility.dart';
import '../data/models/login_model.dart';
import '../data/models/network_response.dart';
import '../data/services/network_caller.dart';
import '../data/utills/urls.dart';
import '../ui/screens/bottom_nav_base_screen.dart';
class LoginController extends GetxController {
  final RxBool loginInProgress = false.obs;

  Future<void> login(String email, String password) async {
    loginInProgress.value = true;
    update();

    Map<String, dynamic> requestBody = {"email": email, "password": password};
    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.login, requestBody, isLogin: true);

    loginInProgress.value = false;
    update();

    if (response.isSuccessfull) {
      final LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      Get.snackbar('Success', 'Logged in successfully!');
      Get.offAll( BaseBottomNavBar());
    } else {
      Get.snackbar('Failed', 'Login failed! Try again.');
    }
  }
}
