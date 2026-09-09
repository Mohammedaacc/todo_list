import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

var uuid = const Uuid();

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  bool isCompleted;

  Task({required this.title, this.isCompleted = false, String? id})
    : id = id ?? uuid.v4();
}
