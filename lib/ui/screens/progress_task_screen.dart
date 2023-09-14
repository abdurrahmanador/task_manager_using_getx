import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/network_response.dart';
import 'package:task_manager_using_getx/data/models/task_status_model.dart';
import 'package:task_manager_using_getx/data/services/network_caller.dart';
import 'package:task_manager_using_getx/data/utills/urls.dart';
import 'package:task_manager_using_getx/ui/screens/update_task_status_sheet.dart';
import 'package:task_manager_using_getx/widgets/task_list_tiles.dart';
import 'package:task_manager_using_getx/widgets/app_bar.dart';

class ProgressTaskController extends GetxController {
  var getProgressTasksInProgress = false.obs;
  var taskListModel = TaskListModel().obs;

  @override
  void onInit() {
    super.onInit();
    getInProgressTasks(); // Automatically fetch data when the controller is initialized.
  }

  Future<void> getInProgressTasks() async {
    getProgressTasksInProgress.value = true;

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.inProgressTasks);

    if (response.isSuccessfull) {
      taskListModel.value = TaskListModel.fromJson(response.body!);
    } else {
      if (Get.context == null) {
        return;
      }

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('In progress tasks get failed')),
      );
    }

    getProgressTasksInProgress.value = false;
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));

    if (response.isSuccessfull) {
      taskListModel.update((val) {
        val!.data!.removeWhere((element) => element.sId == taskId);
      });
    } else {
      if (Get.context == null) {
        return;
      }

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text('Deletion of task has been failed')),
      );
    }
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    if (Get.context == null) {
      return;
    }

    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: getInProgressTasks);
      },
    );
  }
}

class ProgressTaskScreen extends StatelessWidget {
  final ProgressTaskController controller = Get.put(ProgressTaskController());

  Future<void> _refresh() async {
    await controller.getInProgressTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: Obx(
                      () {
                    return controller.getProgressTasksInProgress.value
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ListView.separated(
                        itemCount:
                        controller.taskListModel.value.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final task = controller.taskListModel.value.data![index];
                          return TaskListTiles(
                            data: task,
                            onDeleteTap: () {
                              controller.deleteTask(task.sId!);
                            },
                            onEditTap: () {
                              controller.showStatusUpdateBottomSheet(task);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
