import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/current_affairs/models/current_affairs_model.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

class CurrentAffairsController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentPage = 1.obs;
  RxString search = RxString("");
  RxInt totalPages = 1.obs;

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
          model.value = CurrentAffairsModel.fromJson(response.data);
          currentPage.value = page;
          totalPages.value = model.value.currentAffairs?.lastPage ?? 1;
        }
        isLoading.value = false;
      },
      onError: (err) {
        isLoading.value = false;
      },
    );
  }

  // ---------- Pagination Actions ----------
  void goToPage(int page) {
    if (page < 1 || page > totalPages.value) return;
    fetchCurrentAffairs("", page: page);
  }

  @override
  void onInit() {
    super.onInit();
    fetchCurrentAffairs("");
  }
}
