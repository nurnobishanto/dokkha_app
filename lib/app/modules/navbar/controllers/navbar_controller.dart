import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/nav_bar_views/profile_module/profile_history/views/profile_history_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../comming_soon_view.dart';
import '../../../helper/api_helper.dart';
import '../../grid_views/mock_test_tab/mock_test/views/mock_test_view.dart';
import '../../nav_bar_views/blog/views/blog_view.dart';
import '../../nav_bar_views/contest/views/contest_view.dart';
import '../../nav_bar_views/home/views/home_view.dart';
import '../../nav_bar_views/question_bank/views/question_bank_view.dart';
import '../model/profile_data_model.dart';
import '../views/navbar_view.dart';

class NavbarController extends GetxController {
  int currentIndex = 0; // Not using Rx because GetBuilder is used
  bool isLoading = true;
  final List<Widget> nabBarBody = [
    const HomeView(),
    // const QuestionBankView(),
    // const MockTestView(),
    // const BlogView(),
    // const ProfileHistoryView(),
    const ComingSoonPage(),
    const ComingSoonPage(),
    const ComingSoonPage(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update(); // Notify UI to refresh
  }

  @override
  void onReady() {
    getMeProfileInfo();
    super.onReady();
  }

  @override
  void onInit() {
    // handleInitialUri();
    super.onInit();
  }
}
