import 'package:get/get.dart';

import '../controllers/course_checkout_controller.dart';

class CourseCheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseCheckoutController>(
      () => CourseCheckoutController(),
    );
  }
}
