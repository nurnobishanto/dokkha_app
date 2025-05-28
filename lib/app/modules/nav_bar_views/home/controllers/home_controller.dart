import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/contest/controller/latest_contest_controller.dart';
import 'package:lokkha/app/modules/current_affairs/views/current_affairs_view.dart';
import 'package:lokkha/app/modules/grid_views/jobs/views/jobs_view.dart';
import 'package:lokkha/app/modules/latest_exam/views/latest_exam_view.dart';
import 'package:lokkha/app/modules/lecture_sheet/views/lecture_sheet_view.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/models/subject_sections_model.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/services/home_api_service.dart';
import 'package:lokkha/app/modules/vocabulary/views/vocabulary_view.dart';
import 'package:lokkha/comming_soon_view.dart';
import '../../../../services/api_call_status.dart';
import '../../../grid_views/mock_test_tab/views/mock_test_tab_view.dart';
import '../models/slider_model.dart';

class HomeController extends GetxController {
  int dotsCount = 0;

  final List<String> gridViewTitle = [
    'বিষয়ভিত্তিক পরীক্ষা',
    'কারেন্ট এ্যাফেয়ার্স',
    'সর্বশেষ নিয়োগ বিজ্ঞপ্তি',
    'সর্বশেষ নিয়োগ পরীক্ষা',
    'Vocabulary',
    'Lecture sheet',
  ];

  final List gridViewRoutePage = [
    const MockTestTabView(),
    const CurrentAffairsView(),
    const JobsView(),
    const LatestExamView(),
    const VocabularyView(),
     LectureSheetView(),
  ];

  final HomeApiService homeApiService = HomeApiService();
  Rx<ApiCallStatus> get sliderApiStatus => homeApiService.sliderApiStatus;
  Rx<ApiCallStatus> get subjectSectionApiStatus =>
      homeApiService.subjectSectionApiStatus;
  Rx<SliderModel> get sliderModel => homeApiService.sliderModel;
  Rx<SubjectSectionModel> get subjectSectionModel =>
      homeApiService.subjectSectionModel;

  @override
  void onInit() {
    super.onInit();
    debugPrint("HomeController Initialized");
    homeApiService.fetchSliders();
    homeApiService.fetchSubjectSection();
  }

  Future<void> refreshHomeViewData() async {
    await homeApiService.fetchSliders();
    await homeApiService.fetchSubjectSection();
    await Get.find<LatestContestController>().fetchContest();
    await Get.find<LatestContestController>().fetchContestResult();
    await Get.find<LatestContestController>().fetchAllContest().then((_)=> print("Called fetchAll Contest"));
    print("Called fetchAll Contest2");
    update(); // for ui update
  }
}
