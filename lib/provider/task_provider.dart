import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:expence_list/model/task.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadTasks();
  }

  late Box<Task> _taskBox;

  void _loadTasks() {
    _taskBox = Hive.box<Task>('taskBox');
    state = _taskBox.values.toList();
  }

  void addTask(String title, {TaskPriority priority = TaskPriority.low}) {
    final newTask = Task(title: title, priorityIndex: priority.index);
    _taskBox.add(newTask);
    state = _taskBox.values.toList();
  }

  void toggleTask(Task task) {
    if (task.isInBox) {
      task.isCompleted = !task.isCompleted;
      task.save();
      state = _taskBox.values.toList();
    }
  }

  void deleteTask(Task task) {
    if (task.isInBox) {
      task.delete();
      state = _taskBox.values.toList();
    }
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
