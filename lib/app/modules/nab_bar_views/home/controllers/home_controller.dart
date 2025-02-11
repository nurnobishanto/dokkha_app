import 'package:dokkha/app/modules/grid_views/ajker_bissho/views/ajker_bissho_view.dart';
import 'package:dokkha/app/modules/grid_views/ajker_porikkha/views/ajker_porikkha_view.dart';
import 'package:dokkha/app/modules/grid_views/jobs_update/views/jobs_update_view.dart';
import 'package:dokkha/app/modules/grid_views/mock_test/views/mock_test_view.dart';
import 'package:dokkha/app/modules/grid_views/notice_board/views/notice_board_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../question_bank/views/question_bank_view.dart';

class HomeController extends GetxController {
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

  List<String> images = [
    "seamless_pattern.png",
    "seamless_pattern.png",
    "seamless_pattern.png",
    "seamless_pattern.png",
  ];
}
