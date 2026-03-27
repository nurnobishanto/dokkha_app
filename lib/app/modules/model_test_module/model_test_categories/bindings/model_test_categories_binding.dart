import 'package:get/get.dart';

import '../controllers/model_test_categories_controller.dart';

class ModelTestCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModelTestCategoriesController>(
      () => ModelTestCategoriesController(),
    );
  }
}
