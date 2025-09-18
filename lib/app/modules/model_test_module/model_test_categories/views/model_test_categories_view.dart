import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';
import '../../components/model_test_categories_card.dart';
import '../controllers/model_test_categories_controller.dart';

class ModelTestCategoriesView extends GetView<ModelTestCategoriesController> {
  const ModelTestCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('মডেল টেস্ট'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return controller.fetchCategoriesModelTests();
        },
        child: GetBuilder<ModelTestCategoriesController>(
          init: ModelTestCategoriesController(),
          builder: (controller) {
            switch (controller.apiCallStatus.value) {
              case ApiCallStatus.loading:
                return const Center(child: CircularProgressIndicator());

              case ApiCallStatus.success:
                final items = controller.modelTestList.value?.data ?? [];
                if (items.isEmpty) {
                  return const Center(child: Text('কোনো ডাটা পাওয়া যায়নি'));
                }
                return ListView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.5.h),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final data = items[index];
                    return ModelTestCategoryCard(
                      categoryTitle: data.name ?? "",
                      imageUrl: AppConstants.storageUrl +
                          (data.image ?? '').toString(),
                      description: data.description ?? "",
                      onTap: () {
                        final int? id = data.id is int
                            ? data.id
                            : int.tryParse(data.id.toString());
                        if (id != null) {
                          Get.toNamed(
                            Routes.MODEL_TEST_DETAILS,
                            arguments: {"id": id},
                          );
                        } else {
                          Get.snackbar("Error", "Invalid exam ID");
                        }
                      },
                    );
                  },
                );

              case ApiCallStatus.error:
                return const Center(child: Text('Something went wrong'));

              case ApiCallStatus.holding:
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
