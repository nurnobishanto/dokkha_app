import 'package:get/get.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/controllers/home_controller.dart';

import '../../my_app/controllers/my_app_controller.dart';
import '../modules/navbar/controllers/navbar_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MyAppController(), permanent: true);
    Get.put(NavbarController(), permanent: true);
    Get.put(HomeController(), permanent: true);
  }
}
