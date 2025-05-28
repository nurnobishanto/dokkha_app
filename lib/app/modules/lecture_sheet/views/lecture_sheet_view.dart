import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/api_call_status.dart';
import '../controllers/lecture_sheet_controller.dart';

class LectureSheetView extends GetView<LectureSheetController> {
  const LectureSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LectureSheetController());
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.fetchSheetCategories(); // Safe fetch handled in controller
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Lecture Sheets")),
      body: Obx(() {
        if (controller.apiCallStatus.value == ApiCallStatus.loading &&
            controller.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          controller: scrollController,
          itemCount: controller.categories.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final item = controller.categories[index];
            return ListTile(
              title: Text(item.name ?? "No Name"),
              subtitle: Text("ID: ${item.id}"),
            );
          },
        );
      }),
    );
  }
}
