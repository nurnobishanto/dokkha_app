
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/jobs/views/jobs_view.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/models/subject_sections_model.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/services/home_api_service.dart';
import 'package:lokkha/comming_soon_view.dart';
import '../../../../services/api_call_status.dart';
import '../../../grid_views/mock_test_tab/views/mock_test_tab_view.dart';
import '../models/slider_model.dart';

class HomeController extends GetxController {
  int dotsCount = 0;



  final List<String> gridViewTitle = [
    //'সর্বশেষ সাবজেক্ট অনুযায়ী তথ্যাদি',
    'বিষয়ভিত্তিক পরীক্ষা',
    'সর্বশেষ নিয়োগ বিজ্ঞপ্তি',
  ];
  final List<String> gridViewTitle2 = [
    'বিসিএস',
    'ব্যাংক নিয়োগ পরীক্ষা',
    'শিক্ষক নিয়োগ ও নিবন্ধন',
    'বিশ্ববিদ্যালয় ভর্তি পরীক্ষা',
    'ববার কাউন্সিল ও বিজেএস',
    'অন্যান্য',
  ];
  final List<Widget?> gridViewRoutePages2s = [
    const ComingSoonPage(),
    const ComingSoonPage(),
    const ComingSoonPage(),
    const ComingSoonPage(),
    const ComingSoonPage(),
    const ComingSoonPage(),
  ];


  final List gridViewRoutePage = [
    const MockTestTabView(),
    const JobsView(),
  ];



  final HomeApiService _homeApiService = HomeApiService();
  Rx<ApiCallStatus> get sliderApiStatus => _homeApiService.sliderApiStatus;
  Rx<ApiCallStatus> get subjectSectionApiStatus => _homeApiService.subjectSectionApiStatus;
  Rx<SliderModel> get sliderModel => _homeApiService.sliderModel;
  Rx<SubjectSectionModel> get subjectSectionModel => _homeApiService.subjectSectionModel;

  @override
  void onInit() {
    super.onInit();
    debugPrint("HomeController Initialized");
    _homeApiService.fetchSliders();
    _homeApiService.fetchSubjectSection();
  }
}
