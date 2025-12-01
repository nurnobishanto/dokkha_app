import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/modules/current_affairs/controllers/current_affairs_controller.dart';
import 'package:lokkha/app/views/widgets/package_required_popup.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/styles/text_style.dart';

import '../../../../config/theme/light_theme_colors.dart';
import '../../../helper/global.dart';
import '../../../routes/app_pages.dart';
import '../../../views/widgets/explanation_dialog.dart';

class CurrentAffairsContentView extends StatelessWidget {
  const CurrentAffairsContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CurrentAffairsController());
    return Scaffold(
      floatingActionButton: CircleAvatar(
        backgroundColor: LightThemeColors.primaryColor,
        radius: 28,
        child: IconButton(
          icon: const Icon(FontAwesomeIcons.calendar, color: Colors.white),
          onPressed: () async {
            if (havePackage.value) {
              DateTime? pickedDate = await showDatePicker(
                context: Get.context!,
                initialDate: null,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                String formattedDate =
                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                controller.fetchCurrentAffairs("", date: formattedDate);
              }
            } else {
              Get.dialog(PackageRequiredPopup());
            }
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = controller.model.value.currentAffairs?.data;

        if (items!.isEmpty) {
          return const Center(child: Text('No Data Found'));
        }

        return ListView.builder(
          itemCount: items.length + 1, // +1 for Load More
          itemBuilder: (context, index) {
            if (index == items.length) {
              // Load More button
              if (controller.currentPage.value <
                  (controller.model.value.currentAffairs?.lastPage ?? 0)) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.fetchCurrentAffairs("",
                            page: controller.currentPage.value + 1);
                      },
                      child: Container(
                        height: 40,
                        width: Get.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: LightThemeColors.primaryColor,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'আরও দেখুন',
                            style: TextStyle(
                              color: LightThemeColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }

            final data = items[index];
            final bool isLocked = !havePackage.value && index > 0;

            // Build all questions for this group
            Widget questionsColumn = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(data.questions?.length ?? 0, (i) {
                var question = data.questions![i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(FontAwesomeIcons.arrowRight, size: 15.0),
                          const SizedBox(width: 5.0),
                          Expanded(
                            child: HtmlWidget(
                              question.title ?? "",
                              textStyle: AppTextStyles.heading5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: question.options
                                ?.where((option) => option.isCorrect == true)
                                .map((option) => Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: HtmlWidget(
                                          '<b>উত্তর:</b> ${option.value ?? ""}',
                                          textStyle: AppTextStyles.body1,
                                        ),
                                      ),
                                    ))
                                .toList() ??
                            [],
                      ),
                      if (question.explanation != null)
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              if (havePackage.value) {
                                ExplanationDialog.show(question);
                              } else {
                                Get.dialog(PackageRequiredPopup());
                              }
                            },
                            child: Text(
                              "ব্যাখ্যা দেখুন →",
                              style: AppTextStyles.body1.copyWith(
                                color: LightThemeColors.primaryColor,
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        )
                      else
                        const SizedBox(height: 10.0),
                    ],
                  ),
                );
              }),
            );

            // Wrap the group content with blur if locked
            if (isLocked) {
              questionsColumn = Stack(
                children: [
                  questionsColumn,
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(color: Colors.black.withOpacity(0.15)),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        "প্রিমিয়াম কনটেন্ট",
                        style: AppTextStyles.heading4.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Always show the date header
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      10.0.w.width,
                      Center(
                        child: Text(
                          data.date ?? "",
                          style: AppTextStyles.heading4,
                        ),
                      ),
                      10.0.w.width,
                      const Expanded(child: Divider()),
                    ],
                  ),
                  10.0.h.height,
                  questionsColumn, // Group content (blurred if locked)
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
