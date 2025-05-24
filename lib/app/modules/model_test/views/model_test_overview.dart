import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';
import '../../../components/custom_action_button.dart';
import '../../../components/custom_network_image_card.dart';
import '../../../helper/global.dart';
import '../../../models/exam.dart';
import '../../../routes/app_pages.dart';

class ExamOverview extends GetView {
  final Exam exam;
  const ExamOverview({required this.exam, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'মডেল টেস্ট তথ্য',
          style: AppTextStyles.heading4.copyWith(color: LightThemeColors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exam Image
            exam.image!.isNotEmpty
                ? CustomNetworkImageCard(
                    imageUrl: AppConstants.storageUrl + exam.image.toString(),
                  )
                : const SizedBox.shrink(),
            // Title below image
            Text(
              exam.name ?? '',
              style: AppTextStyles.heading4,
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              "পরীক্ষার বিবরণ",
              style: AppTextStyles.heading5,
            ),
            4.h.height,
            HtmlWidget(
              exam.description.toString(),
              textStyle: AppTextStyles.body1,
            ),

            10.h.height,

            // Marks and Time Info
            Row(
              children: [
                Expanded(
                  child: CustomInfoTile(
                    icon: Icons.add_circle_outline,
                    label: "পজিটিভ নম্বর",
                    value: exam.positiveMark.toString(),
                  ),
                ),
                Expanded(
                  child: CustomInfoTile(
                    icon: Icons.remove_circle_outline,
                    label: "নেগেটিভ নম্বর",
                    value: "${exam.negativeMark}",
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomActionButton(
                    text: "প্রশ্ন পড়ুন",
                    onPressed: () async {
                      if (isLoggedIn.value) {
                        controller.testExamStart('read');
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
                        controller.testExamStart('exam');
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
    );
  }
}

class CustomInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const CustomInfoTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
