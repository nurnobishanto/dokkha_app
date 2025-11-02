import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_get_storage.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';

import '../helper/global.dart';
import '../../utils/constants.dart';
import '../models/user.dart';
import '../modules/navbar/controllers/navbar_controller.dart';
import '../routes/app_pages.dart';
import 'api_call_status.dart';
import 'base_client.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  /// Auth Check method
  Future<void> authCheck() async {
    debugPrint("Auth Check Called..");
    String? token = MySharedPref.getUserToken();
    if (token == '' || token.isEmpty) {
      isLoggedIn.value = false;
      Get.offAllNamed(Routes.AUTH_GATEWAY);
      return;
    }
    await BaseClient.safeApiCall(
      AppConstants.authCheck,
      RequestType.post,
      headers: {
        'Authorization': 'Bearer $token',
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;
        if (response.data['status']) {
          isLoggedIn.value = true;
          if (response.data["update_profile_required"]) {
            Get.toNamed(Routes.PROFILE_UPDATE_REQUIRED, arguments: {
              "phoneNumber": response.data["data"]["phone"] ?? "",
            });
            isLoggedIn.value = true;
            Get.find<NavbarController>().getMeProfileInfo();
          }
        } else {
          isLoggedIn.value = false;
          MySharedPref.removeUserToken();
          MyGetStorage.removeCache(MyGetStorage.meUser);
          myUser = User();
          Get.find<NavbarController>().clearProfileState();
        }
        debugPrint("Auth Check successfully: ${response.data["message"]}");
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        isLoggedIn.value = false;
        MySharedPref.removeUserToken();
        MyGetStorage.removeCache(MyGetStorage.meUser);
        myUser = User();
        Get.find<NavbarController>().clearProfileState();
        debugPrint("Error Auth Check: ${error.message}");
      },
    );
  }
}
