import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/modules/model_test/controllers/model_test_controller.dart';
import 'package:lokkha/app/modules/model_test/views/exam_overview.dart';
import '../../../services/api_call_status.dart';
import '../components/exam_card.dart';

class ModelTestDetailsView extends StatelessWidget {
  final int id;
  const ModelTestDetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ModelTestController());
    controller.fetchSingleModelTest(id);

    return Scaffold(
      appBar: const CustomAppBar(title: "প্রশ্ন সমূহ"),
      body: Obx(() {
        switch (controller.singleModelApiCallStatus.value) {
          case ApiCallStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiCallStatus.success:
            final exams = controller.singleModelTest.value!.modelTest!.exams!;
            return ListView.builder(
                itemCount: exams.length,
                itemBuilder: (_, index) {
                  return ExamCard(
                    onTap: () {
                      Get.to(
                        ExamOverview(
                          exam: exams[index],
                        ),
                      );
                    },
                    exam: exams[index],
                  );
                });
          case ApiCallStatus.empty:
            return const Center(child: Text("No exams found."));
          case ApiCallStatus.error:
            return const Center(child: Text("Failed to load data."));
          case ApiCallStatus.holding:
          default:
            return const SizedBox(); // Default empty state
        }
      }),
    );
  }
}
