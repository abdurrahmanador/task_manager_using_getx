// new_task_state_controller.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/network_response.dart';
import 'package:task_manager_using_getx/data/models/task_status_model.dart';
import 'package:task_manager_using_getx/data/services/network_caller.dart';
import 'package:task_manager_using_getx/data/utills/urls.dart';
import 'package:task_manager_using_getx/state_controller/summary_count_state_controller.dart';

import '../ui/screens/update_task_status_sheet.dart';


class NewTaskController extends GetxController {
  final RxBool getNewTaskInProgress = false.obs;
  final Rx<TaskListModel> taskListModel = TaskListModel().obs;

  final SummaryCountController _summaryCountController =
  Get.find<SummaryCountController>();

  @override
  void onInit() {
    super.onInit();
    // After widget binding
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _summaryCountController.getCountSummary();
      getNewTasks();
    });
  }

  Future<void> getNewTasks() async {
    getNewTaskInProgress.value = true;

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.newTasks);

    if (response.isSuccessfull) {
      taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      Get.snackbar('Failed', 'Failed to get new tasks');
    }

    getNewTaskInProgress.value = false;
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));

    if (response.isSuccessfull) {
      taskListModel.value.data!.removeWhere((element) => element.sId == taskId);
    } else {
      Get.snackbar('Failed', 'Failed to delete task');
    }
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          getNewTasks();
        });
      },
    );
  }

  void getCountSummary() {
    _summaryCountController.getCountSummary();
  }
}
