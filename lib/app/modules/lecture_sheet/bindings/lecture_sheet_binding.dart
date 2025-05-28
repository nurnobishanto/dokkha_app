import 'package:get/get.dart';

import '../controllers/lecture_sheet_controller.dart';

class LectureSheetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LectureSheetController>(
      () => LectureSheetController(),
    );
  }
}
