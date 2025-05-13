import 'package:get/get.dart';
import 'package:lokkha/app/modules/sponsor_ads/models/sponsor_ads_model.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

class SponsorAdsController extends GetxController {
  RxObjectMixin<SponsorAdsModel> model = SponsorAdsModel().obs;
  List<Ad> dashboardAds = [];
  List<Ad> supportAds = [];
  List<Ad> packageAds = [];
  List<Ad> blogAds = [];

  // RxInt adsLength
  RxBool isLoading = false.obs;
  Future<void> fetchSponsorAds() async {
    isLoading.value = true;
    dashboardAds.clear();
    supportAds.clear();
    packageAds.clear();
    String url = AppConstants.sponsorAds;
    BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
      if (response.data["status"]) {
        isLoading.value = false;
        model.value = SponsorAdsModel.fromJson(response.data);

        dashboardAds = model.value.appAds!['dashboard'] ?? [];
        supportAds = model.value.appAds!['support'] ?? [];
        packageAds = model.value.appAds!['packages'] ?? [];
        blogAds = model.value.appAds!['blog'] ?? [];
      } else {
        isLoading.value = false;
      }
    });
  }

  @override
  void onInit() {
    fetchSponsorAds();
    super.onInit();
  }
}
