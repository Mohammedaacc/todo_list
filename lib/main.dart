import 'package:easy_localization/easy_localization.dart';
import 'package:expence_list/firebase_options.dart';
import 'package:expence_list/generated/codegen_loader.g.dart';
import 'package:expence_list/model/task.dart';
import 'package:expence_list/screens/screen_list.dart';
import 'package:expence_list/service/firebase_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('ckb')],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        ...context.localizationDelegates,

        const CkbMaterialLocalizationsDelegate(),
        const CkbCupertinoLocalizationsDelegate(),
        const CkbWidgetsLocalizationsDelegate(),
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SafeArea(child: ScreenList()),
    );
  }
}

class CkbMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CkbMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ckb';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return await GlobalMaterialLocalizations.delegate.load(const Locale('ar'));
  }

  @override
  bool shouldReload(CkbMaterialLocalizationsDelegate old) => false;
}

class CkbCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const CkbCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ckb';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return await GlobalCupertinoLocalizations.delegate.load(const Locale('ar'));
  }

  @override
  bool shouldReload(CkbCupertinoLocalizationsDelegate old) => false;
}

class CkbWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const CkbWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ckb';

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    return await GlobalWidgetsLocalizations.delegate.load(const Locale('ar'));
  }

  @override
  bool shouldReload(CkbWidgetsLocalizationsDelegate old) => false;
}
