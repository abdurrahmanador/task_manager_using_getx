import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/network_response.dart';
import 'package:task_manager_using_getx/data/models/task_status_model.dart';
import 'package:task_manager_using_getx/data/services/network_caller.dart';
import 'package:task_manager_using_getx/data/utills/urls.dart';
import 'package:task_manager_using_getx/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_using_getx/widgets/task_list_tiles.dart';

class CompletedTaskController extends GetxController {
  var getCompletedTasksInProgress = false.obs;
  var taskListModel = TaskListModel().obs;

  @override
  void onInit() {
    super.onInit();
    getCompletedTasks(); // Automatically fetch data when the controller is initialized.
  }

  Future<void> getCompletedTasks() async {
    getCompletedTasksInProgress.value = true;

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.completedTasks);

    if (response.isSuccessfull) {
      taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      return null;
    }

    getCompletedTasksInProgress.value = false;
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.deleteTask(taskId));

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
    await getCompletedTasks(); // Refresh the task list.
  }
}
