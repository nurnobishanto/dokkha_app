import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../models/mock_subject_select_model.dart';

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
