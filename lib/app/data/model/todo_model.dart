import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart' show required;
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String tarea;

  @HiveField(2)
  bool listo;

  @HiveField(3)
  Color color;

  TodoModel({
    @required this.tarea,
    @required this.color,
  })  : this.id = Uuid().v1(),
        this.listo = false;
}
