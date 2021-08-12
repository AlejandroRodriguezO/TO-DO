class CatsModel {
  final String catqfact;

  CatsModel({this.catqfact});

  factory CatsModel.fromJson(Map<String, dynamic> jsonData) {
    return CatsModel(catqfact: jsonData['fact']);
  }
}
