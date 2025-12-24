import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/models/get_subjects.dart';
import 'package:lokkha/app/models/subject_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

class MockTestController extends GetxController {
  final Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.holding.obs;
  final Rx<GetSubjectsModel> model = GetSubjectsModel().obs;

  Future<void> getRootSubjects() async {
    apiCallStatus.value = ApiCallStatus.loading;
    debugPrint("Fetching subjects...");
    String url = AppConstants.getSubjects;

    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      onSuccess: (response) {
        model.value = GetSubjectsModel.fromJson(response.data);
        apiCallStatus.value = ApiCallStatus.success;
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
        debugPrint("Error fetching subjects: ${error.message}");
      },
    );
  }

  @override
  void onInit() {
    getRootSubjects();
    super.onInit();
  }
}
