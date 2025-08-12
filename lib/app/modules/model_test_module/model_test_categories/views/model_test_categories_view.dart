import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../services/api_call_status.dart';
import '../../components/model_test_card.dart';
import '../../views/model_test_details_view.dart';
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
      body: GetBuilder<ModelTestCategoriesController>(
        init:ModelTestCategoriesController() ,
        builder: (controller) {
          switch (controller.apiCallStatus.value) {
            case ApiCallStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case ApiCallStatus.success:
              final items = controller.modelTestList.value?.data ?? [];
              if (items.isEmpty) {
                return const Center(child: Text('কোনো ডাটা পাওয়া যায়নি'));
              }
              return Column(
                children: [
                  ...items.map((model) => Text(model.name.toString())),
                  // GridView.builder(
                  //   padding: EdgeInsets.all(8.w),
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 7.w,
                  //     mainAxisSpacing: 8.h,
                  //     childAspectRatio: 1.10,
                  //   ),
                  //   itemCount: items.length,
                  //   itemBuilder: (_, index) {
                  //     final data = items[index];
                  //     return ModelTestCard(
                  //       imageUrl: AppConstants.storageUrl +
                  //           (data.image ?? '').toString(),
                  //       title: data.name ?? '',
                  //       examCount: '0',
                  //       onTap: () {
                  //         final int? id = data.id is int
                  //             ? data.id
                  //             : int.tryParse(data.id.toString());
                  //         if (id != null) {
                  //           Get.to(() => ModelTestDetailsView(id: id));
                  //
                  //           // Get.toNamed(Routes.modelTestDetails, arguments: {"id": id});
                  //         } else {
                  //           Get.snackbar("Error", "Invalid exam ID");
                  //         }
                  //       },
                  //     );
                  //   },
                  // ),
                ],
              );

            case ApiCallStatus.error:
              return const Center(child: Text('Something went wrong'));

            case ApiCallStatus.holding:
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
