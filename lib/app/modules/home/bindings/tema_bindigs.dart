import 'package:get/get.dart';
import 'package:todo/app/modules/home/controllers/theme_controller.dart';

class TemaBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemaController>(
      () => TemaController(),
    );
  }
}
