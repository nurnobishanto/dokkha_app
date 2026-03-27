import 'package:get/get.dart';
import '../../mock_test_tab/mock_test/controllers/mock_test_controller.dart';

class MockTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MockTestController>(
      () => MockTestController(),
    );
  }
}
