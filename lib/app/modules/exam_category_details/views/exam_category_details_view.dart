import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_transparent_divider.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../services/api_call_status.dart';
import '../../exam_category/widgets/exam_category_card.dart';
import '../controllers/exam_category_details_controller.dart';
import '../widgets/exam_card.dart';
import '../widgets/exam_details_dialog.dart';

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
        if ((controller.examCategoriesModel.value.examCategories?.isEmpty ??
                true) &&
            (controller.model.value.freeExams?.data?.isEmpty ?? true)) {
          return const Center(child: Text("Data not found"));
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  if ((controller.examCategoriesModel.value.examCategories ??
                          [])
                      .isNotEmpty) ...[
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
                              controller.fetchExamCategoryDetails(
                                  category.id!.toInt());
                              controller.fetchExamCategoriesWithParentID(
                                  category.id!.toInt());
                            },
                          );
                        },
                      );
                    }),
                  ],
                  if (controller.model.value.freeExams!.data!.isNotEmpty) ...[
                    5.h.height,
                    SectionTitleWithDivider(title: "পরীক্ষাসমূহ"),
                  ],
                  Obx(() {
                    final exams = controller.model.value.freeExams?.data ?? [];
                    if (controller.apiCallStatus.value ==
                        ApiCallStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: exams.length,
                      itemBuilder: (_, x) {
                        final exam = exams[x];
                        return ExamCard(
                          exam: exam,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ExamDetailsDialog(
                                exam: exam,
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, int index) => 5.h.height,
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }),

      bottomNavigationBar: Obx(() {
        if (controller.totalPages.value <= 1) return SizedBox.shrink();

        return SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 25),
              child: Row(
                children: [
                  // First Page
                  IconButton(
                    icon: Icon(Icons.first_page),
                    onPressed: controller.currentPage.value > 1
                        ? controller.firstPage
                        : null,
                  ),

                  // Previous
                  IconButton(
                    icon: Icon(Icons.navigate_before),
                    onPressed: controller.currentPage.value > 1
                        ? controller.previousPage
                        : null,
                  ),

                  // Page Numbers
                  ...List.generate(
                      controller.totalPages.value, (index) => index + 1)
                      .where((page) {
                    int current = controller.currentPage.value;
                    return (page >= current - 2 && page <= current + 2) ||
                        page == 1 ||
                        page == controller.totalPages.value;
                  }).map((page) {
                    bool isActive = page == controller.currentPage.value;
                    return InkWell(
                      onTap: () => controller.goToPage(page),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding:
                        EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          color: isActive
                              ? LightThemeColors.primaryColor
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border:
                          Border.all(color: LightThemeColors.primaryColor),
                        ),
                        child: Text(
                          page.toString(),
                          style: TextStyle(
                            color: isActive ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }),

                  // Next
                  IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: controller.currentPage.value <
                        controller.totalPages.value
                        ? controller.nextPage
                        : null,
                  ),

                  // Last
                  IconButton(
                    icon: Icon(Icons.last_page),
                    onPressed: controller.currentPage.value <
                        controller.totalPages.value
                        ? controller.lastPage
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
