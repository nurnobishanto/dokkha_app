import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/mock_test_tab/mock_test/models/mock_start_exam_model.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../../../styles/text_style.dart';
import '../../../../../components/custom_action_button.dart';
import '../../../../../helper/api_helper.dart';
import '../controllers/mock_test_start_exam_controller.dart';

class MockExamQuestionScreen extends StatefulWidget {
  final MockStartExamModel mockExamStartModel;

  const MockExamQuestionScreen({super.key, required this.mockExamStartModel});

  @override
  State<MockExamQuestionScreen> createState() => _MockExamQuestionScreenState();
}

class _MockExamQuestionScreenState extends State<MockExamQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final MockExamQuestionController controller =
        Get.put(MockExamQuestionController(widget.mockExamStartModel));
    if (kDebugMode) {
      print("Build Mock Exam Screen");
    }

    final questionList = widget.mockExamStartModel.questions;

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
      MockExamQuestionController controller, Question question) {
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
      MockExamQuestionController controller, Question question) {
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
  //     MockExamQuestionController controller, Question question) {
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

/// PDF
// Future<void> generateAndSharePdf() async {
//   print("Called PDF");
//   final pdf = pw.Document();
//
//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         final question = widget.mockExamStartModel.questions![0];
//         return pw.Center(
//           child: pw.Column(
//             mainAxisAlignment: pw.MainAxisAlignment.center,
//             children: [
//               pw.Text(
//                 "${(Get.locale.toString() == 'en') ? question.titleEn : question.title}",
//                 style:pw.TextStyle(
//                   fontWeight:pw.FontWeight.bold,
//                   fontSize: 15.5,
//                   color:PdfColors.white,
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//               pw.Text('This is a simple PDF document.'),
//             ],
//           ),
//         );
//       },
//     ),
//   );
//
//   // **ডিভাইসের লোকাল স্টোরেজে ফাইল সংরক্ষণ করা**
//   final output = await getExternalStorageDirectory();
//   final file = File("${output!.path}/example.pdf");
//   await file.writeAsBytes(await pdf.save());
//
//   print("PDF Generated: ${file.path}");
//
//   //
//   await Share.shareXFiles([XFile(file.path)], text: "Here is your PDF file!");
//
//   // **PDF PDf (if Needed)**
//   // OpenFile.open(file.path);
// }

// Widget _buildSingleChoice(
//     MockExamQuestionController controller, Question question) {
//   return Column(
//     children: question.options!.map((option) {
//       // Check if the option is already selected
//       bool isSelected =
//           controller.selectedAnswers[question.id] == option.option;
//
//       return GestureDetector(
//         onTap: () {
//           // Only select if no answer has been chosen already
//           if (controller.selectedAnswers[question.id] == null) {
//             controller.selectAnswer(question.id!.toInt(), option.option!);
//           }
//         },
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 4.0),
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? LightThemeColors.primary
//                 : LightThemeColors.primary01.withOpacity(.1),
//             borderRadius: BorderRadius.circular(6.0),
//             boxShadow: [
//               BoxShadow(
//                 color: LightThemeColors.primary.withOpacity(0.1),
//                 blurRadius: 0.0,
//                 offset: const Offset(0, 0),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Text(
//                   option.option ?? '',
//                   style: TextStyle(
//                     fontSize: 15.0,
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }).toList(),
//   );
// }
//
// Widget _buildMultipleChoice(
//     MockExamQuestionController controller, Question question) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: question.options!.map((option) {
//       bool isSelected =
//           controller.selectedAnswers[question.id]?.contains(option.option) ??
//               false;
//       return Container(
//         margin: const EdgeInsets.symmetric(vertical: 2.0),
//         decoration: BoxDecoration(
//           //color: isSelected ? LightThemeColors.primary : Colors.white,
//           borderRadius: BorderRadius.circular(6.0),
//           border: Border.all(
//             color: isSelected ? LightThemeColors.primaryColor : Colors.grey.shade300,
//             width: 1.2,
//           ),
//         ),
//         child: Theme(
//           data: ThemeData(
//             checkboxTheme: CheckboxThemeData(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(4.0),
//               ),
//               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               visualDensity: VisualDensity.compact,
//             ),
//           ),
//           child: CheckboxListTile(
//             dense: true,
//             controlAffinity: ListTileControlAffinity.leading,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 2.0),
//             title: Text(
//               option.option!,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(
//                 height: 1,
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             value: isSelected,
//             onChanged: (value) {
//               debugPrint("Multiple $value");
//               controller.selectAnswer(
//                   question.id!.toInt(), option.option.toString());
//             },
//           ),
//         ),
//       );
//     }).toList(),
//   );
// }

// Widget _buildMultipleChoice(
//     MockExamQuestionController controller, Question question) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       ...question.options!.map((option) {
//         return Container(
//           margin: const EdgeInsets.symmetric(vertical: 10.0),
//           decoration: BoxDecoration(
//             color: (controller.selectedAnswers[question.id!.toInt()]
//                         ?.contains(option.option) ??
//                     false)
//                 ? LightThemeColors.primary
//                 : LightThemeColors.primary01.withValues(alpha: .1),
//             borderRadius: BorderRadius.circular(6.0),
//             boxShadow: [
//               BoxShadow(
//                 color: LightThemeColors.primary.withValues(alpha: 0.1),
//                 blurRadius: 0.0,
//                 offset: const Offset(0, 0),
//               ),
//             ],
//           ),
//           child: CheckboxListTile(
//             controlAffinity: ListTileControlAffinity.leading,
//             contentPadding: EdgeInsets.zero,
//             visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
//             title: Text(
//               option.option!,
//               style: const TextStyle(
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.black,
//               ),
//             ),
//             value: controller.selectedAnswers[question.id]
//                     ?.contains(option.option) ??
//                 false,
//             onChanged: (value) {
//               controller.selectAnswer(question.id!.toInt(), option.option);
//             },
//           ),
//         );
//       }),
//     ],
//   );
// }
//}
