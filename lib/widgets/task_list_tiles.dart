import 'package:flutter/material.dart';

import '../data/models/task_status_model.dart';

class TaskListTiles extends StatelessWidget {
  final VoidCallback onDeleteTap, onEditTap;

  const TaskListTiles(
      {super.key,
      required this.data,
      required this.onDeleteTap,
      required this.onEditTap});

  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          data.title ?? 'Unknown',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.description ?? ''),
            Text(data.createdDate ?? ''),
            Row(
              children: [
                Chip(
                  label: Text(data.status ?? "New"),
                  backgroundColor: Colors.tealAccent,
                ),
                Spacer(),
                IconButton(
                  onPressed: onDeleteTap,
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: onEditTap,
                  icon: Icon(Icons.edit),
                  color: Colors.redAccent,
                ),
              ],
            )
          ],
        ));
  }
}
