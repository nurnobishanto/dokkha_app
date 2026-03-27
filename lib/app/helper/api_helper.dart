import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import '../../utils/constants.dart';
import '../data/local/my_get_storage.dart';
import '../data/local/my_shared_pref.dart';
import '../models/fav_question_model.dart';
import '../services/base_client.dart';

ApiCallStatus apiCallStatus = ApiCallStatus.holding;
Future<void> questionFavAdd(int id) async {
  String? token = MySharedPref.getUserToken();
  var url = AppConstants.questionFavAdd;
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
  var url = AppConstants.questionFavRemove;
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

RxObjectMixin<FavQuestionListModel> favoriteQuestionsListModel =
    FavQuestionListModel().obs;

Future<bool> checkQuestionExistInSaved(int id) async {
  await getFavList(refresh: true);
  return favoriteQuestionsListModel.value.favoriteQuestions
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
      favoriteQuestionsListModel.value =
          FavQuestionListModel.fromJson(cacheData);
      return;
    }
  }

  String? token = MySharedPref.getUserToken();
  var url = AppConstants.questionFavList;
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
        favoriteQuestionsListModel.value = modelData;
        MyGetStorage.writeCacheData(
            MyGetStorage.favQuestionsKey, response.data);
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
