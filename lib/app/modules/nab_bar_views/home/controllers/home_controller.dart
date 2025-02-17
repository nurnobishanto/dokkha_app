import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class HomeController extends GetxController {
  int dotsCount = 0;
  double currentPosition = 0;

  final List<String> gridViewTitle = [
    'প্রশ্ন ব্যাংক',
    'মক পরীক্ষা',
    'আজকের পরীক্ষা',
    'চাকরির আপডেট',
    'আজকের বিশ্ব',
    'নোটিশ বোর্ড',
  ];

  final List<String> gridViewRoutePage = [
     Routes.QUESTION_BANK,
     Routes.MOCK_TEST,
     Routes.AJKER_PORIKKHA,
     Routes.JOBS_UPDATE,
     Routes.AJKER_BISSHO,
     Routes.NOTICE_BOARD,
  ];

  List<String> sliderImages = [
    "seamless_pattern.png",
    "seamless_pattern.png",
    "seamless_pattern.png",
    "seamless_pattern.png",
  ];

  List<String> gridImages = [
    "question_bank.png",
    "mock_exam.png",
    "today_exam.png",
    "job_update.png",
    "today_world.png",
    "notice_board.png",
  ];
  final List<Color> gridColors = [
    const Color(0xFFDFEBDA),
    const Color(0xfffad4cd),
    const Color(0xFFEAD3EE),
    const Color(0xFFD8DBEF),
    const Color(0xFFCBF0F4),
    const Color(0x6B9A9EF4),
  ];
}
