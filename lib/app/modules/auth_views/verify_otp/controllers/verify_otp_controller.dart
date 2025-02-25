import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';

class VerifyOtpController extends GetxController {
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

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
