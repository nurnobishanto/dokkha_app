import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../components/custom_snackbar.dart';
import '../../auth_views/auth_gateway/views/auth_gateway_view.dart';
import '../../exam/models/start_exam_model.dart';
import '../../premium_packages/views/premium_packages_view.dart';
import '../models/model_test_list_model.dart';
import '../models/single_model_test_model.dart';
import '../../exam/views/exam_run_view.dart';

class ModelTestController extends GetxController {
  Rx<ModelTestListModel?> modelTestList = Rx<ModelTestListModel?>(null);
  Rx<SingleModelTestModel?> singleModelTest = Rx<SingleModelTestModel?>(null);
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.holding.obs;
  Rx<ApiCallStatus> singleModelApiCallStatus = ApiCallStatus.holding.obs;

  Future<void> fetchModelTests() async {
    apiCallStatus.value = ApiCallStatus.loading;
    String? token = MySharedPref.getUserToken();
    final String url = AppConstants.modelTests;
    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      headers: {'Authorization': 'Bearer $token'},
      onLoading: () {
        apiCallStatus.value = ApiCallStatus.loading;
      },
      onSuccess: (response) {
        final data = response.data;
        if (data['status'] == true) {
          modelTestList.value = ModelTestListModel.fromJson(data);
          apiCallStatus.value = ApiCallStatus.success;
        } else {
          apiCallStatus.value = ApiCallStatus.error;
        }
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
      },
    );
  }

  // Future<void> fetchSingleModelTest(int id) async {
  //   singleModelApiCallStatus.value = ApiCallStatus.loading;
  //   String? token = MySharedPref.getUserToken();
  //   final String url = "${AppConstants.modelTest}/$id";
  //   await BaseClient.safeApiCall(
  //     url,
  //     RequestType.get,
  //     headers: {'Authorization': 'Bearer $token'},
  //     onLoading: () {
  //       singleModelApiCallStatus.value = ApiCallStatus.loading;
  //     },
  //     onSuccess: (response) {
  //       final data = response.data;
  //       if (data['status'] == true) {
  //         singleModelTest.value = SingleModelTestModel.fromJson(data);
  //         singleModelApiCallStatus.value = ApiCallStatus.success;
  //       } else {
  //         singleModelApiCallStatus.value = ApiCallStatus.error;
  //       }
  //     },
  //     onError: (error) {
  //       singleModelApiCallStatus.value = ApiCallStatus.error;
  //     },
  //   );
  // }

  RxBool isLoading = true.obs;

  Rx<ExamStartModel> examStartModel = ExamStartModel().obs;
  ApiCallStatus startExamApiCallStatus = ApiCallStatus.holding;

  /// Fetch Exam Start Method
  Future<void> startExam(int id) async {
    String? token = MySharedPref.getUserToken();
    if (token == '' || token.isEmpty) return Get.to(const AuthGatewayView());
    await BaseClient.safeApiCall(
      '${AppConstants.exam}/$id/start',
      RequestType.post,
      headers: {
        "Authorization": 'Bearer $token',
      },
      onSuccess: (response) {
        startExamApiCallStatus = ApiCallStatus.success;
        if (response.data['status']) {
          isLoading.value = false;
          ExamStartModel data = ExamStartModel.fromJson(response.data);
          examStartModel.value = data;
          Get.to(() => RunExamView(
                examStartModel: examStartModel.value,
              ));
        } else if (response.data["status"] == false) {
          if (response.data["package_required"] == true) {
            Get.to(const PremiumPackagesView());
          }
          CustomSnackBar.showCustomErrorToast(
              message: response.data["message"].toString());
        }
      },
    );
  }

  @override
  void onInit() {
    fetchModelTests();
    super.onInit();
  }
}
