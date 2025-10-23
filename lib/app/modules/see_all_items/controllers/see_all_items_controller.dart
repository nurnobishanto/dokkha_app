import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../services/base_client.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import '../models/all_course_model.dart';

class SeeAllItemsController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingQuestion = false.obs;
  RxInt currentPage = 1.obs;
  RxBool isFavourite = false.obs;
  RxString search = RxString("");
  RxObjectMixin<AllCourseModel> model = AllCourseModel().obs;

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  Future<void> fetchAllCourses(
      {int page = 1, String date = '', String search = ''}) async {
    apiCallStatus = ApiCallStatus.loading;
    isLoading.value = true;
    String url = AppConstants.courses;

    BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
      if (response.data["status"]) {
        AllCourseModel modelData = AllCourseModel.fromJson(response.data);
        if (page > 1 && model.value.courses != null) {
          // Merge new data with existing data
          model.value.courses!.data!.addAll(modelData.courses!.data!);
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
    fetchAllCourses();
    super.onInit();
  }
}
