import 'package:expence_list/model/task.dart';
import 'package:expence_list/provider/task_provider.dart';
import 'package:expence_list/screens/dashboard_screen.dart';
import 'package:expence_list/widget/mybutton.dart';
import 'package:expence_list/widget/todoTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expence_list/generated/locale_keys.g.dart';

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
        title: Text(LocaleKeys.app_title.tr()),
        backgroundColor: const Color.fromRGBO(62, 15, 141, 1),
        actions: [
          IconButton(
            onPressed: () {
              if (context.locale == Locale('en')) {
                context.setLocale(Locale('ckb'));
              } else {
                context.setLocale(Locale("en"));
              }
            },
            icon: const Icon(Icons.language),
          ),
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
                title: Text(LocaleKeys.add_task.tr()),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.enter_task_title.tr(),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          LocaleKeys.priority.tr(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        DropdownButton<TaskPriority>(
                          value: _selectedpriority,
                          items: TaskPriority.values.map((priority) {
                            final String textPriority =
                                priority == TaskPriority.high
                                ? LocaleKeys.priority_high.tr()
                                : priority == TaskPriority.medium
                                ? LocaleKeys.priority_medium.tr()
                                : LocaleKeys.priority_low.tr();
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                textPriority,
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
                        text: LocaleKeys.save.tr(),
                      ),
                      const SizedBox(width: 8),
                      MyButton(
                        onPressed: () {
                          textController.clear();
                          Navigator.of(context).pop();
                        },
                        text: LocaleKeys.cancel.tr(),
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
      body: taskList.when(
        data: (task) {
          if (task.isEmpty) {
            return Center(child: Text(LocaleKeys.no_tasks.tr()));
          }
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: task.length,
              itemBuilder: (context, index) {
                final currentTask = task[index];

                return Dismissible(
                  key: ValueKey(currentTask.key),
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
                        content: Text(LocaleKeys.task_deleted.tr()),
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
          );
        },
        error: (e, st) => Center(child: Text('$e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
