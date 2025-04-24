import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/services/home_api_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';
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
    'সর্বশেষ সাবজেক্ট অনুযায়ী তথ্যাদি',
    'সাবজেক্ট অনুযায়ী পরীক্ষা',
    'সাবজেক্ট অনুযায়ী চাকরির নিয়োগ',
  ];
  final List<String> gridViewTitle2 = [
    'বিসিএস',
    'ব্যাংক নিয়োগ পরীক্ষা',
    'দপ্তর অনুযায়ী প্রশ্ন সমূহ',
    '৯ম -১০ম গ্রেডের প্রস্তুতি',
    'বিশ্ববিদ্যালয় ভর্তি পরীক্ষার তথ্যাদি',
    'অন্যান্য',
  ];

  final List<String> gridViewRoutePage = [
    Routes.QUESTION_BANK,
    Routes.MOCK_TEST_TAB,
    Routes.AJKER_PORIKKHA,
    // Routes.JOBS_UPDATE,
    // Routes.AJKER_BISSHO,
    // Routes.NOTICE_BOARD,
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

  /// start Timer
  Timer? _timer;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  void startTimer({required int hours}) {
    this.hours = hours;
    minutes = 0;
    seconds = 0;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
      } else if (minutes > 0) {
        minutes--;
        seconds = 59;
      } else if (this.hours > 0) {
        this.hours--;
        minutes = 59;
        seconds = 59;
      } else {
        timer.cancel();
      }
      update();
      print("Called Timer.....${timer.tick} xx");
    });
  }

  final List<int> leaders = List.generate(30, (index) {
    return index + 1;
  });

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }


  final HomeApiService _homeApiService = HomeApiService();
  Rx<ApiCallStatus> get apiCallStatus => _homeApiService.apiCallStatus;
  Rx<SliderModel> get sliderModel => _homeApiService.sliderModel;


  @override
  void onInit() {
    super.onInit();
    _homeApiService.fetchSliders();
  }




}

