import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:task_manager_using_getx/data/models/auth_utility.dart';
import 'package:task_manager_using_getx/ui/screens/UpdateProfileScreen.dart';
import 'package:task_manager_using_getx/ui/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class appBar extends StatefulWidget {
  final bool? isUpdateScreen;

  const appBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<appBar> createState() => _appBarState();
}

class _appBarState extends State<appBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  UpdateProfileScreen()));
          }
        },
        child: Row(
          children: [
            Visibility(
              visible: ((widget.isUpdateScreen ?? false) == false),
              child: Row(
                children: [
                  CachedNetworkImage(
                    placeholder: (_, __) => const Icon(Icons.account_circle_outlined),
                    imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                    errorWidget: (_, __, ___) => const Icon(Icons.account_circle_outlined),),
                  SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthUtility.userInfo.data?.firstName ?? ''}${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>  login_screen()),
                  (route) => false);
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
