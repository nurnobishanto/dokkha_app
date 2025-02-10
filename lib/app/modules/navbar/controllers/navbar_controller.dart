import 'package:dokkha/app/modules/blog/views/blog_view.dart';
import 'package:dokkha/app/modules/contest/views/contest_view.dart';
import 'package:dokkha/app/modules/home/views/home_view.dart';
import 'package:dokkha/app/modules/profile/views/profile_view.dart';
import 'package:dokkha/app/modules/question_bank/views/question_bank_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavbarController extends GetxController {
  int currentIndex = 0; // Not using Rx because GetBuilder is used

  final List<Widget> nabBarBody = [
   const HomeView(),
   const QuestionBankView(),
   const ContestView(),
   const BlogView(),
   const ProfileView(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update(); // Notify UI to refresh
  }
}
