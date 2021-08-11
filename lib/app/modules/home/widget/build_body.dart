import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app/modules/home/widget/form_todo.dart';
import 'package:todo/app/utils/responsive.dart';

class BuildBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Column(
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
                  left: 40.0, bottom: 8.0, top: 8.0, right: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_.todos.length.clamp(0, 100)} Tareas",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    "${_.isDoneCount.clamp(0, 100)} Completas",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _.todos.length,
                itemBuilder: (context, index) {
                  print(_.todos[index].color);
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
                        fontSize: responsive.ip(2),
                        color: _.todos[index].color,
                        decoration: _.todos[index].listo
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => Get.dialog(AlertDialog(
                        title: Text('Desea Eliminarlo?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _.eliminar(_.todos[index]);
                              Get.back();
                            },
                            child: Text('Aceptar'),
                          ),
                          TextButton(
                              onPressed: () => Get.back(),
                              child: Text('Cancelar'))
                        ],
                      )),
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
