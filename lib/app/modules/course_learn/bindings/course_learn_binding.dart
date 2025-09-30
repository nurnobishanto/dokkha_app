import 'package:get/get.dart';

import '../controllers/course_learn_controller.dart';

class CourseLearnBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments;
    Get.put(CourseLearnController(
      id: args['id'],
      itemID: args['item_id'],
    ));
  }
}
