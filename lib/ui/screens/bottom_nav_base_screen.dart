import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/ui/screens/cancel_task_screen.dart';
import 'package:task_manager_using_getx/ui/screens/completed_task_screen.dart';
import 'package:task_manager_using_getx/ui/screens/new_task_screen.dart';
import 'package:task_manager_using_getx/ui/screens/progress_task_screen.dart';

class BottomNavBarController extends GetxController {
  var selectedScreenIndex = 0.obs;

  void changeScreen(int index) {
    selectedScreenIndex.value = index;
  }
}
class BaseBottomNavBar extends StatefulWidget {

  @override
  State<BaseBottomNavBar> createState() => _BaseBottomNavBarState();
}

class _BaseBottomNavBarState extends State<BaseBottomNavBar> {
  final BottomNavBarController controller = Get.put(BottomNavBarController());

  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CancelTaskScreen(),
    CompletedTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => _screens[controller.selectedScreenIndex.value],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedScreenIndex.value,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        onTap: (int index) {
          controller.changeScreen(index);
          if(mounted){
            setState(() {
            });
        };
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit_outlined),
            label: "New",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            label: "In Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel_outlined),
            label: "Cancel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: "Completed",
          ),
        ],
      ),
    );
  }
}
