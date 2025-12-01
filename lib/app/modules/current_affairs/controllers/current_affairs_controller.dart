import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/current_affairs/models/current_affairs_model.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

class CurrentAffairsController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentPage = 1.obs;
  RxString search = RxString("");

  RxObjectMixin<CurrentAffairsModel> model = CurrentAffairsModel().obs;

  Future<void> fetchCurrentAffairs(String search,
      {int page = 1, bool refresh = false, String? date}) async {
    final token = MySharedPref.getUserToken();
    isLoading.value = true;
    String url =
        "${AppConstants.nationalCA}?search=$search&page=$page&date=$date";
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    BaseClient.safeApiCall(
      url,
      RequestType.get,
      headers: headers,
      onSuccess: (response) {
        if (response.data["status"]) {
          CurrentAffairsModel modelData =
              CurrentAffairsModel.fromJson(response.data);
          // MyGetStorage.writeCacheData(MyGetStorage.bdAffairs, response);

          if (page > 1 && model.value.currentAffairs != null) {
            // Merge new data with existing data
            model.value.currentAffairs!.data!
                .addAll(modelData.currentAffairs!.data!);
          } else {
            model.value = modelData;
          }
          currentPage.value = page;
          isLoading.value = false;
        } else {
          isLoading.value = false;
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchCurrentAffairs("");
  }
}
