import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../utils/constants.dart';
import '../data/local/my_shared_pref.dart';
import '../modules/navbar/model/profile_data_model.dart';
import '../services/base_client.dart';

RxObjectMixin<ProfileDataModel> profileDataModel = ProfileDataModel().obs;
Future<void> getMeProfileInfo() async {
  String? token = MySharedPref.getUserToken();
  String url = AppConstants.me;
  await BaseClient.safeApiCall(
    url,
    RequestType.post,
    headers: {
      'Authorization': 'Bearer $token',
    },
    onSuccess: (response) {
      if (response.data['status']) {
        ProfileDataModel dataModel = ProfileDataModel.fromJson(response.data);
        profileDataModel.value = dataModel;
        debugPrint("Profile Data fetch Success");
      }
    },
    onError: (error) {
      debugPrint("Error:$error");
    },
  );
}
