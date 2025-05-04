import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/helper/api_helper.dart';
import 'package:lokkha/app/routes/app_pages.dart';
import 'package:lokkha/app/helper/global.dart';

import '../../../../../utils/constants.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/base_client.dart';

class ProfileController extends GetxController {

  @override
  void onInit() {
    getMeProfileInfo();
    debugPrint("TEST");
    debugPrint(profileDataModel.value.data!.name.toString());
    super.onInit();
  }
  Future<void> logout() async {
    String? token = MySharedPref.getUserToken();
    String url = AppConstants.logout;
    await BaseClient.safeApiCall(
      url,
      RequestType.post,
      headers: {
        'Authorization': 'Bearer $token',
      },
      onSuccess: (response) async {
        if (response.data['status']) {
          await MySharedPref.removeUserToken();
          isLoggedIn.value = false;
          CustomSnackBar.showCustomToast(message: response.data['message']);
          AuthService authService = AuthService();
          authService.authCheck();
          Get.offNamed(Routes.NAVBAR);
        } else {
          isLoggedIn.value = false;
          await MySharedPref.removeUserToken();
          CustomSnackBar.showCustomErrorToast(
              message: response.data['message']);
        }
      },
      onError: (error) {
        debugPrint("Logout Error:$error");
      },
    );
  }
}
