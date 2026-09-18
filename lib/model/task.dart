import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

enum TaskPriority { low, medium, high }

var uuid = const Uuid();

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  int priorityIndex;

  Task({
    required this.title,
    this.isCompleted = false,
    this.priorityIndex = 0,
    String? id,
  }) : id = id ?? uuid.v4();

  TaskPriority get priority => TaskPriority.values[priorityIndex];

  set priority(TaskPriority p) {
    priorityIndex = p.index;
  }
}
