
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/network_response.dart';
import 'package:task_manager_using_getx/data/services/network_caller.dart';
import 'package:task_manager_using_getx/data/utills/urls.dart';

class SignupController extends GetxController {
  final TextEditingController firstNameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController lastNameTEController = TextEditingController();
  final TextEditingController mobileTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isSignupProgress = false.obs;

  Future<void> userSignUp() async {
    if (!formKey.currentState!.validate()) return;

    isSignupProgress.value = true;

    final requestBody = {
      "email": emailTEController.text.trim(),
      "firstName": firstNameTEController.text.trim(),
      "lastName": lastNameTEController.text.trim(),
      "mobile": mobileTEController.text,
      "password": passwordTEController.text,
      "photo": "",
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.registration, requestBody);

    isSignupProgress.value = false;

    if (response.isSuccessfull) {
      clearTextFields();
      Get.snackbar('Success', 'Registration successful!');
    } else {
      Get.snackbar('Failed', 'Registration failed! Try again.');
    }
  }

  void clearTextFields() {
    emailTEController.clear();
    firstNameTEController.clear();
    lastNameTEController.clear();
    mobileTEController.clear();
    passwordTEController.clear();
  }
}