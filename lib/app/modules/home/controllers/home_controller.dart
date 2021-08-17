import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/app/data/model/cats.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'package:todo/app/data/repositories_implementation/api_implementation.dart';
import 'package:todo/app/utils/constantes.dart';

class HomeController extends GetxController {

  List<CatsModel> datosList;

  GlobalKey<AnimatedListState> aList = GlobalKey<AnimatedListState>();

  final url = 'https://catfact.ninja/';

  void fetchDatos() async {
    final repository = Get.find<ApiImplemetation>();

    final datos = await repository.fetchDatos(url);

    if (datos != null) {
      datosList = datos;
    }
  }

  List<TodoModel> _todos = [];
  List<TodoModel> get todos => _todos;
  Box<TodoModel> todoBox;
  int isDoneCount = 0;

  double percent = 0.0;
  HomeController() {
    fetchDatos();
    todoBox = Hive.box<TodoModel>(Constantes.TODO_NOMBRE);
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
    Get.back();
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
}
