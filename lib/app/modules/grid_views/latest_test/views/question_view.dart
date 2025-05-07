import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../../styles/text_style.dart';
import '../../../../components/custom_action_button.dart';
import '../../../../enums/question_type.dart';
import '../../../../helper/api_helper.dart';
import '../../../../models/question.dart';
import '../controllers/start_exam_controller.dart';
import '../models/start_exam_model.dart';

class ExamQuestionScreen extends StatefulWidget {
  final StartExamModel examStartModel;

  const ExamQuestionScreen({super.key, required this.examStartModel});

  @override
  State<ExamQuestionScreen> createState() => _ExamQuestionScreenState();
}

class _ExamQuestionScreenState extends State<ExamQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final StartExamController controller =
        Get.put(StartExamController(widget.examStartModel));
    if (kDebugMode) {
      print("Build  Exam Screen");
    }

    final questionList = widget.examStartModel.questions;

    if (questionList!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "পরীক্ষা",
            style:
                AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
          ),
          centerTitle: true,
          backgroundColor: LightThemeColors.primaryColor,
        ),
        body: const Center(
          child: Text(
            'কোন প্রশ্ন নেই!',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            controller.showExitConfirmationDialog();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        iconTheme: const IconThemeData(color: LightThemeColors.white),
        title: Text(
          "পরীক্ষা",
          style: AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            // Display timer
            controller.timerWork.value == true
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.clock,
                              size: 18.0, color: Colors.white),
                          const SizedBox(width: 8.0),
                          Text(
                            "সময় বাকি : ${_formatDuration(controller.duration!.value)} মিনিট",
                            style: AppTextStyles.heading4
                                .copyWith(color: LightThemeColors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),

            // Question choice area
            Expanded(
              child: ListView.builder(
                itemCount: questionList.length,
                itemBuilder: (context, index) {
                  final question = questionList[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: LightThemeColors.primaryColor, width: 1.5),
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
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error, color: Colors.red),
                              ),
                            if (question.questionImage != null)
                              const SizedBox(height: 10.00),

                            /// Description
                            question.description != null
                                ? HtmlWidget(question.description.toString())
                                : const SizedBox(),
                            if (question.description != null)
                              const SizedBox(height: 10.00),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: HtmlWidget(
                                        "${index + 1}. ${question.title}",
                                        textStyle: AppTextStyles.body1
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),

                                  /// popup menu items area
                                  Expanded(
                                    child: Obx(() {
                                      // Ensure that the controller has an observable value for the favorite status
                                      bool isFavorite =
                                          controller.checkQuestionExistInSaved(
                                              question.id!.toInt());

                                      return IconButton(
                                        onPressed: () {
                                          if (isFavorite) {
                                            removeFavoriteQuestion(
                                                question.id!.toInt());
                                            isFavorite = false;
                                          } else {
                                            questionFavAdd(
                                                question.id!.toInt());
                                            isFavorite = true;
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
                                ],
                              ),
                            ),
                            customQuestionWidget(controller, question),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            CustomActionButton(
              text: "সাবমিট এক্সাম",
              onPressed: () {
                controller.showSubmitConfirmationDialog();
              },
            ),
          ],
        );
      }),
    );
  }

  // Helper to format the remaining time as mm:ss
  String _formatDuration(int totalSeconds) {
    final hours = (totalSeconds / 3600).floor();
    final remainingMinutes = ((totalSeconds % 3600) / 60).floor();
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return "${hours.toString().padLeft(2, '0')}:${remainingMinutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else {
      return "${remainingMinutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }
  }

  Widget customQuestionWidget(
      StartExamController controller, Question question) {
    switch (question.questionType) {
      // case QuestionType.FILL_IN_THE_BLANK:
      //   return _buildFillInTheBlank(controller, question);
      case QuestionType.SINGLE_CHOICE:
        return _buildSingleChoice(controller, question);
      // case QuestionType.MULTIPLE_CHOICE:
      //   return _buildMultipleChoice(controller, question);
      default:
        return Container();
    }
  }

  Widget _buildSingleChoice(
      StartExamController controller, Question question) {
    return Column(
      children: question.options!.map((option) {
        // Check if the option is already selected
        // bool isSelected =
        //     controller.selectedAnswers[question.id] == option;

        return Obx(() {
          return RadioListTile<String>(
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            value: option.key.toString(),
            groupValue: controller.selectedAnswers[question.id] ??
                '', // The selected value of the group
            onChanged: (value) {
              debugPrint("evaluational$value");
              // Only allow selection if no answer has been chosen already
              if (controller.selectedAnswers[question.id] == null) {
                controller.selectAnswer(question.id!.toInt(), value!);
              }
            },
            title: HtmlWidget(option.value.toString()),

            activeColor: LightThemeColors.primaryColor,
            controlAffinity: ListTileControlAffinity.leading,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          );
        });
      }).toList(),
    );
  }

  // Widget _buildFillInTheBlank(
  //     ExamQuestionController controller, Question question) {
  //   int answerCount = question.answer!.length;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       ...List.generate(answerCount, (index) {
  //         String alphabetPrefix = String.fromCharCode(65 + index);
  //         return Column(
  //           children: [
  //             const SizedBox(height: 10.0),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     width: 40.0,
  //                     height: 40.0,
  //                     decoration: const BoxDecoration(
  //                       color: LightThemeColors.black,
  //                       shape: BoxShape.circle,
  //                     ),
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       alphabetPrefix,
  //                       style: const TextStyle(
  //                         fontSize: 20.0,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 5.00),
  //                 Expanded(
  //                   flex: 10,
  //                   child: TextField(
  //                     decoration: InputDecoration(
  //                       labelText: "${AppConstant.option.tr} $alphabetPrefix",
  //                       labelStyle: const TextStyle(
  //                           color: LightThemeColors.black,
  //                           fontSize: AppSizes.fontSizeSm),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(7),
  //                       ),
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(7),
  //                         borderSide: const BorderSide(
  //                           color: LightThemeColors.black,
  //                           width: 1,
  //                         ),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(7),
  //                         borderSide: const BorderSide(
  //                           color: LightThemeColors.gridColor,
  //                           width: 1,
  //                         ),
  //                       ),
  //                       contentPadding: const EdgeInsets.symmetric(
  //                           vertical: 8.0, horizontal: 10.0),
  //                     ),
  //                     onChanged: (value) {
  //                       controller.selectAnswer(question.id!.toInt(), value);
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         );
  //       }),
  //     ],
  //   );
}

