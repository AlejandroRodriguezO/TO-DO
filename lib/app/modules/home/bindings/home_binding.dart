import 'package:get/get.dart';
import 'package:todo/app/data/repositories/api_repository.dart';
import 'package:todo/app/data/repositories_implementation/api_implementation.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(
      () => ApiImplemetation(),
    );
  }
}
