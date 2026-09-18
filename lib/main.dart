import 'package:expence_list/firebase_options.dart';
import 'package:expence_list/model/task.dart';
import 'package:expence_list/service/firebase_api.dart';

import 'package:expence_list/screens/screen_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('taskBox');

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: ScreenList()),
    );
  }
}
