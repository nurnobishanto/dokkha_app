import 'package:get/get.dart';

import '../controllers/jobs_update_controller.dart';

class JobsUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobsUpdateController>(
      () => JobsUpdateController(),
    );
  }
}
