import 'dart:math';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/app/data/model/cats.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;
  Box<TodoModel> todoBox;
  int isDoneCount = 0;

  double percent = 0.0;
  HomeController() {
    todoBox = Hive.box<TodoModel>('todos');
    _todos = [];
    isDoneCount = todoBox.values.where((f) => f.listo).length;

    for (int i = 0; i < todoBox.values.length; i++) {
      _todos.add(todoBox.getAt(i));
      update();
    }
    update();
  }

  agregar(TodoModel todo) async {
    _todos.add(todo);
    await todoBox.add(todo);

    update();
  }

  eliminar(TodoModel todo) {
    int index = _todos.indexOf(todo);
    todoBox.deleteAt(index);
    _todos.removeWhere((e) => e.id == todo.id);
    isDoneCount = todoBox.values.where((f) => f.listo).length;
    update();
  }

  cambiarEstado(TodoModel todo) {
    int index = _todos.indexOf(todo);
    _todos[index].listo = !_todos[index].listo;
    todoBox.putAt(index, _todos[index]);
    isDoneCount = todoBox.values.where((f) => f.listo).length;
    update();
  }

  actulizar(TodoModel oldTodo, String newTarea) {
    int index = _todos.indexOf(oldTodo);
    _todos[index].tarea = newTarea;
    todoBox.putAt(index, _todos[index]);
    update();
  }

  List<Datum> date = [];

  static var client = http.Client();
  var rng = new Random();

  frases() async {
    for (var i = 0; i < 1; i++) {
      final uri = Uri.parse(
          'https://catfact.ninja/facts?limit=1&max_length=100&page=${rng.nextInt(50)}');
      final response =
          await client.get(uri, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        final result = catsFromMap(response.body);
        date = result.data;
        update();
      }
    }
  }
}
