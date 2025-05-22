import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/modules/model_test/controllers/model_test_controller.dart';
import 'package:lokkha/app/modules/model_test/models/model_test_list_model.dart';

import '../../../services/api_call_status.dart';

class ModelTestDetailsView extends StatelessWidget {
  final int id;
  const ModelTestDetailsView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ModelTestController());
    controller.fetchSingleModelTest(id);

    return Scaffold(
      appBar: const CustomAppBar(title: "Model Test Details"),
      body: Obx(() {
        switch (controller.singleModelApiCallStatus.value) {
          case ApiCallStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case ApiCallStatus.success:
            final exams = controller.singleModelTest.value!.modelTest!.exams!;
            return ListView.builder(
              itemCount: exams.length,
              itemBuilder: (_, index) => ExamCard(examData: exams[index]),
            );
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

class ExamCard extends StatelessWidget {
  final ExamData? examData;

  const ExamCard({
    super.key,
    required this.examData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Exam title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  examData?.exam?.name ?? '',
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: examData!.isFree!
                    ? Text(
                        "Free",
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Icon(
                        Icons.lock_outline,
                        color: Colors.grey.shade600,
                        size: 18,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          /// Duration
          Row(
            children: [
              const Icon(Icons.timer, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text("${examData!.exam!.duration} minutes"),
            ],
          ),
        ],
      ),
    );
  }
}
