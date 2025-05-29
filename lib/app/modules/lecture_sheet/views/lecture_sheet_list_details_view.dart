import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/helper/api_helper.dart';
import 'package:lokkha/app/modules/lecture_sheet/components/title_description_card.dart';
import 'package:lokkha/app/modules/lecture_sheet/controllers/lecture_sheet_list_details_controller.dart';
import '../../../services/api_call_status.dart';


class LectureSheetListDetailsView extends StatelessWidget {
  final int id;
  const LectureSheetListDetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LectureSheetListDetailsController());
    controller.setCategoryId(id);

    return Scaffold(
      appBar: CustomAppBar(title: "Lecture Sheet Details"),
      body: Obx(() {
        switch (controller.apiCallStatus.value) {
          case ApiCallStatus.loading:
            return const Center(child: CircularProgressIndicator());

          case ApiCallStatus.success:
            final model = controller.detailsModel.value;
            if (model == null) return const Center(child: Text("No Data Found"));

            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  /// Name
                  Text(
                    model.category?.name ?? '',
                    style: Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  /// Description
                  Text(
                    model.category?.description ?? '',
                    style: Get.textTheme.bodyMedium?.copyWith(height: 1.5),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  /// Sheet Count
                  Row(
                    children: [
                      const Icon(Icons.insert_drive_file_rounded, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "Total Sheets: ${model.category?.lecturesheetsCount ?? 0}",
                        style: Get.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// List of Sheets
                  ...controller.lectureSheets.map((sheet) => TitleDescriptionCard(
                    title: sheet.name ?? '',
                    description: sheet.description ?? '',
                  )),
                ],
              ),
            );
          case ApiCallStatus.error:
            return const Center(child: Text("Something went wrong"));
          case ApiCallStatus.holding:
          default:
            return const SizedBox();
        }
      }),
    );
  }
}
