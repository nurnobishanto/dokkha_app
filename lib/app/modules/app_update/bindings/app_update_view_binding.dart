import 'package:get/get.dart';

import '../controllers/app_update_view_controller.dart';

class AppUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppUpdateController>(
      () => AppUpdateController(),
    );
  }
}
