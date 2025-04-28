import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/current_affairs/controllers/current_affairs_controller.dart';
import 'package:lokkha/styles/text_style.dart';

import '../../../../config/theme/light_theme_colors.dart';

class CurrentAffairsContentView extends StatelessWidget {
  const CurrentAffairsContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CurrentAffairsController());
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = controller.model.value.currentAffairs?.data ?? [];

        if (items.isEmpty) {
          return const Center(child: Text('No Data Found'));
        }

        return ListView.builder(
          itemCount: items.length + 1, // +1 because we want to show "Load More" button after last item
          itemBuilder: (context, index) {
            if (index == items.length) {
              // Last index => Load More Button
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

            // Normal Data Row
            final data = items[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.arrow_forward, size: 22.0),
                      const SizedBox(width: 5),
                      Expanded(
                        child: HtmlWidget(
                          data.title ?? "",
                          textStyle: AppTextStyles.heading5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Answer Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("উত্তর :", style: AppTextStyles.heading5),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: data.options?.where((option) => option.isCorrect == true).map((option) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: HtmlWidget(
                                option.value ?? "",
                                textStyle: AppTextStyles.body1,
                              ),
                            );
                          }).toList() ?? [],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
