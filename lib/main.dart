import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'app/routes/app_pages.dart';

Box box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter<TodoModel>(TodoModelAdapter());
  box = await Hive.openBox<TodoModel>('todos');
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TO-DO",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
