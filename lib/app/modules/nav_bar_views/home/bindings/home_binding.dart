import 'package:get/get.dart';
import 'package:lokkha/app/modules/contest/controller/latest_contest_controller.dart';
import 'package:lokkha/app/modules/exam_category/controllers/exam_category_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Required controllers
    Get.lazyPut<LatestContestController>(() => LatestContestController());
    Get.lazyPut<ExamCategoryController>(() => ExamCategoryController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
