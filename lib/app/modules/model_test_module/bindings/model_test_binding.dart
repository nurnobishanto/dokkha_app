import 'package:get/get.dart';

import '../controllers/model_test_controller.dart';

class ModelTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModelTestController>(
      () => ModelTestController(),
    );
  }
}
