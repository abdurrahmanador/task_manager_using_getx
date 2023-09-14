import 'dart:convert';
import 'dart:developer';
import 'package:task_manager_using_getx/app.dart';
import 'package:task_manager_using_getx/ui/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/auth_utility.dart';
import '../models/network_response.dart';
class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),headers: {
        'Content-Type': 'application/json',
        'token': AuthUtility.userInfo.token.toString()
      }, );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));

      }else if(response.statusCode == 401){
        gotoLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body,{bool isLogin=false}) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtility.userInfo.token.toString()
        },
        body: jsonEncode(body),
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      }else if(response.statusCode ==401){
        if(isLogin=true) {
          gotoLogin();
        }
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  Future<void> gotoLogin() async {
    await AuthUtility.clearUserInfo();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) =>  login_screen()),
            (route) => false);
  }
}

//Navigator.pushAndRemoveUntil(TaskManagerApp.globalKey.currentState!.context,MaterialPageRoute(builder: (context)=>login