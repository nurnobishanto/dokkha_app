import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_transparent_divider.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';
import '../../../services/api_call_status.dart';
import '../../exam_category/widgets/exam_category_card.dart';
import '../controllers/exam_category_details_controller.dart';

class ExamCategoryDetailsView extends GetView<ExamCategoryDetailsController> {
  const ExamCategoryDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ExamCategoryDetailsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('ফ্রি পরীক্ষাসমূহ'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.apiCallStatus.value == ApiCallStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if ((controller.examCategoriesModel.value.examCategories?.isEmpty ?? true) &&
            (controller.model.value.freeExams?.isEmpty ?? true)) {
          return const Center(child: Text("Data not found"));
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (controller
                    .examCategoriesModel.value.examCategories!.isNotEmpty) ...[
                  8.h.height,
                  Obx(() {
                    final categories =
                        controller.examCategoriesModel.value.examCategories ??
                            [];
                    if (controller.apiCallStatus.value ==
                        ApiCallStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 2.5,
                      ),
                      itemBuilder: (_, x) {
                        final category = categories[x];
                        return ExamCategoryCard(
                          title: category.name ?? "",
                          onTap: () {
                            controller
                                .fetchExamCategoryDetails(category.id!.toInt());
                            controller.fetchExamCategoriesWithParentID(
                                category.id!.toInt());
                          },
                        );
                      },
                    );
                  }),
                ],
                if (controller.model.value.freeExams!.isNotEmpty) ...[
                  5.h.height,
                  SectionTitleWithDivider(title: "পরীক্ষাসমূহ"),
                ],
                Obx(() {
                  final exams = controller.model.value.freeExams ?? [];
                  if (controller.apiCallStatus.value == ApiCallStatus.loading) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: exams.length,
                    itemBuilder: (_, x) {
                      final exam = exams[x];
                      return ExamCategoryCard(
                        title: exam.name ?? "",
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (_, int index) => 5.h.height,
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
