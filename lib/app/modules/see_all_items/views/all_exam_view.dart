import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../services/api_call_status.dart';
import '../../exam_category/widgets/exam_category_card.dart';
import '../../exam_category_details/widgets/exam_card.dart';
import '../../exam_category_details/widgets/exam_details_dialog.dart';
import '../controllers/see_all_items_controller.dart';

// class AllExamView extends GetView<SeeAllItemsController> {
//   const AllExamView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // read the argument once into a local variable
//     // final args = Get.arguments as Map<String, dynamic>? ?? {};
//     // final categoryName = args['category_name'] as String? ?? '';
//     final controller = Get.put(SeeAllItemsController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "categoryName",
//           style: TextStyle(fontSize: 16.0.sp),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Obx(() {
//           final status = controller.examApiCallStatus;
//           final exams = controller.allExamModel.value.exams?.exam ?? [];
//
//           // if (status == ApiCallStatus.loading) {
//           //   return const Center(child: CircularProgressIndicator());
//           // }
//
//           if (exams.isEmpty) {
//             return const Center(child: Text("Data not found"));
//           }
//
//           return CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(child: SizedBox(height: 6.h)),
//
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 sliver: SliverList.separated(
//                   itemCount: exams.length,
//                   separatorBuilder: (_, __) => SizedBox(height: 5.h),
//                   itemBuilder: (context, index) {
//                     final exam = exams[index];
//                     return ExamCard(
//                       exam: exam,
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) => ExamDetailsDialog(exam: exam),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//
//               const SliverToBoxAdapter(
//                 child: SizedBox(height: kBottomNavigationBarHeight),
//               ),
//             ],
//           );
//         }),
//       ),
//
//       // bottomNavigationBar: Obx(() {
//       //   if (controller.totalPages.value <= 1) return const SizedBox.shrink();
//       //   return SafeArea(
//       //     child: Container(
//       //       color: Colors.white,
//       //       padding: const EdgeInsets.only(bottom: 20, left: 25),
//       //       child: SingleChildScrollView(
//       //         scrollDirection: Axis.horizontal,
//       //         child: Row(
//       //           children: [
//       //             // First Page
//       //             IconButton(
//       //               icon: const Icon(Icons.first_page),
//       //               onPressed: controller.currentPage.value > 1
//       //                   ? controller.firstPage
//       //                   : null,
//       //             ),
//       //
//       //             // Previous
//       //             IconButton(
//       //               icon: const Icon(Icons.navigate_before),
//       //               onPressed: controller.currentPage.value > 1
//       //                   ? controller.previousPage
//       //                   : null,
//       //             ),
//       //
//       //             // Page Numbers
//       //             ...List.generate(
//       //                     controller.totalPages.value, (index) => index + 1)
//       //                 .where((page) {
//       //               int current = controller.currentPage.value;
//       //               return (page >= current - 2 && page <= current + 2) ||
//       //                   page == 1 ||
//       //                   page == controller.totalPages.value;
//       //             }).map((page) {
//       //               bool isActive = page == controller.currentPage.value;
//       //               return InkWell(
//       //                 onTap: () => controller.goToPage(page),
//       //                 child: Container(
//       //                   margin: const EdgeInsets.symmetric(horizontal: 4),
//       //                   padding: const EdgeInsets.symmetric(
//       //                       vertical: 6, horizontal: 10),
//       //                   decoration: BoxDecoration(
//       //                     color: isActive
//       //                         ? LightThemeColors.primaryColor
//       //                         : Colors.grey.shade200,
//       //                     borderRadius: BorderRadius.circular(8),
//       //                     border:
//       //                         Border.all(color: LightThemeColors.primaryColor),
//       //                   ),
//       //                   child: Text(
//       //                     page.toString(),
//       //                     style: TextStyle(
//       //                       color: isActive ? Colors.white : Colors.black87,
//       //                     ),
//       //                   ),
//       //                 ),
//       //               );
//       //             }),
//       //
//       //             // Next
//       //             IconButton(
//       //               icon: const Icon(Icons.navigate_next),
//       //               onPressed: controller.currentPage.value <
//       //                       controller.totalPages.value
//       //                   ? controller.nextPage
//       //                   : null,
//       //             ),
//       //
//       //             // Last
//       //             IconButton(
//       //               icon: const Icon(Icons.last_page),
//       //               onPressed: controller.currentPage.value <
//       //                       controller.totalPages.value
//       //                   ? controller.lastPage
//       //                   : null,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //     ),
//       //   );
//       // }),
//     );
//   }
// }

class AllExamView extends GetView<SeeAllItemsController> {
  const AllExamView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SeeAllItemsController());
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final categoryName = args['category_name'] as String? ?? 'Exams';

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName, style: TextStyle(fontSize: 16.0.sp)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          final status = controller.examApiCallStatus.value;
          final exams = controller.allExamModel.value.exams?.data ?? [];

          if (status == ApiCallStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (exams.isEmpty) {
            return const Center(child: Text("Data not found"));
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 6.h)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.separated(
                  itemCount: exams.length,
                  separatorBuilder: (_, __) => SizedBox(height: 5.h),
                  itemBuilder: (context, index) {
                    final exam = exams[index];
                    return ExamCard(
                      exam: exam,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ExamDetailsDialog(exam: exam),
                        );
                      },
                    );
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: kBottomNavigationBarHeight),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.totalPages.value <= 1) return const SizedBox.shrink();

        return SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: 20, left: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.first_page),
                    onPressed: controller.currentPage.value > 1
                        ? controller.firstPage
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigate_before),
                    onPressed: controller.currentPage.value > 1
                        ? controller.previousPage
                        : null,
                  ),
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
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
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
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: controller.currentPage.value <
                            controller.totalPages.value
                        ? controller.nextPage
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.last_page),
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
