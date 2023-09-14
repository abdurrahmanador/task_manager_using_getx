import 'package:get/get.dart';
import 'package:task_manager_using_getx/state_controller/base_bottom_controller.dart';
import 'package:task_manager_using_getx/state_controller/login_state_controller.dart';
import 'package:task_manager_using_getx/state_controller/otp_verification_conhtroller.dart';
import 'package:task_manager_using_getx/state_controller/set_password_controller.dart';
import 'package:task_manager_using_getx/state_controller/signup_state_controller.dart';
import 'package:task_manager_using_getx/state_controller/summary_count_state_controller.dart';
import 'package:task_manager_using_getx/ui/screens/splashScreen.dart';
import 'package:flutter/material.dart';

class TaskManagerApp extends StatelessWidget {
  final ControllerBinding controllerBinding = Get.put(ControllerBinding());
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.globalKey,
      debugShowCheckedModeBanner: false,
      title: "Task Manager",
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: Size.fromWidth(double.infinity),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.light,
      home: SpashScreen(),
    );
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignupController>(SignupController());
    Get.put<LoginController>(LoginController());
    Get.put<SummaryCountController>(SummaryCountController());
    Get.put<SetPasswordController>(SetPasswordController());
    Get.put<OtpVerificationController>(OtpVerificationController());
  }
}
