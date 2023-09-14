import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utills/urls.dart';

class UpdateTaskStatusSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskStatusSheet(
      {Key? key, required this.task, required this.onUpdate})
      : super(key: key);

  @override
  State<UpdateTaskStatusSheet> createState() => _UpdateTaskStatusSheetState();
}

class _UpdateTaskStatusSheetState extends State<UpdateTaskStatusSheet> {
  final List<String> taskStatusList = ['New', 'Progress', 'Canceled', 'Completed'];
  late String _selectedTask;
  bool updateTaskInProgress = false;

  @override
  void initState() {
    _selectedTask = widget.task.status!.toLowerCase();
    super.initState();
  }

  Future<void> updateTask(String taskId, String newStatus) async {
    setState(() {
      updateTaskInProgress = true;
    });

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.updateTask(taskId, newStatus));

    setState(() {
      updateTaskInProgress = false;
    });

    if (response.isSuccessfull) {
      widget.onUpdate();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update task status has been failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Update Status'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskStatusList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      _selectedTask = taskStatusList[index];
                    });
                  },
                  title: Text(taskStatusList[index].toUpperCase()),
                  trailing: _selectedTask == taskStatusList[index]
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Visibility(
              visible: !updateTaskInProgress,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(
                onPressed: () {
                  updateTask(widget.task.sId!, _selectedTask);
                },
                child: const Text('Update'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
