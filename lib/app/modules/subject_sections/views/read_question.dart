import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/subject_sections/controllers/read_question_view_controller.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../../styles/text_style.dart';
import '../../../components/custom_action_button.dart';
import '../../grid_views/latest_test/controllers/start_exam_controller.dart';
import '../../grid_views/latest_test/models/start_exam_model.dart';

class ReadQuestionView extends StatefulWidget {
  final  questionModel;
  final int questionIndex;

  const ReadQuestionView({
    super.key,
    required this.questionModel,
    required this.questionIndex,
  });

  @override
  State<ReadQuestionView> createState() => _ReadQuestionViewState();
}

class _ReadQuestionViewState extends State<ReadQuestionView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReadQuestionViewController());
    final questionList = widget.questionModel.questions;

    if (questionList == null || questionList.isEmpty) {
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
        body: const Center(child: Text('কোন প্রশ্ন নেই!')),
      );
    }

    final question = questionList[widget.questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "প্রশ্ন ${widget.questionIndex + 1}",
          style:
          AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
        ),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
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
              const SizedBox(height: 10),

            if (question.description != null)
              HtmlWidget(question.description.toString()),
            if (question.description != null)
              const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: LightThemeColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: HtmlWidget(
                "${widget.questionIndex + 1}. ${question.title}",
                textStyle: AppTextStyles.body1.copyWith(color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            _buildSingleChoice(Get.find<StartExamController>(), question),

            const SizedBox(height: 30),

            CustomActionButton(
              text: "সাবমিট এক্সাম",
              onPressed: () {
                //controller.showSubmitConfirmationDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleChoice(StartExamController controller, Question question) {
    return Column(
      children: question.options!.map((option) {
        return Obx(() {
          return RadioListTile<String>(
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            value: option.key.toString(),
            groupValue: controller.selectedAnswers[question.id] ?? '',
            onChanged: (value) {
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
}
