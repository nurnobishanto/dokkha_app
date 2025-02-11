import 'package:get/get.dart';

import '../controllers/ajker_bissho_controller.dart';

class AjkerBisshoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AjkerBisshoController>(
      () => AjkerBisshoController(),
    );
  }
}
