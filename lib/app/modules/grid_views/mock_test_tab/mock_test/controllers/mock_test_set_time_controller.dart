import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/models/start_exam_model.dart';
import 'package:lokkha/app/views/views/exam_process_view.dart';
import '../../../../../../utils/constants.dart';
import '../../../../../components/custom_snackbar.dart';
import '../../../../../data/local/my_shared_pref.dart';
import '../../../../../services/api_call_status.dart';
import '../../../../../services/base_client.dart';
import '../../../../../models/mock_subject_select_model.dart';


class MockTestSetTimeController extends GetxController {
  RxBool isNegativeMarkChecked = false.obs;
  RxBool isStartExam = false.obs;
  RxBool isSetTime = false.obs;
  RxBool isChecked = false.obs;
  final RxBool isLoading = false.obs;
  final TextEditingController setTimeCon = TextEditingController();
  final TextEditingController dayController = TextEditingController(text: '15');

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
  RxObjectMixin model = StartExamModel().obs;

  ///
  Future<void> testExamStart() async {
    String? token = MySharedPref.getUserToken();
    if (token == '' || token.isEmpty) return;

    final bool isSetTimeValue = isSetTime.value;
    final int durationValue = int.tryParse(setTimeCon.text) ?? 0;
    final int finalDuration = isSetTimeValue ? (durationValue < 1 ? 1 : durationValue) : 0;

    Map<String, dynamic> data = {
      'exam_name':'Mock Test',
      'negative_mark': isNegativeMarkChecked.value?0.25:0,
      'is_negative_mark': isNegativeMarkChecked.value,
      'is_set_time': isSetTime.value,
      'type': selectedKey.value,
      'duration': finalDuration,
      'previous_day_count': (dayController.text == '' || dayController.text.isEmpty)? 0: dayController.text,
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
          StartExamModel data = StartExamModel.fromJson(response.data);
          model.value = data;
          Get.to(ExamProcessView(examStartModel: data));
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
        debugPrint("data fetch successfully: ${response.data}");
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        update();
        debugPrint("Error mock test set time controller: ${error.message}");
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
