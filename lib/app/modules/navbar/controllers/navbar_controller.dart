import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/profile_module/profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lokkha/app/modules/premium_packages/views/premium_packages_view.dart';
import '../../../../comming_soon_view.dart';
import '../../../helper/api_helper.dart';
import '../../../helper/global.dart';
import '../../auth_views/auth_gateway/views/auth_gateway_view.dart';
import '../../nav_bar_views/home/views/home_view.dart';

class NavbarController extends GetxController {
  int currentIndex = 0; // Not using Rx because GetBuilder is used
  bool isLoading = true;

  bool showProfile =
      !(MySharedPref.getUserToken().isEmpty && !isLoggedIn.value);
  late List<Widget> nabBarBody = [
    const HomeView(),
    const ComingSoonPage(),
    const PremiumPackagesView(),
    const AuthGatewayView(),
  ];

  // final List nabBarBody = [
  //    Routes.HOME,
  //    Routes.BLOG,
  //    Routes.PREMIUM_PACKAGES,
  //    Routes.PROFILE,
  // ];

  void changeIndex(int index) {
    currentIndex = index;
    update(); // Notify UI to refresh
  }

  @override
  void onInit() {
    showProfile = !(MySharedPref.getUserToken().isEmpty && !isLoggedIn.value);
    getMeProfileInfo().then((w) {
      if (showProfile) {
        nabBarBody = [
          const HomeView(),
          const ComingSoonPage(),
          const PremiumPackagesView(),
          const ProfileView(),
        ];
      }
    });

    super.onInit();
  }
}
