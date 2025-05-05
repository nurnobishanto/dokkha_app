import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import '../../utils/constants.dart';
import '../data/local/my_get_storage.dart';
import '../data/local/my_shared_pref.dart';
import '../models/fav_question_model.dart';
import '../modules/navbar/model/profile_data_model.dart';
import '../services/base_client.dart';
import '../helper/global.dart';
/// Rx nullable বানাও
Rxn<ProfileDataModel> profileDataModel = Rxn<ProfileDataModel>();
ApiCallStatus getProfileApiStatus = ApiCallStatus.holding;
Future<void> getMeProfileInfo() async {
  debugPrint(" Called Get Me Profile Information");
  final token = MySharedPref.getUserToken();
  if (token.isEmpty) {
    debugPrint("❌ Token is empty, skipping profile fetch.");
    clearProfileState(); // optionally clear previous data
    return;
  }
  getProfileApiStatus = ApiCallStatus.loading;
  const url = AppConstants.me;

  await BaseClient.safeApiCall(
    url,
    RequestType.post,
    headers: {'Authorization': 'Bearer $token'},
    onSuccess: (response) {
      final isSuccess = response.data['status'] == true;
      getProfileApiStatus = ApiCallStatus.success;
      if (isSuccess) {
        profileDataModel.value = ProfileDataModel.fromJson(response.data);
        isLoggedIn.value = true;
        debugPrint("✅ Profile Data fetch Success");
      } else {
        debugPrint("⚠️ Profile fetch failed: API status false");
        clearProfileState();
      }
    },
    onError: (error) {
      getProfileApiStatus = ApiCallStatus.error;
      debugPrint("❌ Profile Fetch Error: $error");
      clearProfileState();
    },
  );
}

void clearProfileState() {
  isLoggedIn.value = false;
  profileDataModel.value = null;
  MySharedPref.removeUserToken(); // optional
}



ApiCallStatus apiCallStatus = ApiCallStatus.holding;
Future<void> questionFavAdd(int id) async {
  String? token = MySharedPref.getUserToken();
  const url = AppConstants.questionFavAdd;
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  };
  Map<String, dynamic> data = {
    'id': id,
  };

  BaseClient.safeApiCall(url, RequestType.post, headers: headers, data: data,
      onSuccess: (response) {
    apiCallStatus = ApiCallStatus.success;
    if (response.data['status']) {
      CustomSnackBar.showCustomToast(
          message: response.data['message'].toString());
    }
  });
  getFavList(refresh: true);
}

Future<void> removeFavoriteQuestion(int id) async {
  String? token = MySharedPref.getUserToken();
  const url = AppConstants.questionFavRemove;
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  };
  Map<String, dynamic> data = {
    'id': id,
  };
  BaseClient.safeApiCall(url, RequestType.post, headers: headers, data: data,
      onSuccess: (response) {
    apiCallStatus = ApiCallStatus.success;
    if (response.data['status']) {
      CustomSnackBar.showCustomToast(
          message: response.data['message'].toString());
    }
  });
  getFavList(refresh: true);
}

RxObjectMixin<FavQuestionListModel> favoriteQuestionsModel =
    FavQuestionListModel().obs;

Future<bool> checkQuestionExistInSaved(int id) async {
  await getFavList(refresh: true);
  return favoriteQuestionsModel.value.favoriteQuestions
          ?.any((q) => q.id == id) ??
      false;
}

ApiCallStatus favApiCallStatus = ApiCallStatus.holding;
RxBool isFavLoading = true.obs;
Future<void> getFavList({bool refresh = false}) async {
  isFavLoading.value = true;
  if (refresh) {
    MyGetStorage.removeCache(MyGetStorage.favQuestionsKey);
  }
  if (!refresh &&
      MyGetStorage.getStorage.hasData(MyGetStorage.favQuestionsKey)) {
    var cacheData = MyGetStorage.readCache(MyGetStorage.favQuestionsKey);
    if (cacheData != null) {
      favoriteQuestionsModel.value = FavQuestionListModel.fromJson(cacheData);
      return;
    }
  }

  String? token = MySharedPref.getUserToken();
  const url = AppConstants.questionFavList;
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json'
  };
  BaseClient.safeApiCall(
    url,
    RequestType.get,
    headers: headers,
    onSuccess: (response) {
      favApiCallStatus = ApiCallStatus.success;
      if (response.data['status']) {
        FavQuestionListModel modelData =
            FavQuestionListModel.fromJson(response.data);
        favoriteQuestionsModel.value = modelData;
        MyGetStorage.writeCacheData(MyGetStorage.favQuestionsKey, response);
        isFavLoading.value = false;
        // CustomSnackBar.showCustomToast(
        //     message: response.data['message'].toString());
      }
    },
    onError: (err) {
      isFavLoading.value = false;
      favApiCallStatus = ApiCallStatus.error;
      CustomSnackBar.showCustomErrorToast(message: err.message);
    },
  );
}
