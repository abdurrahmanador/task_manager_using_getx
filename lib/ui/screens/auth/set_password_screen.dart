
import 'package:flutter/material.dart';

import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/utills/urls.dart';
import '../../../widgets/screen_background.dart';
import 'login_screen.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const SetPasswordScreen({Key? key, required this.email, required this.otp});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController = TextEditingController();

  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _setPassword = false;

  Future<void> setPassword() async {
    setState(() {
      _setPassword = true;
    });

    Map<String, dynamic> ResponseBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text,
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.recoverResetPass, ResponseBody);

    setState(() {
      _setPassword = false;
    });

    if (response.isSuccessfull) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>login_screen()), (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password Changed Successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password Changing Failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Set Password",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please Provide a password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordTEController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Confirm Password"),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please Provide a password";
                      } else if (value != _passwordTEController.text) {
                        return "Passwords do not match!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: !_setPassword,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if(!_formKey.currentState!.validate()){
                            return;
                          }
                          setPassword();
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
      ),
    );
  }
}