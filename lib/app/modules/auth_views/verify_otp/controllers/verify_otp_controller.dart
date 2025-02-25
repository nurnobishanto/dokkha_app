import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';

class VerifyOtpController extends GetxController {
  late final String otp;
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  bool isLoading = false;

  /// register method
  Future<void> register(String phone) async {
    _setLoadingState(true);
    await BaseClient.safeApiCall(
      AppConstants.register,
      RequestType.post,
      data: {
        "phone": phone,
        "otp": otp,
      },
      onSuccess: (response) {
        _setLoadingState(false);
        apiCallStatus = ApiCallStatus.success;
        update();

        if (response.data['status']) {
          CustomSnackBar.showCustomToast(
            message: response.data["message"],
          );
          Get.toNamed(Routes.NAVBAR);
        } else {
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Invalid Credential',
            message: response.data["message"],
          );
        }
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

  /// send otp
  Future<void> sendOtp(String phone, String type) async {
    await BaseClient.safeApiCall(
      AppConstants.sendOtp,
      RequestType.post,
      data: {
        "phone": phone,
        "type": type,
      },
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;
        update();
        CustomSnackBar.showCustomToast(
          message: response.data["message"],
        );
        debugPrint("OTP sent successfully: ${response.data}");
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        update();
        debugPrint("Error send otp: ${error.message}");
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
        debugPrint("Otp Sending...");
      },
    );
  }
}
