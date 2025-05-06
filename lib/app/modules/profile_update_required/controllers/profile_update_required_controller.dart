import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../helper/global.dart';
import '../../../components/custom_snackbar.dart';
import '../../../routes/app_pages.dart';
import '../../../services/api_call_status.dart';
import '../../navbar/controllers/navbar_controller.dart';

class ProfileUpdateRequiredController extends GetxController {
  // Controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();
  final dobController = TextEditingController();
  //final occupationController = TextEditingController();

  // Fields
  String gender = '';
  String occupation = '';
  bool isLoading = false;
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  void _setLoadingState(bool loading) {
    isLoading = loading;
    apiCallStatus = loading ? ApiCallStatus.loading : ApiCallStatus.holding;
    update();
  }

  /// Date Picker Function
  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = picked.toIso8601String().split("T").first;
    }
  }

  Future<void> updateProfileRequired() async {
    // Validation
    if (nameController.text.trim().isEmpty ||
        dobController.text.trim().isEmpty ||
        gender.trim().isEmpty ||
        occupation.trim().isEmpty ||
        pwdController.text.trim().isEmpty ||
        confirmPwdController.text.trim().isEmpty) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: "Missing Information",
        message: "Please fill in all the required fields before continuing.",
      );
      return;
    }

    if (pwdController.text.trim() != confirmPwdController.text.trim()) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: "Oops!",
        message:
            "The password and confirmation password do not match.Please try again.",
      );
      return;
    }

    String? token = MySharedPref.getUserToken();
    String url = AppConstants.updateProfileRequired;

    final Map<String, dynamic> data = {
      "name": nameController.text.trim(),
      "date_of_birth": dobController.text.trim(),
      "gender": gender.trim(),
      "phone": phoneController.text.trim().toString(),
      "occupation": occupation.trim(),
      "password": pwdController.text.trim(),
      "password_confirmation": confirmPwdController.text.trim(),
    };
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    await BaseClient.safeApiCall(
      url,
      RequestType.post,
      data: data,
      headers: headers,
      onSuccess: (response) {
        _setLoadingState(true);
        apiCallStatus = ApiCallStatus.success;
        if (response.data['status']) {
          CustomSnackBar.showCustomToast(
            message: response.data["message"],
          );
          isLoggedIn.value = true;
          Get.find<NavbarController>().getMeProfileInfo();
          Get.offAllNamed(Routes.NAVBAR);
        }
        update();
        debugPrint("Update Profile Required successful: ${response.data}");
      },
      onError: (error) {
        _setLoadingState(false);
        apiCallStatus = ApiCallStatus.error;
        if (error.response?.data["errors"] != null) {
          final errors = error.response!.data['errors'];
          errors.forEach((key, value) {
            CustomSnackBar.showCustomErrorToast(
              message: value[0],
            );
          });
        } else {
          CustomSnackBar.showCustomToast(
            message: error.message,
          );
        }
        update();
        debugPrint("Error update Profile Info Required: ${error.message}");
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
        debugPrint("Logging...");
      },
    );
  }

  /// Submit Function
  void submit() {
    debugPrint("Name: ${nameController.text}");
    debugPrint("Phone: ${phoneController.text}");
    debugPrint("DOB: ${dobController.text}");
    debugPrint("Gender: $gender");
    debugPrint("Occupation: $occupation");
    debugPrint("Password: ${pwdController.text}");
    debugPrint("Confirm Password: ${confirmPwdController.text}");
  }

  /// Dispose all controllers
  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
