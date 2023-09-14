import 'package:flutter/material.dart';

import '../../../widgets/screen_background.dart';


class forgetPasswordScreen extends StatefulWidget {
  const forgetPasswordScreen({super.key});

  @override
  State<forgetPasswordScreen> createState() => _forgetPasswordScreenState();
}

class _forgetPasswordScreenState extends State<forgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email Verifiacation",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: Icon(Icons.arrow_forward)),
                ),
                Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Back to login page...",
                          style: TextStyle(color: Colors.grey)),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
