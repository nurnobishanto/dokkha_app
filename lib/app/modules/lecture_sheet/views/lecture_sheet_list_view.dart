import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokkha/app/modules/lecture_sheet/views/lecture_sheet_details_view.dart';
import 'package:lokkha/app/modules/lecture_sheet/views/lecture_sheet_list_details_view.dart';

import '../../../services/api_call_status.dart';
import '../controllers/lecture_sheet_list_controller.dart';

class LectureSheetListView extends GetView<LectureSheetListController> {
  const LectureSheetListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LectureSheetListController());
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller
            .fetchSheetListCategories(); // Safe fetch handled in controller
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Lecture Sheets")),
      body: Obx(() {
        if (controller.apiCallStatus.value == ApiCallStatus.loading &&
            controller.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            controller: scrollController,
            itemCount: controller.categories.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final item = controller.categories[index];
              return InkWell(
                onTap: () {
                  Get.to(
                    LectureSheetListDetailsView(
                      id: item.id!.toInt(),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(item.name ?? "No Name"),
                  subtitle: Text("ID: ${item.id}"),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
