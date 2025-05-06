import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/latest_test/models/start_exam_model.dart';
import 'package:lokkha/app/modules/subject_sections/models/sub_sec_select_model.dart';
import 'package:lokkha/app/modules/subject_sections/views/read_question.dart';
import '../../../../../utils/constants.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../grid_views/latest_test/views/question_view.dart';


class SubSecSetTimeController extends GetxController {
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
  RxList<SubjectSectionSelect> selectedSubjects = <SubjectSectionSelect>[].obs;
  //
  Future<void> getSubjects() async {
    List<SubjectSectionSelect> fetchedSubjects =
    await MySharedPref.getSubjectSection();
    selectedSubjects.assignAll(fetchedSubjects);
  }

  final TextEditingController passwordController = TextEditingController();
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  RxObjectMixin model = StartExamModel().obs;

  ///  method
  Future<void> testExamStart(String type) async {

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
          log("Called Success ");
          isLoading.value = false;
          StartExamModel data = StartExamModel.fromJson(response.data);
          model.value = data;
          log("messages");
          if(type == 'exam'){
            Get.to(ExamQuestionScreen(
              examStartModel: model.value,
            ));
          }else{
            Get.to(ReadQuestionView(
              model: model.value,
            ));
          }

          log("My EXam Data: ${data.startTime.toString()}");
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
        debugPrint(" successfully: ${response.data}");
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

}
