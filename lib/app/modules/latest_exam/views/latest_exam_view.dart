import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/modules/latest_exam/views/latest_exam_start_view.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:lokkha/utils/date_formatter.dart';

import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/latest_exam_controller.dart';


class LatestExamView extends GetView<LatestExamController> {
  const LatestExamView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LatestExamController());
    return Scaffold(
      appBar: const CustomAppBar(title: 'সর্বশেষ নিয়োগ পরীক্ষা'),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount:
                      controller.model.value.latestExams?.data?.length ?? 0,
                  itemBuilder: (c, index) {
                    final data =
                        controller.model.value.latestExams?.data![index];
                    return LatestExamCard(
                      title: data?.title ?? '',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (x) =>
                              LatestExamStartDialog(latestExam: data),
                        );
                      },
                      date: data!.date,
                    );
                  }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 8),
                ),
              );
      }),
    );
  }
}

class LatestExamCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final void Function()? onTap;

  const LatestExamCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.height / 12,
        decoration: BoxDecoration(
          color: LightThemeColors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: AppTextStyles.heading5,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4.00),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.circular(4.0.r), // rounded corners
                    ),
                    child: Text(
                      DateFormatter.formatToDMY(date),
                      style: AppTextStyles.body1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  8.0.width,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          BorderRadius.circular(4.0.r), // rounded corners
                    ),
                    child: Text(
                      'MCQ',
                      style: AppTextStyles.body1.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
