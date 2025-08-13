import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/custom_app_bar.dart';
import '../../../../services/api_call_status.dart';
import '../../components/exam_card.dart';
import '../../views/exam_overview.dart';
import '../controllers/model_test_details_controller.dart';

class ModelTestDetailsView extends GetView<ModelTestDetailsController> {
  const ModelTestDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "প্রশ্ন সমূহ"),
      body: GetBuilder<ModelTestDetailsController>(
        builder: (controller) {
          switch (controller.apiCallStatus) {
            case ApiCallStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case ApiCallStatus.success:
              final exams = controller.model.value!.modelTest!.exams ?? [];
              print("Ad: $exams"); // from the existing controller
              if (exams.isEmpty) {
                return const Center(child: Text('কোনো ডাটা পাওয়া যায়নি'));
              }
              return ListView.builder(
                itemCount: exams.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return ExamCard(
                    onTap: () {
                      Get.to(
                        ExamOverview(exam: exams[index]),
                      );
                    },
                    exam: exams[index],
                  );
                },
              );
            case ApiCallStatus.empty:
              return const Center(child: Text("No exams found."));
            case ApiCallStatus.error:
              return const Center(child: Text("Failed to load data."));
            case ApiCallStatus.holding:
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
