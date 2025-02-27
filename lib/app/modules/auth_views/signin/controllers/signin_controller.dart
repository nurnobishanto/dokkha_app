import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';

class SignInController extends GetxController {
  bool isRegister = false;
  bool isLoading = false;
  final TextEditingController passwordController = TextEditingController();
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  /// login method
  Future<void> login(String phone, String type, String password) async {
    _setLoadingState(true);
    await BaseClient.safeApiCall(
      AppConstants.login,
      RequestType.post,
      data: {
        "phone": phone,
        "type": type,
        "value": password,
      },
      onSuccess: (response) {
        _setLoadingState(false);
        apiCallStatus = ApiCallStatus.success;

        if (response.data['status']) {
          CustomSnackBar.showCustomToast(
            message: response.data["message"],
          );
          Get.offAllNamed(Routes.NAVBAR);
        } else {
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Invalid Credential',
            message: response.data["message"],
          );
        }
        update();
        debugPrint("Login successfully: ${response.data}");
      },
      onError: (error) {
        _setLoadingState(false);
        apiCallStatus = ApiCallStatus.error;
        update();
        debugPrint("Error login: ${error.message}");
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
        debugPrint("Logging...");
      },
    );
  }

  void _setLoadingState(bool loading) {
    isLoading = loading;
    apiCallStatus = loading ? ApiCallStatus.loading : ApiCallStatus.holding;
    update();
  }
}
