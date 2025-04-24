import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/mock_test/models/mock_start_exam_model.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/utils.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../helper/global.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';
import '../models/mock_subject_select_model.dart';
import '../views/question_view.dart';

class MockTestSetTimeController extends GetxController {
  RxBool isNegativeMarkChecked = false.obs;
  RxBool isStartExam = false.obs;
  RxBool isSetTime = false.obs;
  RxBool isChecked = false.obs;
  final RxBool isLoading = false.obs;
  final TextEditingController setTimeCon = TextEditingController();

  final RxMap<String, String> questionType = {
    "random": "রেনডম প্রশ্ন",
    "unanswered": "উত্তর না দেওয়া প্রশ্ন",
    "answered": "উত্তর দেওয়া প্রশ্ন",
    "wrong": 'ভুল উত্তর দেওয়া প্রশ্ন',
    "corrected": 'সঠিক উত্তর দেওয়া প্রশ্ন',
    "favorite": 'ফেভারিট প্রশ্ন',
  }.obs;

  // RxString to store the selected key (the key will be used for further logic)
  final RxString selectedKey = "random".obs;

  RxString dropdownValue = "random".obs;
  RxList<MockSubjectSelect> selectedSubjects = <MockSubjectSelect>[].obs;

  Future<void> getSubjects() async {
    List<MockSubjectSelect> fetchedSubjects =
        await MySharedPref.getMockSubjects();
    selectedSubjects.assignAll(fetchedSubjects);
  }

  final TextEditingController passwordController = TextEditingController();
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  RxObjectMixin model = MockStartExamModel().obs;

  /// login method
  Future<void> testExamStart() async {
    String? token = MySharedPref.getUserToken();
    if (token == '' || token.isEmpty) return;
    Map<String, dynamic> data = {
      'negative_mark': isNegativeMarkChecked.value,
      'is_set_time': isSetTime.value,
      'type': selectedKey.value,
      'duration': int.tryParse(setTimeCon.text) ?? 0,
      'subjects': selectedSubjects
          .map((subject) => subject.toMap())
          .toList(), // Convert each subject to map
    };
    await BaseClient.safeApiCall(
      AppConstants.testExamStart,
      RequestType.post,
      data: data,
      headers: {
        "Authorization": 'Bearer $token',
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;
        if (response.data['status']) {
          log("Called Success MOCK EXAM");
          isLoading.value = false;
          MockStartExamModel data = MockStartExamModel.fromJson(response.data);
          model.value = data;
          Get.to(MockExamQuestionScreen(
            mockExamStartModel: model.value,
          ));
          log("My Mock EXam Data: ${data.startTime.toString()}");
        } else if (response.data["status"] == false &&
            response.data.containsKey('errors')) {
          response.data['errors'].forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              CustomSnackBar.showCustomToast(
                message: value[0].toString(),
              ); // first error message
            }
          });
        }

        update();
        debugPrint("Login successfully: ${response.data}");
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        update();
        debugPrint("Error login: ${error.message}");
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
        debugPrint("Logging...");
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    getSubjects();
  }

  @override
  void onClose() {
    setTimeCon.dispose();
    super.onClose();
  }
}
