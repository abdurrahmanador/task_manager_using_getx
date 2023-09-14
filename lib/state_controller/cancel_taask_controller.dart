import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/network_response.dart';
import 'package:task_manager_using_getx/data/services/network_caller.dart';
import 'package:task_manager_using_getx/data/utills/urls.dart';
import 'package:task_manager_using_getx/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_using_getx/widgets/task_list_tiles.dart';

import '../data/models/task_status_model.dart';

class CancelTaskController extends GetxController {
  var getCancelledTasksInProgress = false.obs;
  var taskListModel = TaskListModel().obs;

  @override
  void onInit() {
    super.onInit();
    getCancelledTasks(); // Automatically fetch data when the controller is initialized.
  }

  Future<void> getCancelledTasks() async {
    getCancelledTasksInProgress.value = true;

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.cancelledTasks);

    if (response.isSuccessfull) {
      taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      print('Failed to fetch cancelled tasks');
    return null;
    }

    getCancelledTasksInProgress.value = false;
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));

    if (response.isSuccessfull) {
      taskListModel.update((val) {
        val!.data!.removeWhere((element) => element.sId == taskId);
      });
    } else {
      return;
    }
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: getNewTasks);
      },
    );
  }

  Future<void> getNewTasks() async {
    await getCancelledTasks(); // Refresh the task list.
  }
}
