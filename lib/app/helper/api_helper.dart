import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants.dart';
import '../data/local/my_shared_pref.dart';
import '../modules/navbar/model/profile_data_model.dart';
import '../services/base_client.dart';
import '../helper/global.dart';

Rx<ProfileDataModel> profileDataModel = ProfileDataModel().obs;

Future<void> getMeProfileInfo() async {
  debugPrint("Called Get Me Profile Information");
  final token = MySharedPref.getUserToken();
  if (token == '' || token.isEmpty) return;
  const url = AppConstants.me;
  await BaseClient.safeApiCall(
    url,
    RequestType.post,
    headers: {'Authorization': 'Bearer $token'},
    onSuccess: (response) {
      if (response.data['status']) {
        profileDataModel.value = ProfileDataModel.fromJson(response.data);
        isLoggedIn.value = true;
        debugPrint("✅ Profile Data fetch Success");
      } else {
        clearProfileState();
        debugPrint("⚠️ Profile fetch failed (API said false)");
      }
    },
    onError: (error) {
      debugPrint("❌ Profile Fetch Error: $error");
      clearProfileState();
    },
  );
}

void clearProfileState() {
  isLoggedIn.value = false;
  profileDataModel.value = ProfileDataModel();
  MySharedPref.removeUserToken(); // optional: clear token on failure
}
