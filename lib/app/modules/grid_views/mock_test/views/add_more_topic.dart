import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/mock_test/views/topic_selection_view.dart';
import 'package:lokkha/styles/text_style.dart';
import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../controllers/add_more_topic_controller.dart';
import '../controllers/mock_test_controller.dart';
import '../models/mock_subject_select_model.dart';

class AddMoreTopic extends StatelessWidget {
  const AddMoreTopic({super.key});

  @override
  Widget build(BuildContext context) {
    final AddMoreTopicController controller = Get.put(AddMoreTopicController());
    final MockTestController mockController = Get.find<MockTestController>();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "আরও বিষয়",
            style: AppTextStyles.body,
          ),
          iconTheme: const IconThemeData(color: LightThemeColors.white),
          centerTitle: true,
          backgroundColor: LightThemeColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: List.generate(
                  mockController.model.value.subjects?.length ?? 0, (index) {
                final subject = mockController.model.value.subjects![index];

                final isSelected = controller.selectedSubjects.any((s) => s.id == subject.id);

                if (isSelected) {
                  return const SizedBox.shrink(); // skip if already selected
                }

                return InkWell(
                  onTap: () async {
                    MockSubjectSelect newSubject = MockSubjectSelect(
                        id: subject.id,
                        name: subject.name,
                        quantity: min(15, subject.questionCount!.toInt()),
                        max: subject.questionCount!.toInt());
                    await MySharedPref.addOrUpdateMockSubjectSelect(newSubject);
                    Get.to(TopicSelectionView(subject: subject));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.00.w, vertical: 8.00.h),
                    decoration: BoxDecoration(
                      color: LightThemeColors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      subject.name.toString(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.paragraph,
                    ),
                  ),
                );
              }),
            ),
          ),
        )
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Obx(
        //     () => Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         const SizedBox(height: 8),
        //         Wrap(
        //           spacing: 12,
        //           runSpacing: 12,
        //           alignment: WrapAlignment.center,
        //           children: mockController.model.value.subjects!.map((topic) {
        //             if (controller.selectedSubjects
        //                 .any((subject) => subject.id == topic.id)) {
        //               return const SizedBox.shrink();
        //             } else {
        //               return InkWell(
        //                 onTap: () async {
        //                   MockSubjectSelect newSubject = MockSubjectSelect(
        //                       id: topic.id,
        //                       name: topic.name,
        //                       quantity: min(15, topic.questionCount!.toInt()),
        //                       max: topic.questionCount!.toInt());
        //                   await MySharedPref.addOrUpdateMockSubjectSelect(
        //                       newSubject);
        //                   //Get.off(const ExamOverviewScreen());
        //                 },
        //                 child: Container(
        //                   padding: const EdgeInsets.symmetric(
        //                       horizontal: 16, vertical: 10),
        //                   decoration: BoxDecoration(
        //                     color: Colors.white,
        //                     borderRadius: BorderRadius.circular(8),
        //                     boxShadow: [
        //                       BoxShadow(
        //                         color: Colors.black.withValues(alpha: 0.05),
        //                         spreadRadius: 1,
        //                         blurRadius: 5,
        //                         offset: const Offset(0, 2),
        //                       )
        //                     ],
        //                   ),
        //                   child: Text(
        //                     topic.name.toString(),
        //                     style: AppTextStyles.body,
        //                   ),
        //                 ),
        //               );
        //             }
        //           }).toList(),
        //         ),
        //         const SizedBox(height: 16),
        //         const Row(
        //           children: [
        //             Expanded(
        //               child: Divider(),
        //             ),
        //             SizedBox(width: 10.00),
        //             Text("selectedTopic"),
        //             SizedBox(width: 10.00),
        //             Expanded(
        //               child: Divider(),
        //             ),
        //           ],
        //         ),
        //         const SizedBox(height: 16),
        //         Wrap(
        //           spacing: 12,
        //           runSpacing: 12,
        //           alignment: WrapAlignment.center,
        //           children: controller.selectedSubjects.map((subject) {
        //             return Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 16, vertical: 10),
        //               decoration: BoxDecoration(
        //                 color: LightThemeColors.primary,
        //                 borderRadius: BorderRadius.circular(8),
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.black.withValues(alpha: 0.05),
        //                     spreadRadius: 1,
        //                     blurRadius: 5,
        //                     offset: const Offset(0, 2),
        //                   )
        //                 ],
        //               ),
        //               child: Text(
        //                 subject.name.toString(),
        //                 style: AppTextStyles.body,
        //               ),
        //             );
        //           }).toList(),
        //         ),
        //         const Spacer(),
        //         CustomActionButton(
        //           text: "Start Exam",
        //           onPressed: () {
        //             // Get.off(const ExamSetTimeScreen());
        //           },
        //         ),
        //         const SizedBox(height: 10.00),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
