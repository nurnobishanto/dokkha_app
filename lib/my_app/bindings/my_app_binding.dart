import 'package:get/get.dart';

import '../controllers/my_app_controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAppController>(
      () => MyAppController(),
    );
  }
}
