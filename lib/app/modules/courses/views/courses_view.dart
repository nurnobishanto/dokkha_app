import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lokkha/app/modules/model_test_module/components/model_test_categories_card.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../../config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';
import '../../../services/api_call_status.dart';
import '../controllers/courses_controller.dart';
import '../widgets/custom_course_card.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CoursesController());
    print("CoursesView called ");
    return Scaffold(
      appBar: AppBar(
        title: const Text('পরীক্ষার ক্যাটাগরি'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.apiCallCoursesStatus.value == ApiCallStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if ((controller.coursesModel.value.courses?.data ?? []).isEmpty) {
          return const Center(child: Text("Exams not found"));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                2.h.height,
                Obx(() {
                  final courses =
                      controller.coursesModel.value.courses?.data ?? [];
                  if (controller.apiCallCoursesStatus.value ==
                      ApiCallStatus.loading) {
                    return const CircularProgressIndicator();
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: courses.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.00,
                      crossAxisSpacing: 8.00,
                      childAspectRatio: .8,
                    ),
                    itemBuilder: (_, x) {
                      final course = courses[x];
                      return CustomCourseCard(
                        imageUrl:
                            AppConstants.storageUrl + course.image.toString(),
                        title: course.title ?? "",
                        regularPrice: course.regularPrice.toString(),
                        salePrice: course.salePrice.toString(),
                        onPressed: () {
                          // Handle buy button tap
                        },
                        rating: '5',
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
