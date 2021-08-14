import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:todo/app/data/model/cats.dart';
import 'package:todo/app/data/repositories/api_repository.dart';
import 'package:http/http.dart' as http;

class ApiImplemetation implements ApiRepository {
  @override
  Future<List<CatsModel>> fetchDatos(String url) async {
    final client = http.Client();

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    var rng = new Random();
    for (var i = 0; i < 1; i++) {
      final uri = Uri.parse(
          '$url/facts?limit=1&max_length=100&page=${rng.nextInt(50)}');

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List facts = json.decode(response.body)['data'];

        List<CatsModel> cats = [];
        for (int i = 0; i < facts.length; i++) {
          cats.add(CatsModel(catqfact: facts[i]['fact']));
        }
        return cats;
      } else {
        Get.snackbar('Error API', 'Error en la api');
        return null;
      }
    }
  }
}
