import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/jobs/views/jobs_view.dart';
import 'package:lokkha/app/modules/grid_views/latest_test/views/latest_subject_test_view.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/models/subject_sections_model.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/services/home_api_service.dart';
import 'package:lokkha/comming_soon_view.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';
import '../../../grid_views/mock_test_tab/views/mock_test_tab_view.dart';
import '../models/slider_model.dart';

class HomeController extends GetxController {
  int dotsCount = 0;

  double currentPosition = 0;
  int selectedOptionIndex = -1;
  final List<String> randomQuestionOptions = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  final List<String> gridViewTitle = [
    // 'সর্বশেষ সাবজেক্ট অনুযায়ী তথ্যাদি',
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

  // final List<String> gridViewRoutePage = [
  //   Routes.QUESTION_BANK,
  //   Routes.MOCK_TEST_TAB,
  //   Routes.AJKER_PORIKKHA,
  //   // Routes.JOBS_UPDATE,
  //   // Routes.AJKER_BISSHO,
  //   // Routes.NOTICE_BOARD,
  // ];

  final List gridViewRoutePage = [
    // const LatestSubjectTestView(),
    const MockTestTabView(),
    const JobsView(),
  ];

  List<String> gridImages = [
    //"question_bank.png",
    "mock_exam.png",
    "today_exam.png",
    "job_update.png",
    // "today_world.png",
    // "notice_board.png",
  ];

  List<String> gridImages2 = [
    //"question_bank.png",
    "today_world.png",
    "today_world.png",
    "today_world.png",
    "today_world.png",
    "today_world.png",
    "today_world.png",
    // "notice_board.png",
  ];

  final List<Color> gridColors = [
    const Color(0xFFDFEBDA),
    const Color(0xfffad4cd),
    const Color(0xFFEAD3EE),
    // const Color(0xFFD8DBEF),
    // const Color(0xFFCBF0F4),
    // const Color(0x6B9A9EF4),
  ];

  final HomeApiService _homeApiService = HomeApiService();
  Rx<ApiCallStatus> get apiCallStatus => _homeApiService.apiCallStatus;
  Rx<SliderModel> get sliderModel => _homeApiService.sliderModel;
  Rx<SubjectSectionModel> get subjectSectionModel => _homeApiService.subjectSectionModel;

  @override
  void onInit() {
    super.onInit();
    _homeApiService.fetchSliders();
    _homeApiService.fetchSubjectSection();
  }
}
