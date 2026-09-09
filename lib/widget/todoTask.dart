import 'package:flutter/material.dart';

class TodoTaks extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function(bool?) onChanged;
  const TodoTaks({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(228, 218, 114, 1),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
