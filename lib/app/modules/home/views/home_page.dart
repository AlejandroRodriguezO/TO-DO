import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'package:todo/app/modules/home/controllers/theme_controller.dart';
import 'package:todo/app/modules/home/widget/build_body.dart';
import 'package:todo/app/modules/home/widget/form_todo.dart';
import 'package:todo/app/utils/responsive.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  final darkMode = Get.put(TemaController());

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        _.percent = (_.isDoneCount / _.todos.length) * 100;
        _.frases();
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(_.percent == 100.0 ? 'Tareas Completas' : 'TODO'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Get.isDarkMode
                      ? Icons.lightbulb_outline
                      : FontAwesomeIcons.moon),
                  onPressed: () => Get.isDarkMode
                      ? darkMode.temaClaro()
                      : darkMode.temaOscuro(),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _alertInput(
                null,
              ),
              child: Icon(Icons.add_outlined),
            ),
            body: _.todos.length != 0
                ? BuildBody()
                : Container(
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Center(
                          child: SvgPicture.asset('assets/noData.svg'),
                        ),
                        Center(
                          child: Text('No Hay PENDIENTES',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: responsive.ip(2),
                              )),
                        ),
                      ],
                    ),
                  ));
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
              title: 'Algo Nuevo?',
            );
          },
        ),
        transitionCurve: Curves.elasticIn);
  }
}
