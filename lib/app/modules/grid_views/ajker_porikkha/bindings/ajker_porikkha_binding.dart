import 'package:get/get.dart';

import '../controllers/ajker_porikkha_controller.dart';

class AjkerPorikkhaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AjkerPorikkhaController>(
      () => AjkerPorikkhaController(),
    );
  }
}
