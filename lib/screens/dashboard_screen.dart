import 'package:expence_list/model/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expence_list/provider/task_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskLists = ref.watch(taskProvider);

    final totalList = taskLists.length;
    final comliteTask = taskLists.where((t) => t.isCompleted).length;
    final penddingTask = totalList - comliteTask;
    final highPriority = taskLists
        .where(
          (high) => high.priority == TaskPriority.high && !high.isCompleted,
        )
        .length;

    final progressPer = totalList == 0 ? 0.0 : comliteTask / totalList;

    final percentageInt = (progressPer * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Dashboard & overview'),
        backgroundColor: const Color.fromRGBO(62, 15, 141, 1),
      ),
      backgroundColor: const Color.fromRGBO(149, 100, 221, 1),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Task Completion',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$percentageInt%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromRGBO(62, 15, 141, 1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progressPer,
                      backgroundColor: Colors.grey,
                      minHeight: 12,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "$comliteTask of $totalList tasks complited",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _dashboardCard(
                    'Total Tasks',
                    totalList.toString(),
                    Colors.blue,
                    Icons.list,
                  ),

                  _dashboardCard(
                    'Complited',
                    comliteTask.toString(),
                    Colors.green,
                    Icons.check_circle,
                  ),
                  _dashboardCard(
                    'Pendding',
                    penddingTask.toString(),
                    Colors.orange,
                    Icons.hourglass_empty,
                  ),
                  _dashboardCard(
                    'High Priority',
                    highPriority.toString(),
                    Colors.red,
                    Icons.warning,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _dashboardCard(String title, String cont, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 36, color: color),
        const SizedBox(height: 8),
        Text(
          cont,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}
//__________________________________________________________________________________________
// import 'package:expence_list/model/task.dart';
// import 'package:expence_list/provider/task_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DashboardScreen extends ConsumerWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // 🔥 خوێندنەوەی ڕاستەوخۆی لیستەکە لە Riverpod Providerـەوە
//     final tasks = ref.watch(taskProvider);

//     final totalTasks = tasks.length;
//     final completedTasks = tasks.where((task) => task.isCompleted).length;
//     final pendingTasks = totalTasks - completedTasks;
//     final highPriority = tasks
//         .where(
//           (task) => task.priority == TaskPriority.high && !task.isCompleted,
//         )
//         .length;

//     // هەژمارکردنی ڕێژەی سەدی بە شێوازێکی پارێزراو لە دابەشبوون بەسەر سفردا
//     final double progressPercentage = totalTasks == 0
//         ? 0.0
//         : completedTasks / totalTasks;
//     final int percentageInt = (progressPercentage * 100).toInt();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard & Report'),
//         backgroundColor: const Color.fromRGBO(62, 15, 141, 1),
//       ),
//       backgroundColor: const Color.fromRGBO(149, 100, 221, 1),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // بەشی پیشاندانی پڕۆگرێس بار و ڕێژەی سەدی
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Task Completion',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       Text(
//                         '$percentageInt%',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromRGBO(62, 15, 141, 1),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 12),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: LinearProgressIndicator(
//                       value: progressPercentage,
//                       minHeight: 12,
//                       backgroundColor: Colors.grey[200],
//                       valueColor: const AlwaysStoppedAnimation<Color>(
//                         Colors.green,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '$completedTasks of $totalTasks tasks completed',
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // کارتەکانی ئامار (GridView)
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//                 children: [
//                   _buildDashboardCard(
//                     'Total Tasks',
//                     totalTasks.toString(),
//                     Colors.blue,
//                     Icons.list,
//                   ),
//                   _buildDashboardCard(
//                     'Completed',
//                     completedTasks.toString(),
//                     Colors.green,
//                     Icons.check_circle,
//                   ),
//                   _buildDashboardCard(
//                     'Pending',
//                     pendingTasks.toString(),
//                     Colors.orange,
//                     Icons.hourglass_empty,
//                   ),
//                   _buildDashboardCard(
//                     'High Priority',
//                     highPriority.toString(),
//                     Colors.red,
//                     Icons.warning,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardCard(
//     String title,
//     String count,
//     Color color,
//     IconData icon,
//   ) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 36, color: color),
//           const SizedBox(height: 8),
//           Text(
//             count,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 13,
//               color: Colors.black54,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
