import 'package:get/get.dart';
import 'package:lokkha/app/modules/lecture_sheet/controllers/sheet_details_controller.dart';


class SheetDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SheetDetailsController>(
      () => SheetDetailsController(),
    );
  }
}
