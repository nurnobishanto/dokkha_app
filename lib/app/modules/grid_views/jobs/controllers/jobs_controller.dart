import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../../data/local/my_get_storage.dart';
import '../models/job_list_model.dart';

class JobsController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentPage = 1.obs;
  RxBool isFavourite = false.obs;
  RxString search = RxString("");
  RxObjectMixin<Job> detailsModel = Job().obs;
  RxObjectMixin<JobListModel> model = JobListModel().obs;

  Future<void> fetchJobs(String search,
      {int page = 1, bool refresh = false}) async {
    if (refresh) {
      MyGetStorage.removeCache(MyGetStorage.jobKey);
    }
    if (!refresh && MyGetStorage.getStorage.hasData(MyGetStorage.jobKey)) {
      var cacheData = MyGetStorage.readCache(MyGetStorage.jobKey);
      if (cacheData != null) {
        model.value = JobListModel.fromJson(cacheData);
        isLoading.value = false;
      }
    }
    isLoading.value = true;
    String url = "${AppConstants.jobsList}?search=$search&page=$page";

    BaseClient.safeApiCall(
      url,
      RequestType.get,
      onSuccess: (response) {
        if (response.data["status"]) {
          JobListModel modelData = JobListModel.fromJson(response.data);
          MyGetStorage.writeCacheData(MyGetStorage.jobKey, response.data);
          if (page > 1 && model.value.jobs != null) {
            // Merge new data with existing data
            model.value.jobs!.data!.addAll(modelData.jobs!.data!);
          } else {
            model.value = modelData;
          }
          currentPage.value = page;
          isLoading.value = false;
        } else {
          isLoading.value = false;
          if (kDebugMode) {
            print("ERROR ::::::: ");
          }
        }
      },
    );
  }

  // Get jobs list from api method
  Future<void> getSingleJob(int id) async {
    isLoading.value = true;
    String url = "${AppConstants.job}/$id";
    BaseClient.safeApiCall(
      url,
      RequestType.get,
      onSuccess: (response) {
        if (response.data["status"]) {
          if (kDebugMode) {
            print("GobJobs Model Data $response");
          }
          Job modelData = Job.fromJson(response.data['job']);
          detailsModel.value = modelData;
          //isFavourite.value = model.value.isSaved!;
          isLoading.value = false;
        } else {
          isLoading.value = false;
          if (kDebugMode) {
            print("ERROR ::::::: ");
          }
        }
      },
    );
  }

  // Add Favourite jobs list
  Future<void> addFavJob(int govJobId) async {
    // if (token == "") {
    //   return;
    // }
    // // isLoading.value = true;
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token',
    // };
    // NetworkApiServices networkApiServices = NetworkApiServices();
    // String url = "${AppUrl.addFavJob}?locale=${Get.locale}";
    // final Map<String, dynamic> data = {
    //   "government_job_id": govJobId,
    // };
    // var response =
    // await networkApiServices.postApi(data, url, headers: headers);
    //
    // if (response["success"]) {
    //   isFavourite.value = true;
    //   if (kDebugMode) {
    //     print("added favorite ${response["message"]}");
    //   }
    //   Utils.toastMessage(response['message'].toString());
    //   getSingleJob(govJobId);
    // } else {
    //   if (kDebugMode) {
    //     print("ERROR :::::::  ");
    //   }
    // }
  }

  // Removed Favourite from jobs list
  Future<void> removeFavJob(int govJobId) async {
    // if (token == "") {
    //   return;
    // }
    // Map<String, String> headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $token',
    // };
    // NetworkApiServices networkApiServices = NetworkApiServices();
    // String url = "${AppUrl.addFavJob}/$govJobId";
    // var response = await networkApiServices.deleteApi(url, headers: headers);
    // if (response["success"]) {
    //   isFavourite.value = false;
    //   if (kDebugMode) {
    //     print("Removed favorite ${response["message"]}");
    //   }
    //   Utils.toastMessage(response['message'].toString());
    //   getSingleJob(govJobId);
    // } else {
    //   if (kDebugMode) {
    //     print("ERROR ::::::: ");
    //     print("ERROR $response");
    //   }
    // }
  }

  @override
  void onReady() {
    super.onReady();
    fetchJobs("");
  }
}
