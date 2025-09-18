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
        title: const Text('পরীক্ষার সমস্ত ক্যাটাগরি'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.apiCallStatus.value == ApiCallStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.model.value.examCategories!.isEmpty) {
          return const Center(child: Text("Data not found"));
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 5.h.height,
                // Center(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           color: LightThemeColors.primaryColor,
                //           thickness: 2,
                //           endIndent: 8,
                //         ),
                //       ),
                //       Text(
                //         "প্রিমিয়াম কোর্স সূমহ",
                //         textAlign: TextAlign.center,
                //         style: AppTextStyles.heading4,
                //       ),
                //       Expanded(
                //         child: Divider(
                //           color: LightThemeColors.primaryColor,
                //           thickness: 2,
                //           indent: 8,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Obx(() {
                //   if (controller.apiCallStatus.value == ApiCallStatus.loading) {
                //     return CircularProgressIndicator();
                //   }
                //   return ListView.separated(
                //     padding: EdgeInsets.all(8),
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: 3,
                //     itemBuilder: (_, x) {
                //       return ExamCategoryCard(
                //         title: "Exam Category ${x + 1}",
                //         onTap: () {
                //           print("Tapped category ${x + 1}");
                //         },
                //       );
                //     },
                //     separatorBuilder: (x, i) => 8.h.height,
                //   );
                // }),
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
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (_, x) {
                      final exam = exams[x];
                      return ExamCategoryCard(
                        title: exam.name ?? "",
                        onTap: () {
                          Get.toNamed(Routes.EXAM_CATEGORY_DETAILS,
                              arguments: {"category_id": exam.id});
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
