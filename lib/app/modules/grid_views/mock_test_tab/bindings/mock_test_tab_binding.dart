import 'package:get/get.dart';

import '../controllers/mock_test_tab_controller.dart';

class MockTestTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MockTestTabController>(
      () => MockTestTabController(),
    );
  }
}
