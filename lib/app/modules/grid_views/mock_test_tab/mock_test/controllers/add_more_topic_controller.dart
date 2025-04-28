import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/local/my_shared_pref.dart';
import '../../../../../models/mock_subject_select_model.dart';



class AddMoreTopicController extends GetxController{

  RxList<MockSubjectSelect> selectedSubjects = <MockSubjectSelect>[].obs;

  Future<void> getSubjects() async {
    List<MockSubjectSelect> fetchedSubjects = await MySharedPref.getMockSubjects();
    selectedSubjects.assignAll(fetchedSubjects);
  }

  @override
  void onInit() {
    super.onInit();
    getSubjects();
  }

}