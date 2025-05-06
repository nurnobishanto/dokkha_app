import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../../helper/api_helper.dart';
import '../../../../models/fav_question_model.dart';
import '../../../../views/views/pdf_viewer.dart';
import '../../../../views/widgets/exam_custom_button.dart';

class FavQuestionListScreen extends StatelessWidget {
  const FavQuestionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getFavList();



    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'ফেভারিট',
          style: AppTextStyles.heading5.copyWith(color: LightThemeColors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
      ),
      body: Obx(() {
        final questionList = favoriteQuestionsListModel.value.favoriteQuestions;
        if (isFavLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (questionList!.isEmpty) {
          return const Center(
            child: Text('তথ্য পাওয়া যায়নি'),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(1.00),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: questionList.length,
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
                                          child: Text(
                                            "${index + 1}. ${question.title}",
                                            style: AppTextStyles.heading5.copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),

                                      ///
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            removeFavoriteQuestion(
                                              question.id!.toInt(),
                                            ).then((onValue) {
                                                getFavList();
                                            });
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.trash,
                                            size: 15.0,
                                            color:Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 2.00),
                                    ],
                                  ),
                                ),
                                //customQuestionWidget(question),
                                customSingleChoice(question)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget customSingleChoice(FavoriteQuestion question) {
    return Column(
      children: [
        Column(
          children: question.options!.map((option) {
            return RadioListTile<String>(
              dense: true,
              groupValue: '',
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              value: option.key.toString(),
              onChanged: null,
              title: Text(
                option.value.toString(),
                style: AppTextStyles.heading5,
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
                text: "উত্তর এবং সমাধান",
                onPressed: () {
                  Get.defaultDialog(
                      title: "উত্তর এবং সমাধান",
                      content: AnswerAndSolutionWidgets(question: question));
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class AnswerAndSolutionWidgets extends StatelessWidget {
  final FavoriteQuestion question;

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
              'উত্তর',
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
              return option.key != null && option.isCorrect == true
                  ? Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  option.value!,
                  style:
                AppTextStyles.heading5,
                  textAlign: TextAlign.start,
                ),
              )
                  : const SizedBox.shrink();
            }),
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
           'ব্যাখ্যা',
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
    String fileUrl = AppConstants.storageUrl + question.explanationImage.toString();
    bool isPdf = fileUrl.toLowerCase().endsWith('.pdf');
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ব্যাখ্যাচিত্র',
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
                    'ব্যাখ্যা',
                    style: AppTextStyles.heading5,
                  ),
                ],
              ),
            ),
          )
              : Image.network(
            AppConstants.storageUrl + question.explanationImage.toString(),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
