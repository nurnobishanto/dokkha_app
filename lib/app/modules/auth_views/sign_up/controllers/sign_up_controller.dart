import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../../components/custom_snackbar.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';

class SignUpController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  bool isLoading = false;

  Future<void> checkPhoneNumber() async {
    _setLoadingState(true);

    await BaseClient.safeApiCall(
      AppConstants.checkPhoneNumber,
      RequestType.post,
      data: {"phone": phoneController.text},
      onSuccess: _onSuccess,
      onError: _onError,
      onLoading: _onLoading,
    );
  }

  void _onSuccess(response) {
    _setLoadingState(false);
    if (response.data['status']) {
      _handleSuccessResponse(response);
    } else {
      _showErrorSnackBar(response.data["message"]);
    }
  }

  void _onError(error) {
    _setLoadingState(false);
    apiCallStatus = ApiCallStatus.error;
    debugPrint("Error checking phone number: ${error.message}");
  }

  void _onLoading() {
    apiCallStatus = ApiCallStatus.loading;
    update();
    debugPrint("Checking phone number...");
  }

  void _setLoadingState(bool loading) {
    isLoading = loading;
    apiCallStatus = loading ? ApiCallStatus.loading : ApiCallStatus.holding;
    update();
  }

  void _handleSuccessResponse(response) {
    debugPrint(response.data["message"]);
    final page = response.data["page"];
    if (page == "otp") {
      Get.toNamed(Routes.VERIFY_OTP, arguments: {
        'phoneNumber': phoneController.text,
        'type': response.data["type"],
      });
    } else if (page == "password") {
      Get.toNamed(Routes.SIGNIN, arguments: phoneController.text);
    }
  }

  void _showErrorSnackBar(String message) {
    CustomSnackBar.showCustomErrorSnackBar(
      title: message,
      message: "Please provide your phone number",
    );
  }
}
