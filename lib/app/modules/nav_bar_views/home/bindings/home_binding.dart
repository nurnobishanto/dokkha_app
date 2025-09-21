import 'package:get/get.dart';
import 'package:lokkha/app/modules/courses/controllers/courses_controller.dart';
import 'package:lokkha/app/modules/exam_category/controllers/exam_category_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
