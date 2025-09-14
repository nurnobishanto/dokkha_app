import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/routes/app_pages.dart';
import 'package:lokkha/app/helper/global.dart';
import 'package:lokkha/app/services/auth_service.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';
import '../../../navbar/model/profile_data_model.dart';

class ProfileController extends GetxController {
  RxBool isLoading = true.obs;
  Rxn<ProfileDataModel> profileDataModel = Rxn<ProfileDataModel>();
  Rx<ApiCallStatus> profileApiStatus = ApiCallStatus.holding.obs;
  AuthService authService = AuthService();
  @override
  void onInit() {
    debugPrint("ProfileController initialized");
    fetchProfileData();

    super.onInit();
  }

  Future<void> fetchProfileData() async {
    final token = MySharedPref.getUserToken();
    if (token.isEmpty) {
      profileApiStatus.value = ApiCallStatus.error;
      return;
    }

    profileApiStatus.value = ApiCallStatus.loading;
    var url = AppConstants.me;

    await BaseClient.safeApiCall(
      url,
      RequestType.post,
      headers: {'Authorization': 'Bearer $token'},
      onSuccess: (response) {
        final isSuccess = response.data['status'] == true;
        profileApiStatus.value = ApiCallStatus.success;

        if (isSuccess) {
          profileDataModel.value = ProfileDataModel.fromJson(response.data);
          isLoggedIn.value = true;
        } else {
          isLoggedIn.value = false;
          profileDataModel.value = null;
        }
      },
      onError: (error) {
        profileApiStatus.value = ApiCallStatus.error;
        isLoggedIn.value = false;
      },
    );
  }

  Future<void> logout() async {
    final token = MySharedPref.getUserToken();
    var url = AppConstants.logout;

    await BaseClient.safeApiCall(
      url,
      RequestType.post,
      headers: {'Authorization': 'Bearer $token'},
      onSuccess: (response) async {
        await MySharedPref.removeUserToken();
        isLoggedIn.value = false;

        if (response.data['status']) {
          CustomSnackBar.showCustomToast(message: response.data['message']);
        } else {
          CustomSnackBar.showCustomErrorToast(
              message: response.data['message']);
        }

        Get.offAllNamed(Routes.NAVBAR);
      },
      onError: (error) {
        debugPrint("Logout Error: $error");
      },
    );
  }
}

