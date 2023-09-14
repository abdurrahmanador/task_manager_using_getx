
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_using_getx/widgets/app_bar.dart';

import '../../state_controller/add_new_task_controller.dart';

class AddNewTaskScreen extends StatelessWidget {
  final AddNewTaskController controller = Get.put(AddNewTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Add new task',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: controller.titleTEController,
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: controller.descriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addNewTask();
                      },
                      child: Obx(
                            () => controller.addNewTaskInProgress.value
                            ? const CircularProgressIndicator()
                            : const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
