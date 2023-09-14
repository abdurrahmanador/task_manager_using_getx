import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utills/urls.dart';

class UpdateTaskSheet extends StatelessWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  final RxBool _updateTaskInProgress = false.obs;

  UpdateTaskSheet({
    Key? key,
    required this.task,
    required this.onUpdate,
  }) {
    _titleTEController.text = task.title ?? '';
    _descriptionTEController.text = task.description ?? '';
  }

  void updateTask() async {
    _updateTaskInProgress.value = true;

    final Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.createTask, requestBody);

    _updateTaskInProgress.value = false;

    if (response.isSuccessfull) {
      _titleTEController.clear();
      _descriptionTEController.clear();
      Get.snackbar(
        'Success',
        'Task updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      onUpdate();
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        'Task update failed!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Update task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _descriptionTEController,
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
                child: Obx(
                      () => Visibility(
                    visible: !_updateTaskInProgress.value,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        updateTask();
                      },
                      child: const Text('Update'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
