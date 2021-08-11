import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:todo/app/data/model/todo_model.dart';
import 'package:todo/app/modules/home/widget/build_body.dart';
import 'package:todo/app/modules/home/widget/form_todo.dart';
import 'package:todo/app/utils/responsive.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
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
              title: Text('TODO'),
              centerTitle: true,
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
                          child: Text(
                            'No Hay PENDIENTES',
                            style: TextStyle(
                                fontSize: responsive.ip(2),
                                fontWeight: FontWeight.bold),
                          ),
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
