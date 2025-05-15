import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/premium_packages/models/premium_package_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

class PremiumPackagesController extends GetxController {
  RxObjectMixin<PremiumPackageModel> model = PremiumPackageModel().obs;
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
final isLoading = true.obs;
  Future<void> fetchPremiumPackage() async {
    isLoading.value = true;
    var url = AppConstants.premiumPackage;
    BaseClient.safeApiCall(
      url,
      RequestType.get,
      onSuccess: (response) {
        apiCallStatus = ApiCallStatus.success;
        if (response.data['status']) {
          isLoading.value = false;
          model.value = PremiumPackageModel.fromJson(response.data);
        }
      },
      onError: (error){
        debugPrint(error.toString());
      }
    );
  }






  @override
  void onInit() {
fetchPremiumPackage();
    super.onInit();
  }
}
