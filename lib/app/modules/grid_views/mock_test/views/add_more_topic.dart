// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lokkha/config/constants/app_strings.dart';
// import 'package:lokkha/styles/text_style.dart';
//
// import '../../../../../config/theme/light_theme_colors.dart';
// import '../../../../components/custom_action_button.dart';
//
// class AddMoreTopic extends StatelessWidget {
//   const AddMoreTopic({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // final AddMoreTopicController controller = Get.put(AddMoreTopicController());
//     // final MockTestController mockController = Get.find<MockTestController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: Text(
//           "addMoreTopic",
//           style: AppTextStyles.body,
//         ),
//         iconTheme: const IconThemeData(color: LightThemeColors.white),
//         centerTitle: true,
//         backgroundColor: LightThemeColors.primary,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Obx(
//           () => Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 8),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 alignment: WrapAlignment.center,
//                 children: mockController.model.value.subjects!.map((topic) {
//                   if (controller.selectedSubjects
//                       .any((subject) => subject.id == topic.id)) {
//                     return const SizedBox.shrink();
//                   } else {
//                     return InkWell(
//                       onTap: () async {
//                         MockSubjectSelect newSubject = MockSubjectSelect(
//                             id: topic.id,
//                             name: topic.name,
//                             quantity: min(15, topic.questionsCount!.toInt()),
//                             max: topic.questionsCount!.toInt());
//                         await MySharedPref.addOrUpdateMockSubjectSelect(
//                             newSubject);
//                         Get.off(const ExamOverviewScreen());
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: AppColors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withValues(alpha: 0.05),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 2),
//                             )
//                           ],
//                         ),
//                         child: Text(
//                           topic.name.toString(),
//                           style: kSubtitleStyle,
//                         ),
//                       ),
//                     );
//                   }
//                 }).toList(),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   const Expanded(
//                     child: Divider(),
//                   ),
//                   const SizedBox(width: 10.00),
//                   Text(EnConstant.selectedTopic.tr),
//                   const SizedBox(width: 10.00),
//                   const Expanded(
//                     child: Divider(),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 alignment: WrapAlignment.center,
//                 children: controller.selectedSubjects.map((subject) {
//                   return Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: LightThemeColors.primary,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.05),
//                           spreadRadius: 1,
//                           blurRadius: 5,
//                           offset: const Offset(0, 2),
//                         )
//                       ],
//                     ),
//                     child: Text(
//                       subject.name.toString(),
//                       style: AppTextStyles.body,
//                     ),
//                   );
//                 }).toList(),
//               ),
//               const Spacer(),
//               CustomActionButton(
//                 text: "Start Exam",
//                 onPressed: () {
//                   // Get.off(const ExamSetTimeScreen());
//                 },
//               ),
//               const SizedBox(height: 10.00),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
