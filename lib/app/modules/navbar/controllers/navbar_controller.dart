import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/nav_bar_views/profile_module/profile_history/views/profile_history_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';
import '../../nav_bar_views/blog/views/blog_view.dart';
import '../../nav_bar_views/contest/views/contest_view.dart';
import '../../nav_bar_views/home/views/home_view.dart';
import '../../nav_bar_views/question_bank/views/question_bank_view.dart';
import '../model/profile_data_model.dart';

class NavbarController extends GetxController {
  int currentIndex = 0; // Not using Rx because GetBuilder is used
  bool isLoading = true;
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

  RxObjectMixin<ProfileDataModel> profileDataModel = ProfileDataModel().obs;
  Future<void> getMeProfileInfo() async {
    String? token = MySharedPref.getUserToken();
    String url = AppConstants.me;
    await BaseClient.safeApiCall(url, RequestType.post, headers: {
      'Authorization': 'Bearer $token',
    }, onSuccess: (response) {
      if (response.data['status']) {
        ProfileDataModel dataModel = ProfileDataModel.fromJson(response.data);
        profileDataModel.value = dataModel;
        debugPrint("Profile Data fetch Name:${profileDataModel.value.data!.name}");
        debugPrint("Profile Data fetch Success");
      }
    }, onError: (error) {
      debugPrint("Error:$error");
    });
  }

  @override
  void onReady() {
    getMeProfileInfo();
    super.onReady();
  }
}
