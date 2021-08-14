import 'package:todo/app/data/model/cats.dart';

abstract class ApiRepository{

   Future<List<CatsModel>> fetchDatos(String url);

}