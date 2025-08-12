import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lokkha/utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../components/model_test_card.dart';
import '../controllers/model_test_controller.dart';
import 'model_test_details_view.dart';

class ModelTestView extends GetView<ModelTestController> {
  const ModelTestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ModelTestController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('মডেল টেস্ট'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.fetchModelTests();
        },
        child: Obx(() {
          switch (controller.apiCallStatus.value) {
            case ApiCallStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case ApiCallStatus.success:
              return GridView.builder(
                padding: EdgeInsets.all(8.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 7.w,
                  mainAxisSpacing: 8.h,
                  childAspectRatio: 1.10,
                ),
                itemCount:
                    controller.modelTestList.value?.data?.data?.length ?? 0,
                itemBuilder: (_, index) {
                  final data =
                      controller.modelTestList.value?.data?.data?[index];
                  return ModelTestCard(
                    imageUrl: AppConstants.storageUrl + data!.image.toString(),
                    title: data.title ?? '',
                    onTap: () {
                      final int? id = data.id is int
                          ? data.id
                          : int.tryParse(data.id.toString());
                      if (id != null) {
                        Get.to(ModelTestDetailsView(id: id));
                      } else {
                        Get.snackbar("Error", "Invalid exam ID");
                      }
                    },
                    examCount: data.exams!.length.toString(),
                  );
                },
              );

            case ApiCallStatus.error:
              return const Center(child: Text('Something went wrong'));

            case ApiCallStatus.holding:
            default:
              return const SizedBox();
          }
        }),
      ),
    );
  }
}
