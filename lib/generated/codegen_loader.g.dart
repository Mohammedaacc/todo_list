// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ckb = {
  "app_title": "لیستی کارەکان",
  "dashboard_title": "داشبۆرد و پێداچوونەوە",
  "add_task": "زیادکردنی کار",
  "enter_task_title": "سەردێڕی کارەکە بنووسە",
  "priority": "ئاستی گرنگی :",
  "priority_low": "نزم",
  "priority_medium": "ناوەند",
  "priority_high": "بەرز",
  "save": "خەزن کردن",
  "cancel": "پاشگەزبوونەوە",
  "no_tasks": "هیچ کارێک بەردەست نییە!",
  "task_deleted": "کارەکە سڕدرایەوە",
  "task_completion": "ڕێژەی تەواوبوونی کارەکان",
  "tasks_completed_summary": "{} لە {} کار تەواوکراون",
  "total_tasks": "سەرجەمی کارەکان",
  "completed": "تەواوکراوە",
  "pending": "لە چاوەڕوانیدایە",
  "high_priority": "گرنگی بەرز"
};
static const Map<String,dynamic> _en = {
  "app_title": "Todo List",
  "dashboard_title": "Dashboard & overview",
  "add_task": "Add Task",
  "enter_task_title": "Enter task title",
  "priority": "Priority :",
  "priority_low": "LOW",
  "priority_medium": "MEDIUM",
  "priority_high": "HIGH",
  "save": "Save",
  "cancel": "Cancel",
  "no_tasks": "No tasks available!",
  "task_deleted": "Task deleted",
  "task_completion": "Task Completion",
  "tasks_completed_summary": "{} of {} tasks completed",
  "total_tasks": "Total Tasks",
  "completed": "Completed",
  "pending": "Pending",
  "high_priority": "High Priority"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ckb": _ckb, "en": _en};
}
