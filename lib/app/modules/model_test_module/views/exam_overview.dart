import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/subject_sections/views/read_question.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';
import '../../../components/custom_action_button.dart';
import '../../../components/custom_network_image_card.dart';
import '../../../helper/global.dart';
import '../../../models/exam.dart';
import '../../../routes/app_pages.dart';
import '../controllers/model_test_controller.dart';

class ExamOverview extends GetView {
  final Exam exam;
  const ExamOverview({required this.exam, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ModelTestController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'পরীক্ষার তথ্য',
          style: AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exam Title
              Text(
                exam.name ?? '',
                style:
                    AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              // Exam Image with rounded border and shadow
              if (exam.image?.isNotEmpty ?? false) ...[
                10.h.height,
                CustomNetworkImageCard(
                  imageUrl: AppConstants.storageUrl + exam.image.toString(),
                ),
              ],
              10.h.height,
              // Description Title
              Text("পরীক্ষার বিবরণ", style: AppTextStyles.heading4),
              2.h.height,
              HtmlWidget(
                exam.description ?? '',
                textStyle: AppTextStyles.body1.copyWith(height: 1.6),
              ),
        
              15.h.height,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add_circle_outline,
                        color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "পজিটিভ নম্বর",
                        style: AppTextStyles.body2,
                      ),
                    ),
                    Text(
                      exam.positiveMark.toString(),
                      style: AppTextStyles.body2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              5.h.height,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.remove_circle_outline,
                        color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "নেগেটিভ নম্বর",
                        style: AppTextStyles.body2,
                      ),
                    ),
                    Text(
                      exam.negativeMark.toString(),
                      style: AppTextStyles.body2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
        
              const Spacer(),
              // Action Buttons (unchanged)
              Row(
                children: [
                  Expanded(
                    child: CustomActionButton(
                      text: "প্রশ্ন পড়ুন",
                      onPressed: () async {
                        if (isLoggedIn.value) {
                          Get.to(
                              ReadQuestionView(model: exam.questions!.toList()));
                        } else {
                          Get.toNamed(Routes.AUTH_GATEWAY);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: CustomActionButton(
                      text: "পরীক্ষা শুরু করুন",
                      onPressed: () async {
                        if (isLoggedIn.value) {
                          controller.startExam(exam.id!.toInt());
                        } else {
                          Get.toNamed(Routes.AUTH_GATEWAY);
                        }
                      },
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
