import 'package:expence_list/model/task.dart';
import 'package:flutter/material.dart';

class TodoTaks extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final TaskPriority priority;
  final Function(bool?) onChanged;
  const TodoTaks({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.priority,
    required this.onChanged,
  });

  Color _getPriorityColor() {
    switch (priority) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.orangeAccent;
      case TaskPriority.low:
        return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: _getPriorityColor()),
      ),
      margin: EdgeInsets.all(16),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            Checkbox(value: isCompleted, onChanged: onChanged),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isCompleted ? Colors.grey : Colors.black87,
              ),
            ),
            SizedBox(width: 32),
            Text(
              priority.name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getPriorityColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
