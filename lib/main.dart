import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'package:todo/app/modules/home/bindings/tema_bindigs.dart';
import 'package:todo/app/utils/constantes.dart';
import 'app/routes/app_pages.dart';

Box box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.init(dir.path);
  Hive.registerAdapter<TodoModel>(TodoModelAdapter());
  box = await Hive.openBox<TodoModel>(Constantes.TODO_NOMBRE);
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
      initialBinding: TemaBindings(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
