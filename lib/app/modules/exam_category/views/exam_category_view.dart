import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/config/extensions/common_extension.dart';

import '../../../../config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/exam_category_controller.dart';
import '../widgets/exam_category_card.dart';

class ExamCategoryView extends GetView<ExamCategoryController> {
  const ExamCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExamCategoryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('পরীক্ষার ক্যাটাগরি'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.apiCallStatus.value == ApiCallStatus.loading ||
            controller.apiCallCourseCategoriesStatus.value ==
                ApiCallStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.model.value.examCategories!.isEmpty &&
            controller.courseCategoriesModel.value.courseCategories!.isEmpty) {
          return const Center(child: Text("Data not found"));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Premium Courses/Exams
                5.h.height,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: LightThemeColors.primaryColor,
                          thickness: 2,
                          endIndent: 8,
                        ),
                      ),
                      Text(
                        "প্রিমিয়াম পরীক্ষার ক্যাটাগরি",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading4,
                      ),
                      Expanded(
                        child: Divider(
                          color: LightThemeColors.primaryColor,
                          thickness: 2,
                          indent: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                5.h.height,
                Obx(() {
                  final courses =
                      controller.courseCategoriesModel.value.courseCategories ??
                          [];
                  if (controller.apiCallCourseCategoriesStatus.value ==
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
                      childAspectRatio: 3.0,
                    ),
                    itemBuilder: (_, x) {
                      final course = courses[x];
                      //courses.forEach((data)=> print(data.id));

                      return ExamCategoryCard(
                        title: course.title ?? "",
                        onTap: () {
                          Get.toNamed(
                            Routes.COURSES,
                            arguments: {
                              "course_category_id": course.id,
                              'category_name': course.title,
                            },
                          );
                        },
                      );
                    },
                  );
                }),

                /// Free Courses/Exams

                5.h.height,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: LightThemeColors.primaryColor,
                          thickness: 2,
                          endIndent: 8,
                        ),
                      ),
                      Text(
                        "ফ্রি পরীক্ষার ক্যাটাগরি",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.heading4,
                      ),
                      Expanded(
                        child: Divider(
                          color: LightThemeColors.primaryColor,
                          thickness: 2,
                          indent: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                5.h.height,
                Obx(() {
                  final exams = controller.model.value.examCategories ?? [];
                  if (controller.apiCallStatus.value == ApiCallStatus.loading) {
                    return const CircularProgressIndicator();
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: exams.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.00,
                      crossAxisSpacing: 8.00,
                      childAspectRatio: 3.0,
                    ),
                    itemBuilder: (_, x) {
                      final exam = exams[x];
                      return ExamCategoryCard(
                        title: exam.name ?? "",
                        onTap: () {
                          if (exam.id != null) {
                            Get.toNamed(Routes.EXAM_CATEGORY_DETAILS,
                                arguments: {"category_id": exam.id});
                          }
                        },
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
