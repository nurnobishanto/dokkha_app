import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/config/constants/app_strings.dart';

import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../../../styles/text_style.dart';
import '../../../helper/api_helper.dart';
import '../../../models/question.dart';
import '../../../views/views/pdf_viewer.dart';
import '../../../views/widgets/exam_custom_button.dart';
import '../controllers/read_question_controller.dart';

class ReadQuestionView extends StatelessWidget {
  final List<Question> model;
  const ReadQuestionView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final questionList = model;
    final controller = Get.put(ReadQuestionController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "প্রশ্ন সমূহ",
          style: AppTextStyles.heading3.copyWith(color: LightThemeColors.white),
        ),
        iconTheme: const IconThemeData(color: LightThemeColors.white),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
      ),
      body: questionList.isEmpty
          ? const Center(
              child: Text(AppStrings.noDataFound),
            )
          : Padding(
              padding: const EdgeInsets.all(8.00),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: questionList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final question = questionList[index];
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: LightThemeColors.primaryColor,
                                  width: 1.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (question.questionImage != null)
                                    Image.network(
                                      "${AppConstants.storageUrl}${question.questionImage}",
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error,
                                                  color: Colors.red),
                                    ),
                                  question.questionImage != null
                                      ? const SizedBox(height: 10.00)
                                      : const SizedBox.shrink(),

                                  /// des
                                  if (question.description != null)
                                    HtmlWidget(
                                      question.description.toString(),
                                    ),
                                  question.description != null
                                      ? const SizedBox(height: 10.00)
                                      : const SizedBox.shrink(),
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: LightThemeColors.primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8.0),
                                        topLeft: Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 10,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: HtmlWidget(
                                              "${index + 1}. ${question.title}",
                                              textStyle: AppTextStyles.body1
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),

                                        /// popup menu items area
                                        Expanded(
                                          child: Obx(() {
                                            // Ensure that the controller has an observable value for the favorite status
                                            bool isFavorite = controller
                                                .checkQuestionExistInSaved(
                                                    question.id!.toInt());

                                            return IconButton(
                                              onPressed: () {
                                                if (isFavorite) {
                                                  removeFavoriteQuestion(
                                                      question.id!.toInt());
                                                } else {
                                                  questionFavAdd(
                                                      question.id!.toInt());
                                                }
                                                // This will trigger the UI update when the state changes
                                                controller.update();
                                              },
                                              icon: Icon(
                                                isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: LightThemeColors.white,
                                              ),
                                            );
                                          }),
                                        ),
                                        const SizedBox(width: 5.00),
                                      ],
                                    ),
                                  ),

                                  customSingleChoice(question)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget customSingleChoice(Question question) {
    return Column(
      children: [
        Column(
          children: question.options!.map((option) {
            return RadioListTile<String>(
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              value: option.key.toString(),
              groupValue: null,
              onChanged: null,
              title: HtmlWidget(
                option.value ?? '',
                textStyle: AppTextStyles.body1.copyWith(
                  color: Colors.black,
                ),
              ),
              activeColor: LightThemeColors.primaryColor,
              controlAffinity: ListTileControlAffinity.leading,
            );
          }).toList(),
        ),
        Row(
          spacing: 10.0,
          children: [
            Expanded(
              child: ExamCustomButton(
                text: "উত্তর ও সমাধান",
                onPressed: () {
                  Get.defaultDialog(
                    title: "উত্তর ও সমাধান",
                    content: AnswerAndSolutionWidgets(question: question),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  // Widget customQuestionWidget(
  //     Result result) {
  //
  //
  //   switch (result.question!.questionType) {
  //     case QuestionType.FILL_IN_THE_BLANK:
  //       return customFillInTheBlank(controller, question);
  //     case QuestionType.SINGLE_CHOICE:
  //       return customSingleChoice(controller, question);
  //     case QuestionType.MULTIPLE_CHOICE:
  //       return customMultipleChoice(controller, question);
  //     default:
  //       return Container();
  //   }
  // }
  // Helper method to display each summary item
}

class AnswerAndSolutionWidgets extends StatelessWidget {
  final Question question;

  const AnswerAndSolutionWidgets({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (question.options != null) _buildAnswerSection(),
        (question.explanation != null)
            ? _buildExplanationSection(context)
            : const SizedBox.shrink(),
        (question.explanationImage != null)
            ? _buildExplanationImage()
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildAnswerSection() {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "সঠিক উত্তর",
              style: AppTextStyles.heading5,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            // if (question.question!.questionType == QuestionType.FILL_IN_THE_BLANK)
            //   ...question.question!.answer!.map((answer) => Padding(
            //     padding: const EdgeInsets.only(bottom: 4.0),
            //     child: Text(answer['answer'],
            //         style: const TextStyle(fontSize: 14)),
            //   ))
            // else
            ...question.options!.map((option) {
              return option.value != null && option.isCorrect == true
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: HtmlWidget(
                        option.value!,
                        textStyle: AppTextStyles.body1,
                      ),
                    )
                  : const SizedBox.shrink();
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildExplanationSection(context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ব্যাখ্যা",
            style: AppTextStyles.heading5,
          ),
          const SizedBox(height: 8),
          HtmlWidget(
            question.explanation.toString(),
            textStyle: AppTextStyles.body1,
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationImage() {
    String fileUrl =
        AppConstants.storageUrl + question.explanationImage.toString();
    bool isPdf = fileUrl.toLowerCase().endsWith('.pdf');
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ছবির ব্যাখ্যা",
            style: AppTextStyles.heading5,
          ),
          const SizedBox(height: 8),
          isPdf
              ? InkWell(
                  onTap: () {
                    Get.to(() => PdfViewerScreen(
                          title: 'ব্যাখ্যা',
                          file: fileUrl,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.picture_as_pdf,
                            color: Colors.red, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          "ব্যাখ্যা",
                          style: AppTextStyles.heading5
                              .copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                )
              : Image.network(
                  AppConstants.storageUrl +
                      question.explanationImage.toString(),
                  fit: BoxFit.cover,
                ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:get/get.dart';
// import 'package:lokkha/app/modules/subject_sections/controllers/read_question_controller.dart';
// import 'package:lokkha/config/theme/light_theme_colors.dart';
// import 'package:lokkha/utils/constants.dart';
// import '../../../../../styles/text_style.dart';
// import '../../../components/custom_action_button.dart';
// import '../../grid_views/latest_test/controllers/start_exam_controller.dart';
// import '../../grid_views/latest_test/models/start_exam_model.dart';
//
// class ReadQuestionView extends StatefulWidget {
//   final  questionModel;
//   final int questionIndex;
//
//   const ReadQuestionView({
//     super.key,
//     required this.questionModel,
//     required this.questionIndex,
//   });
//
//   @override
//   State<ReadQuestionView> createState() => _ReadQuestionViewState();
// }
//
// class _ReadQuestionViewState extends State<ReadQuestionView> {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ReadQuestionViewController());
//     final questionList = widget.questionModel.questions;
//
//     if (questionList == null || questionList.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "পরীক্ষা",
//             style:
//             AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
//           ),
//           centerTitle: true,
//           backgroundColor: LightThemeColors.primaryColor,
//         ),
//         body: const Center(child: Text('কোন প্রশ্ন নেই!')),
//       );
//     }
//
//     final question = questionList[widget.questionIndex];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "প্রশ্ন ${widget.questionIndex + 1}",
//           style:
//           AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: LightThemeColors.primaryColor,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (question.questionImage != null)
//               Image.network(
//                 "${AppConstants.storageUrl}${question.questionImage}",
//                 errorBuilder: (context, error, stackTrace) =>
//                 const Icon(Icons.error, color: Colors.red),
//               ),
//             if (question.questionImage != null)
//               const SizedBox(height: 10),
//
//             if (question.description != null)
//               HtmlWidget(question.description.toString()),
//             if (question.description != null)
//               const SizedBox(height: 10),
//
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: LightThemeColors.primaryColor,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: HtmlWidget(
//                 "${widget.questionIndex + 1}. ${question.title}",
//                 textStyle: AppTextStyles.body1.copyWith(color: Colors.white),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             _buildSingleChoice(Get.find<StartExamController>(), question),
//
//             const SizedBox(height: 30),
//
//             CustomActionButton(
//               text: "সাবমিট এক্সাম",
//               onPressed: () {
//                 //controller.showSubmitConfirmationDialog();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSingleChoice(StartExamController controller, Question question) {
//     return Column(
//       children: question.options!.map((option) {
//         return Obx(() {
//           return RadioListTile<String>(
//             dense: true,
//             contentPadding: EdgeInsets.zero,
//             visualDensity: VisualDensity.compact,
//             value: option.key.toString(),
//             groupValue: controller.selectedAnswers[question.id] ?? '',
//             onChanged: (value) {
//               if (controller.selectedAnswers[question.id] == null) {
//                 controller.selectAnswer(question.id!.toInt(), value!);
//               }
//             },
//             title: HtmlWidget(option.value.toString()),
//             activeColor: LightThemeColors.primaryColor,
//             controlAffinity: ListTileControlAffinity.leading,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//           );
//         });
//       }).toList(),
//     );
//   }
// }
