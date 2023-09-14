import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/email_verification_model.dart';
import 'package:task_manager_using_getx/data/models/network_response.dart';
import 'package:task_manager_using_getx/data/services/network_caller.dart';
import 'package:task_manager_using_getx/data/utills/urls.dart';
import 'package:task_manager_using_getx/widgets/screen_background.dart';

import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController _emailVerificationController = TextEditingController();
  bool _isEmailSent = false;
  EmailVerificationModel _emailVerificationModel = EmailVerificationModel();

  Future<void> emailSent(String emailAddress) async {
    // Get the email address from the TextFormField
    // Send the email to the server
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.reecoverVerifyEmail(_emailVerificationController.text));

    if (response.isSuccessfull) {
      // Navigate to OTP verification screen with the email parameter
      Get.to(() => OtpVerificationScreen(email: _emailVerificationController.text));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email Sending Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email Verification",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailVerificationController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Enter Your Email"),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 26,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: !_isEmailSent, // Show button if email not sent
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_isEmailSent) {
                          // Don't allow sending email again
                          return;
                        }
                        setState(() {
                          _isEmailSent = true; // Mark email as sent
                        });
                        emailSent(_emailVerificationController.text);
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
