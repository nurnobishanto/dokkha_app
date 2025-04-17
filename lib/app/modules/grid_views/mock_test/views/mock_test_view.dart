import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/mock_test/views/topic_selection_view.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';
import '../controllers/mock_test_controller.dart';

class MockTestView extends GetView<MockTestController> {
  const MockTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.apiCallStatus.value) {
          case ApiCallStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiCallStatus.success:
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: List.generate(
                      controller.model.value.subjects?.length ?? 0, (index) {
                    final subject = controller.model.value.subjects![index];
                    return InkWell(
                      onTap: () async {
                        //Get.toNamed(Routes.TOPIC_SELECTION);
                        Get.to(TopicSelectionView(subject: subject));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.00.w, vertical: 8.00.h),
                        decoration: BoxDecoration(
                          color: LightThemeColors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          subject.name.toString(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.paragraph,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          case ApiCallStatus.error:
            return const Center(child: Text("Failed to load data. Try again."));
          case ApiCallStatus.holding:
          default:
            return const SizedBox.shrink();
        }
      }),
    );
  }
}
