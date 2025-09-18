import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/exam_category/models/exam_categories_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../../../utils/constants.dart';

class ExamCategoryController extends GetxController {
  final model = ExamCategoriesModel().obs;
  final apiCallStatus = ApiCallStatus.holding.obs;

  Future<void> fetchExamCategories() async {
    apiCallStatus.value = ApiCallStatus.loading;
    try {
      final url = AppConstants.examsCategories;
      await BaseClient.safeApiCall(
        url,
        RequestType.get,
        onSuccess: (response) {
          if (response.data['status']) {
            model.value = ExamCategoriesModel.fromJson(response.data);
            apiCallStatus.value = ApiCallStatus.success;
          } else {
            apiCallStatus.value = ApiCallStatus.error;
          }
        },
        onError: (err) {
          apiCallStatus.value = ApiCallStatus.error;
          debugPrint("error from fetchExamCategories $err");
        },
      );
    } catch (e) {
      apiCallStatus.value = ApiCallStatus.error;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchExamCategories();
  }
}
