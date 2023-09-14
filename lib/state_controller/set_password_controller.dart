
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/network_response.dart';
import 'package:task_manager_using_getx/data/services/network_caller.dart';
import 'package:task_manager_using_getx/data/utills/urls.dart';
import 'package:task_manager_using_getx/ui/screens/auth/login_screen.dart';

class SetPasswordController extends GetxController {
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isSettingPassword = false.obs;

  Future<void> setPassword() async {
    isSettingPassword.value = true;

    Map<String, dynamic> responseBody = {
      "email": Get.arguments['email'],
      "OTP": Get.arguments['otp'],
      "password": passwordTEController.text,
    };

    final NetworkResponse response = await NetworkCaller()
        .postRequest(Urls.recoverResetPass, responseBody);

    isSettingPassword.value = false;

    if (response.isSuccessfull) {
      Get.offAll(() => login_screen());
      Get.snackbar("Success", "Password Changed Successfully");
    } else {
      Get.snackbar("Error", "Password Changing Failed");
    }
  }
}
