import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:todo/app/data/model/cats.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app/utils/responsive.dart';

class TodoForm extends StatefulWidget {
  final String type, title;
  final TodoModel todo;
  final List<Datum> dato;

  const TodoForm({
    Key key,
    @required this.type,
    this.todo,
    @required this.title,
    this.dato,
  }) : super(key: key);
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  String tarea = '';
  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    final responsive = Responsive.of(context);
    final todoController = Get.find<HomeController>();
    return AlertDialog(
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: responsive.ip(2.5),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            style: TextStyle(
              fontSize: responsive.ip(2),
            ),
            initialValue: widget.todo != null ? widget.todo.tarea : '',
            onSaved: (value) => tarea = value,
            decoration: InputDecoration(
              hintText: "Agregar Tarea",
            ),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            ...List.generate(
              widget.dato.length,
              (index) => TextButton.icon(
                onPressed: () {
                  tarea = widget.dato[index].fact;
                  if (widget.type == "agregar") {
                    if (tarea.trim().length < 1) {
                      Get.snackbar('Error', 'Texto vacio');
                      return;
                    }
                    todoController.agregar(TodoModel(
                      tarea: tarea,
                      color: color,
                    ));
                  } else {
                    if (tarea.trim().length < 1) {
                      Get.snackbar(
                        'Error',
                        'Texto vacio',
                        duration: Duration(seconds: 1),
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.grey,
                        colorText: Colors.black,
                      );
                      return;
                    }
                    todoController.actulizar(widget.todo, tarea);
                  }
                  Get.back();
                },
                icon: Icon(FontAwesomeIcons.cat),
                label: Text(
                  widget.type == 'agregar'
                      ? 'Frase aleatoria'
                      : 'Cambiar Frase',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _formKey.currentState.save();
                if (widget.type == "agregar") {
                  if (tarea.trim().length < 1) {
                    Get.snackbar('Error', 'Texto vacio');
                    return;
                  }
                  todoController.agregar(TodoModel(tarea: tarea, color: color));
                } else {
                  if (tarea.trim().length < 1) {
                    Get.snackbar(
                      'Error',
                      'Texto vacio',
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.grey,
                      colorText: Colors.black,
                    );
                    return;
                  }
                  todoController.actulizar(
                    widget.todo,
                    tarea,
                  );
                }
                Get.back();
              },
              child: Text(
                widget.todo != null ? "Actualizar" : "agregar",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
