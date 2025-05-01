import 'package:get/get.dart';

import '../controllers/subject_section_controller.dart';

class SubjectSectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubjectSectionController>(
      () => SubjectSectionController(),
    );
  }
}
