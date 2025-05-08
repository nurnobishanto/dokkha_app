import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../services/base_client.dart';
import '../models/latest_exam_model.dart';






import 'package:lokkha/app/services/api_call_status.dart';


class LatestExamController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentPage = 1.obs;
  RxBool isFavourite = false.obs;
  RxString search = RxString("");
  RxObjectMixin<LatestExamModel> model = LatestExamModel().obs;
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  Future<void> fetchLatestExam(
      {int page = 1, String date = '', String search = ''}) async {
    apiCallStatus = ApiCallStatus.loading;
    isLoading.value = true;
    String url =
        "${AppConstants.latestExam}?search=$search&page=$page&date=$date";

    BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
      if (response.data["status"]) {
        LatestExamModel modelData = LatestExamModel.fromJson(response.data);
        if (page > 1 && model.value.latestExams != null) {
          // Merge new data with existing data
          model.value.latestExams!.data!.addAll(modelData.latestExams!.data!);
          apiCallStatus = ApiCallStatus.success;
        } else {
          model.value = modelData;
        }
        currentPage.value = page;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }, onError: (err) {
      apiCallStatus = ApiCallStatus.error;
    });
  }

  @override
  void onInit() {
    fetchLatestExam();
    super.onInit();
  }
}
