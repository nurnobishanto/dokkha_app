import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:lokkha/app/modules/navbar/model/profile_data_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../../../helper/api_helper.dart';
import '../model/update_profile_model.dart';

class ProfileUpdateController extends GetxController {
  RxString gender = 'অন্যান্য'.obs;
  String genderSelect() {
    final map = {
      'পুরুষ': 'male',
      'মহিলা': 'female',
      'অন্যান্য': 'other',
    };
    return map[gender.value] ?? 'others';
  }

  var groupValue = "a";
  final RxBool _isLoading = false.obs;
  RxObjectMixin<ProfileUpdateModel> model = ProfileUpdateModel().obs;

  /// Controllers
  final nameController = TextEditingController(
      text:profileDataModel
          .value
          .data!
          .name
          .toString());
  final emailController = TextEditingController(
      text: profileDataModel
          .value
          .data!
          .email
          .toString());

  final organizationController = TextEditingController(
      text: profileDataModel
          .value
          .data!
          .organization
          .toString());
  final occupationController = TextEditingController(
      text:profileDataModel
          .value
          .data!
          .occupation
          .toString());
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();

  /// Date value using obs
  RxString dob = ''.obs;

  /// Date Picker Function
  Future<void> selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dob.value = picked.toIso8601String().split("T").first;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    pwdController.dispose();
    organizationController.dispose();
    occupationController.dispose();
    confirmPwdController.dispose();
    super.onClose();
  }

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  Future<void> updateProfileInfo(context) async {
    _isLoading.value = true;
    String? token = MySharedPref.getUserToken();
    if (token == "" && token.isEmpty) {
      return;
    }
    String url = AppConstants.updateProfileInfo;
    Map<String, dynamic> data = {
      'name': nameController.text.trim().toString(),
      'email': emailController.text.trim().toString(),
      'occupation': occupationController.text.trim().toString(),
      'organization': organizationController.text.trim().toString(),
      'gender': genderSelect().toString(),
      'date_of_birth': dob.value.toString(),
      'password': pwdController.text,
      "password_confirmation": confirmPwdController.text.trim(),
      //'image': imagePath.value ?? '', // fallback if null
    };

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    await BaseClient.safeApiCall(
      url,
      RequestType.post,
      headers: headers,
      data: data,
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;
        if (response.data['status']) {
          _isLoading.value = false;
          ProfileUpdateModel profileData =
              ProfileUpdateModel.fromJson(response.data);
          model.value = profileData;

          CustomSnackBar.showCustomToast(message: response.data['message']);
          getMeProfileInfo();
          Navigator.pop(context);
        } else {
          CustomSnackBar.showCustomSnackBar(
            title: "Something Went Wrong!",
            message: (response.data["message"].toString()),
          );
        }
      },
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
        debugPrint("Logging...");
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        if (error.response?.data['errors'] != null) {
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
      },
    );
  }
}
