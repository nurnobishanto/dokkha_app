import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/mock_test/controllers/mock_test_controller.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/controllers/home_controller.dart';

import '../modules/navbar/controllers/navbar_controller.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NavbarController());
    Get.put(HomeController());
  }

}