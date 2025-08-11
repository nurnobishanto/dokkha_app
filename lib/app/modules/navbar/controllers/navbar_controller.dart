import 'package:lokkha/app/data/local/my_get_storage.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/model_test/views/model_test_view.dart';
import 'package:lokkha/app/modules/profile_module/profile/views/profile_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lokkha/app/modules/premium_packages/views/premium_packages_view.dart';
import '../../../../utils/constants.dart';
import '../../../helper/global.dart';
import '../../../models/user.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../nav_bar_views/home/views/home_view.dart';
import '../../premium_packages/controllers/premium_packages_controller.dart';
import '../../profile_module/profile/controllers/profile_controller.dart';
import '../model/profile_data_model.dart';

class NavbarController extends GetxController {
  int currentIndex = 0;

  final List<Widget> nabBarBody = [
    const HomeView(),
    const ModelTestView(),
    const PremiumPackagesView(),
    const ProfileView(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  ///  Rx nullable
  Rxn<ProfileDataModel> profileDataModel = Rxn<ProfileDataModel>();
  Rx<ApiCallStatus> getProfileApiStatus = ApiCallStatus.holding.obs;
  Future<void> getMeProfileInfo() async {
    debugPrint(" Called Get Me Profile Information");
    final token = MySharedPref.getUserToken();
    if (token.isEmpty) {
      debugPrint("❌ Token is empty, skipping profile fetch.");
      clearProfileState(); // optionally clear previous data
      return;
    }
    getProfileApiStatus.value = ApiCallStatus.loading;
    var url = AppConstants.me;

    await BaseClient.safeApiCall(
      url,
      RequestType.post,
      headers: {'Authorization': 'Bearer $token'},
      onSuccess: (response) {
        final isSuccess = response.data['status'] == true;
        getProfileApiStatus.value = ApiCallStatus.success;
        if (isSuccess) {
          profileDataModel.value = ProfileDataModel.fromJson(response.data);
          MyGetStorage.writeCacheData(
              MyGetStorage.meUser, profileDataModel.value!.user);
          myUser = profileDataModel.value!.user!;
          isLoggedIn.value = true;
          debugPrint("✅ Profile Data fetch Success");
          debugPrint(myUser.name);
        } else {
          debugPrint("⚠️ Profile fetch failed: API status false");
          clearProfileState();
        }
      },
      onError: (error) {
        getProfileApiStatus.value = ApiCallStatus.error;
        debugPrint("❌ Profile Fetch Error: $error");
        clearProfileState();
      },
    );
  }

  void clearProfileState() {
    isLoggedIn.value = false;
    profileDataModel.value = null;
    MyGetStorage.removeCache(MyGetStorage.meUser);
    myUser = User();
    MySharedPref.removeUserToken(); // optional
  }

  @override
  void onInit() {
    // Manually bind dependent controllers
    // Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => PremiumPackagesController());
    //Get.lazyPut(() => ProfileController());
    getMeProfileInfo();
    super.onInit();
  }
}
