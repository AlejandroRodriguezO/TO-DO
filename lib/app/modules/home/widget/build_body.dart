import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app/modules/home/widget/form_todo.dart';
import 'package:todo/app/utils/responsive.dart';
import 'package:intl/intl.dart';

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
                      child: TweenAnimationBuilder(
                    tween: Tween(begin: 0, end: _.percent),
                    duration: const Duration(seconds: 1),
                    builder: (context, value, child) {
                      return Container(
                        height: 2.0,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey[400],
                          value: (value.clamp(0, 100) / 100),
                        ),
                      );
                    },
                  )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "${_.percent.floor().clamp(0, 100)}%",
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                  ),
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
                child:ListView.builder(
//                      reverse: true,
                  shrinkWrap: true,
              itemCount: _.todos.length,
              itemBuilder: (context, index) {
                String valueString = _.todos[index].color
                    .split('(0x')[1]
                    .split(')')[0]; // kind of hacky..
                int value = int.parse(valueString, radix: 16);
                Color otherColor = new Color(value);

                final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');

                final String fecha = formatter.format(_.todos[index].date);

                return CustomList(
                  otherColor: otherColor,
                  responsive: responsive,
                  fecha: fecha,
                  index: index,
                  homeController: _,
                );
              },
            )),
          ],
        );
      },
    );
  }
}

class CustomList extends StatelessWidget {
  const CustomList({
    @required this.otherColor,
    @required this.responsive,
    @required this.fecha,
    @required this.index,
    @required this.homeController,
  });

  final Color otherColor;
  final Responsive responsive;
  final String fecha;
  final int index;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: otherColor.withOpacity(0.2),
      margin: EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          Get.dialog(
            TodoForm(
              type: "actualizar",
              todo: homeController.todos[index],
              title: 'Actualizar',
              dato: homeController.datosList,
            ),
          );
        },
        leading: IconButton(
          icon: homeController.todos[index].listo
              ? Icon(
                  Icons.check_circle_outline,
                  color: otherColor,
                )
              : Icon(Icons.radio_button_unchecked),
          onPressed: () =>
              homeController.cambiarEstado(homeController.todos[index]),
        ),
        title: Text(
          homeController.todos[index].tarea,
          style: TextStyle(
            fontSize: responsive.ip(2),
            color: otherColor,
            decoration: homeController.todos[index].listo
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          fecha,
          style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
              fontSize: responsive.ip(1.5),
              fontStyle: FontStyle.italic),
        ),
        trailing: IconButton(
          onPressed: () => Get.dialog(AlertDialog(
            title: Text(
              'Desea Eliminarlo?',
              style: GoogleFonts.poppins().copyWith(
                fontSize: responsive.ip(2.5),
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  homeController.eliminar(homeController.todos[index]);
                  Get.back();
                },
                child: Text('Aceptar'),
              ),
              TextButton(onPressed: () => Get.back(), child: Text('Cancelar'))
            ],
          )),
          icon: Icon(
            Icons.delete_outline,
            color: otherColor,
          ),
        ),
      ),
    );
  }
}
