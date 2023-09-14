import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/data/models/task_status_model.dart';
import 'package:task_manager_using_getx/widgets/task_list_tiles.dart';
import 'package:task_manager_using_getx/widgets/app_bar.dart';

import '../../state_controller/cancel_taask_controller.dart';

class CancelTaskScreen extends StatelessWidget {
  final CancelTaskController controller = Get.put(CancelTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            appBar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.getNewTasks();
                },
                child: Obx(
                      () {
                    return controller.getCancelledTasksInProgress.value
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ListView.separated(
                        itemCount:
                        controller.taskListModel.value.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final task =
                          controller.taskListModel.value.data![index];
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
