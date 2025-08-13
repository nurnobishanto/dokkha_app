import 'package:get/get.dart';

import '../controllers/model_test_details_controller.dart';

class ModelTestDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModelTestDetailsController>(
      () => ModelTestDetailsController(),
    );
  }
}
