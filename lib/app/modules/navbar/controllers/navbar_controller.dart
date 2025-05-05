import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/profile_module/profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lokkha/app/modules/premium_packages/views/premium_packages_view.dart';
import '../../../../comming_soon_view.dart';
import '../../../../utils/constants.dart';
import '../../../helper/api_helper.dart';
import '../../../helper/global.dart';
import '../../../routes/app_pages.dart';
import '../../../services/base_client.dart';
import '../../auth_views/auth_gateway/views/auth_gateway_view.dart';
import '../../grid_views/mock_test_tab/views/mock_test_tab_view.dart';
import '../../nav_bar_views/home/controllers/home_controller.dart';
import '../../nav_bar_views/home/views/home_view.dart';
import '../../premium_packages/controllers/premium_packages_controller.dart';
import '../../profile_module/profile/controllers/profile_controller.dart';
import '../model/profile_data_model.dart';

class NavbarController extends GetxController {
  int currentIndex = 0;

  final List<Widget> nabBarBody = [
    const HomeView(),
    const MockTestTabView(),
    const PremiumPackagesView(),
    const ProfileView(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  @override
  void onInit() {
    // Manually bind dependent controllers
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => PremiumPackagesController());
    getMeProfileInfo();
    super.onInit();
  }
}
