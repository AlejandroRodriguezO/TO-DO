import 'package:get/get.dart';

import 'package:todo/app/modules/home/bindings/home_binding.dart';
import 'package:todo/app/modules/home/views/home_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
