import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/random_question/controller/random_question_controller.dart';
import 'package:lokkha/app/views/widgets/explanation_dialog.dart';
import 'package:lokkha/styles/text_style.dart';

import '../../../components/custom_action_button.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../helper/global.dart';

// class RandomQuestionSelector extends StatelessWidget {
//   final RxInt selectedOptionIndex = RxInt(-1);
//
//   RandomQuestionSelector({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(RandomQuestionController());
//     var question = controller.randomQuestionModel.value.question;
//     return Obx(() {
//       return controller.isLoading.value
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     'এখনি উত্তর দিন',
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.heading5,
//                   ),
//                 ),
//                 const SizedBox(height: 2.00),
//                 HtmlWidget(
//                   question?.title ?? '',
//                   textStyle: AppTextStyles.body1,
//                 ),
//                 const SizedBox(height: 2.00),
//                 if (question?.options != null && question!.options!.isNotEmpty)
//                   ...List.generate(question.options!.length, (index) {
//                     final option = question.options![index];
//                     return Obx(() => Column(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             controller.isAnswerSelected.value = true;
//                             selectedOptionIndex.value = index;
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 3.4),
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               color: selectedOptionIndex.value == index
//                                   ? (option.isCorrect == true
//                                   ? Colors.greenAccent.shade100
//                                   : Colors.red.shade100)
//                                   : Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1), // ঠিক করলাম
//                                   spreadRadius: 0,
//                                   blurRadius: 1,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: HtmlWidget(
//                                     "${option.value}",
//                                     textStyle: AppTextStyles.body1,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ));
//                   }),
//
//                 // ...List.generate(question!.options?.length ?? 0, (index) {
//                 //   final option = question.options![index];
//                 //   return Obx(() => Column(
//                 //         children: [
//                 //           GestureDetector(
//                 //             onTap: () {
//                 //               controller.isAnswerSelected.value = true;
//                 //               selectedOptionIndex.value = index;
//                 //             },
//                 //             child: Container(
//                 //               margin: const EdgeInsets.symmetric(vertical: 3.4),
//                 //               padding: const EdgeInsets.all(6.0),
//                 //               decoration: BoxDecoration(
//                 //                 color: selectedOptionIndex.value == index
//                 //                     ? (option.isCorrect == true
//                 //                         ? Colors.greenAccent.shade100
//                 //                         : Colors.red.shade100)
//                 //                     : Colors.white,
//                 //                 boxShadow: [
//                 //                   BoxShadow(
//                 //                     color: Colors.grey
//                 //                         .withValues(alpha: 0.1), // shadow color
//                 //                     spreadRadius: 0, // spread of shadow
//                 //                     blurRadius: 1, // blur effect
//                 //                     offset: const Offset(
//                 //                         0, 4), // position of shadow
//                 //                   ),
//                 //                 ],
//                 //                 borderRadius: BorderRadius.circular(5),
//                 //               ),
//                 //               child: Row(
//                 //                 children: [
//                 //                   Expanded(
//                 //                     child: HtmlWidget(
//                 //                       "${option.value}",
//                 //                       textStyle: AppTextStyles.body1,
//                 //                     ),
//                 //                   ),
//                 //                 ],
//                 //               ),
//                 //             ),
//                 //           ),
//                 //         ],
//                 //       ));
//                 // }),
//                 const SizedBox(height: 5.00),
//                 Obx(() {
//                   // Display to Text if the selected option is correct
//                   if (selectedOptionIndex.value != -1) {
//                     final selectedOption =
//                         question?.options![selectedOptionIndex.value];
//                     if (selectedOption?.isCorrect == true) {
//                       MySharedPref.incrementRandomQuestionCheck();
//                       return Column(
//                         children: [
//                           (controller.randomQuestionModel.value.question?.explanation?.isNotEmpty ?? false)
//                               ? HtmlWidget(
//                             controller.randomQuestionModel.value.question!.explanation!,
//                           )
//                               : const SizedBox.shrink(),
//
//                           const SizedBox(height: 10.00),
//                           CustomActionButton(
//                             text: "নতুন প্রশ্ন →",
//                             onPressed: () async {
//                               controller.getRandomQuestion(forceNew: true);
//                               int check =
//                                   await MySharedPref.getRandomQuestionCheck();
//                               if (!isLoggedIn.value) {
//                                 controller.getRandomQuestion(forceNew: true);
//                               } else if (check <= 3) {
//                                 controller.getRandomQuestion(forceNew: true);
//                               } else {
//                                 //Get.to(const AllPackages());
//                               }
//                             },
//                           ),
//                         ],
//                       );
//                     }
//                   }
//                   return const SizedBox.shrink();
//                 }),
//               ],
//             );
//     });
//   }
// }

class RandomQuestionSelector extends StatelessWidget {
  final RxInt selectedOptionIndex = RxInt(-1);

  RandomQuestionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RandomQuestionController());

    return Obx(() {
      final question = controller.randomQuestionModel.value.question;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (question == null) {
        return const Center(child: Text("লক্ষ্য প্রিমিয়াম প্রয়োজন"));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'এখনি উত্তর দিন',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading4,
            ),
          ),
          const SizedBox(height: 2),
          HtmlWidget(
            question.title ?? '',
            textStyle: AppTextStyles.body1,
          ),
          const SizedBox(height: 2),
          if (question.options != null && question.options!.isNotEmpty)
            ...List.generate(question.options!.length, (index) {
              final option = question.options![index];
              return Obx(() => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isAnswerSelected.value = true;
                          selectedOptionIndex.value = index;
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 3.4),
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: selectedOptionIndex.value == index
                                ? (option.isCorrect == true
                                    ? Colors.greenAccent.shade100
                                    : Colors.red)
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 1,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: HtmlWidget(
                                  option.value ?? '',
                                  textStyle: AppTextStyles.body1.copyWith(
                                    color: selectedOptionIndex.value == index
                                        ? (option.isCorrect == true
                                            ? Colors.black
                                            : Colors.white)
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
            }),
          const SizedBox(height: 5),
          Obx(() {
            if (selectedOptionIndex.value != -1) {
              final selectedOption =
                  question.options![selectedOptionIndex.value];
              if (selectedOption.isCorrect == true) {
                MySharedPref.incrementRandomQuestionCheck();
                return Row(
                  children: [
                    if (question.explanation?.isNotEmpty ?? false)
                      Expanded(
                        child: CustomActionButton(
                          text: "ব্যাখ্যা দেখুন",
                          onPressed: () {
                            ExplanationDialog.show(question);
                          },
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomActionButton(
                        text: "নতুন প্রশ্ন →",
                        onPressed: () async {
                          selectedOptionIndex.value = -1;
                          controller.getRandomQuestion(forceNew: true);
                          int check =
                              await MySharedPref.getRandomQuestionCheck();
                          if (!isLoggedIn.value) {
                            controller.getRandomQuestion(forceNew: true);
                          } else if (check <= 3) {
                            controller.getRandomQuestion(forceNew: true);
                          } else {
                            // Get.to(const AllPackages());
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
            }
            return const SizedBox.shrink();
          }),
        ],
      );
    });
  }
}
