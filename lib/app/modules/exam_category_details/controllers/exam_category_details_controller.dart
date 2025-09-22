import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/exam_category/models/exam_categories_model.dart';
import 'package:lokkha/app/modules/exam_category_details/models/exam_category_details_model.dart';

import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';

class ExamCategoryDetailsController extends GetxController {
  late final int categoryId;
  @override
  void onInit() {
    super.onInit();
    categoryId = Get.arguments["category_id"] as int;
    fetchExamCategoryDetails(categoryId);
    fetchExamCategoriesWithParentID(categoryId);
  }

  final model = ExamCategoryDetailsModel().obs;
  final apiCallStatus = ApiCallStatus.holding.obs;
  Future<void> fetchExamCategoryDetails(int categoryId) async {
    apiCallStatus.value = ApiCallStatus.loading;
    try {
      final url = "${AppConstants.examsCategory}/$categoryId";
      await BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
        if (response.data['status']) {
          model.value = ExamCategoryDetailsModel.fromJson(response.data);
          apiCallStatus.value = ApiCallStatus.success;
        } else {
          apiCallStatus.value = ApiCallStatus.error;
        }
      }, onError: (err) {
        apiCallStatus.value = ApiCallStatus.error;
        debugPrint("error from fetchExamCategoryDetails $err");
      });
    } catch (e) {
      apiCallStatus.value = ApiCallStatus.error;
    }
  }

  // With parent ID
  final examCategoriesModel = ExamCategoriesModel().obs;
  final apiCallCategoriesStatus = ApiCallStatus.holding.obs;
  Future<void> fetchExamCategoriesWithParentID(int parentID) async {
    apiCallCategoriesStatus.value = ApiCallStatus.loading;
    try {
      final url = "${AppConstants.examsCategories}?parent_id=$parentID";
      await BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
        if (response.data['status']) {
          examCategoriesModel.value =
              ExamCategoriesModel.fromJson(response.data);
          apiCallCategoriesStatus.value = ApiCallStatus.success;
        } else {
          apiCallCategoriesStatus.value = ApiCallStatus.error;
        }
      }, onError: (err) {
        apiCallCategoriesStatus.value = ApiCallStatus.error;
        debugPrint("error from fetchExamCategories $err");
      });
    } catch (e) {
      apiCallStatus.value = ApiCallStatus.error;
    }
  }







}
