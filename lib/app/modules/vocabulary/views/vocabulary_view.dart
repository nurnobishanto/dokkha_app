import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/modules/current_affairs/controllers/international_current_affairs_controller.dart';
import 'package:lokkha/app/modules/vocabulary/controllers/vocabulary_controller.dart';
import 'package:lokkha/app/views/widgets/explanation_dialog.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/styles/text_style.dart';

import '../../../../config/theme/light_theme_colors.dart';

class VocabularyView extends StatelessWidget {
  const VocabularyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Vocabulary'),
      // floatingActionButton: CircleAvatar(
      //   backgroundColor: LightThemeColors.primaryColor,
      //   radius: 28,
      //   child: IconButton(
      //     icon: const Icon(FontAwesomeIcons.calendar, color: Colors.white),
      //     onPressed: () async {
      //       DateTime? pickedDate = await showDatePicker(
      //         context: Get.context!,
      //         initialDate: null,
      //         firstDate: DateTime(2000),
      //         lastDate: DateTime(2100),
      //       );
      //       if (pickedDate != null) {
      //         String formattedDate =
      //             "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      //         controller.fetchCurrentAffairs("", date: formattedDate);
      //       }
      //     },
      //   ),
      // ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = controller.model.value.vocabulary?.data;

        if (items!.isEmpty) {
          return const Center(child: Text('No Data Found'));
        }

        return ListView.builder(
          itemCount: items.length +
              1, // +1 because we want to show "Load More" button after last item
          itemBuilder: (context, index) {
            if (index == items.length) {
              // Last index => Load More Button
              if (controller.currentPage.value <
                  (controller.model.value.vocabulary?.lastPage ?? 0)) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.fetchVocabulary("",
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

            // Normal Data Row
            final data = items[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     const Expanded(child: Divider()),
                  //     10.0.w.width,
                  //     Center(
                  //       child: Text(
                  //         data.date ?? "",
                  //         style: AppTextStyles.heading4,
                  //       ),
                  //     ),
                  //     10.0.w.width,
                  //     const Expanded(child: Divider()),
                  //   ],
                  // ),
                  10.0.h.height,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.questions?.length ?? 0,
                    itemBuilder: (c, i) {
                      var question = data.questions![i];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                FontAwesomeIcons.arrowRight,
                                size: 15.0,
                              ),
                              const SizedBox(width: 5.00),
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
                                    ?.where(
                                        (option) => option.isCorrect == true)
                                    .map((option) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: HtmlWidget(
                                      '<b>উত্তর:</b> ${option.value ?? ""}',
                                      textStyle: AppTextStyles.body1,
                                    ),
                                  );
                                }).toList() ??
                                [],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                ExplanationDialog.show(question);
                              },
                              child: Text(
                                "ব্যাখ্যা দেখুন →",
                                style: AppTextStyles.body1.copyWith(
                                  color: LightThemeColors.primaryColor,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.00),
                        ],
                      );
                    },
                  ),
                  // Title Row
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
