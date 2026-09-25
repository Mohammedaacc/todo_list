import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:expence_list/model/task.dart';

class TaskNotifier extends AsyncNotifier<List<Task>> {
  @override
  Future<List<Task>> build() async {
    final box = Hive.box<Task>('taskBox');
    return box.values.toList();
  }

  Future<void> addTask(
    String title, {
    TaskPriority priority = TaskPriority.low,
  }) async {
    state = const AsyncValue.loading();
    try {
      final box = Hive.box<Task>('taskBox');
      final newTask = Task(title: title, priorityIndex: priority.index);
      await box.add(newTask);
      state = AsyncValue.data(box.values.toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleTask(Task task) async {
    if (task.isInBox) {
      try {
        task.isCompleted = !task.isCompleted;
        await task.save();
        final box = Hive.box<Task>('taskBox');
        state = AsyncValue.data(box.values.toList());
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<void> deleteTask(Task task) async {
    if (task.isInBox) {
      try {
        task.delete();
        final box = Hive.box<Task>('taskBox');
        state = AsyncValue.data(box.values.toList());
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    }
  }
}

final taskProvider = AsyncNotifierProvider<TaskNotifier, List<Task>>(() {
  return TaskNotifier();
});
