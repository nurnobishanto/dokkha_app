import 'package:lokkha/app/modules/nav_bar_views/profile_module/profile_history/views/profile_history_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../nav_bar_views/blog/views/blog_view.dart';
import '../../nav_bar_views/contest/views/contest_view.dart';
import '../../nav_bar_views/home/views/home_view.dart';
import '../../nav_bar_views/question_bank/views/question_bank_view.dart';

class NavbarController extends GetxController {
  int currentIndex = 0; // Not using Rx because GetBuilder is used

  final List<Widget> nabBarBody = [
   const HomeView(),
   const QuestionBankView(),
   const ContestView(),
   const BlogView(),
   const ProfileHistoryView(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update(); // Notify UI to refresh
  }
}
