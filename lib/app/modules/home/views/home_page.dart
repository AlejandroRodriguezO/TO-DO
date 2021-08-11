import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo/app/data/model/cats.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'package:todo/app/modules/home/widget/form_todo.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        _.frases();
        _.percent = (_.isDoneCount / _.todos.length) * 100;
        return Scaffold(
          appBar: AppBar(
            title: Text('Homepage'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _alertInput(
              null,
            ),
            child: Icon(Icons.add_outlined),
          ),
          body: _.todos.length != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0, left: 40.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 2.0,
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey[400],
                                value: (_.percent.clamp(0, 100) / 100),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text("${_.percent.floor().clamp(0, 100)}%"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40.0, bottom: 8.0, top: 8.0, right: 8.0),
                      child: Text(
                        "${_.todos.length.clamp(0, 100)} Tareas",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _.todos.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Get.dialog(
                                TodoForm(
                                  type: "actualizar",
                                  todo: _.todos[index],
                                  title: 'Actualizar',
                                  dato: _.date,
                                ),
                              );
                            },
                            leading: IconButton(
                              icon: _.todos[index].listo
                                  ? Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.blue,
                                    )
                                  : Icon(Icons.radio_button_unchecked),
                              onPressed: () => _.cambiarEstado(_.todos[index]),
                            ),
                            title: Text(
                              _.todos[index].tarea,
                              style: TextStyle(
                                decoration: _.todos[index].listo
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                _.eliminar(_.todos[index]);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Container(
                  child: Center(
                    child: Text('nada'),
                  ),
                ),
        );
      },
    );
  }

  Future _alertInput(TodoModel todo) async {
    return Get.dialog(
      GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return TodoForm(
            dato: _.date,
            type: 'agregar',
            title: 'Que tienes planeado?',
          );
        },
      ),
    );
  }
}

class Prueba extends StatelessWidget {
  const Prueba({Key key, this.dato}) : super(key: key);
  final List<Datum> dato;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.red,
      child: ListView.builder(
        itemCount: dato.length,
        itemBuilder: (context, index) {
          final prueba = dato[index];

          return Text(prueba.fact);
        },
      ),
    );
  }
}
