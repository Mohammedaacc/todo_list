import 'package:expence_list/model/task.dart';
import 'package:expence_list/provider/task_provider.dart';
import 'package:expence_list/screens/dashboard_screen.dart';
import 'package:expence_list/widget/mybutton.dart';
import 'package:expence_list/widget/todoTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenList extends ConsumerStatefulWidget {
  const ScreenList({super.key});

  @override
  ConsumerState<ScreenList> createState() => _ScreenListState();
}

class _ScreenListState extends ConsumerState<ScreenList> {
  final textController = TextEditingController();
  TaskPriority _selectedpriority = TaskPriority.low;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskList = ref.watch(taskProvider);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Todo List'),
        backgroundColor: const Color.fromRGBO(62, 15, 141, 1),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
            icon: const Icon(Icons.dashboard),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedpriority = TaskPriority.low;
          });
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('add task'),
                content: Column(
                  children: [
                    TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter task title',
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'Priority :',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        DropdownButton<TaskPriority>(
                          value: _selectedpriority,
                          items: TaskPriority.values.map((priority) {
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority.name.toUpperCase(),
                                style: TextStyle(
                                  color: priority == TaskPriority.high
                                      ? Colors.red
                                      : priority == TaskPriority.medium
                                      ? Colors.orange
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _selectedpriority = value;
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton(
                        onPressed: () {
                          final title = textController.text.trim();
                          if (title.isNotEmpty) {
                            ref
                                .read(taskProvider.notifier)
                                .addTask(title, priority: _selectedpriority);
                          }
                          textController.clear();
                          Navigator.of(context).pop();
                        },
                        text: 'Save',
                      ),
                      const SizedBox(width: 8),
                      MyButton(
                        onPressed: () {
                          textController.clear();
                          Navigator.of(context).pop();
                        },
                        text: 'Cancel',
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromRGBO(149, 100, 221, 1),
      body: taskList.isEmpty
          ? const Center(child: Text('No tasks available!'))
          : Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  final currentTask = taskList[index];

                  return Dismissible(
                    key: ValueKey(currentTask.key ?? currentTask.id),
                    background: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red,
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    onDismissed: (direction) {
                      final removeTask = currentTask;

                      ref.read(taskProvider.notifier).deleteTask(removeTask);

                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Task deleted'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    child: TodoTaks(
                      title: currentTask.title,
                      isCompleted: currentTask.isCompleted,
                      priority: currentTask.priority,
                      onChanged: (value) {
                        ref.read(taskProvider.notifier).toggleTask(currentTask);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
