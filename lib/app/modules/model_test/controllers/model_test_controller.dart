import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/model_test/models/model_test_list_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

import '../models/single_model_test_model.dart';

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



  Future<void> fetchSingleModelTest(int id) async {
    singleModelApiCallStatus.value = ApiCallStatus.loading;
    String? token = MySharedPref.getUserToken();
    final String url = "${AppConstants.modelTest}/$id";
    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      headers: {'Authorization': 'Bearer $token'},
      onLoading: () {
        singleModelApiCallStatus.value = ApiCallStatus.loading;
      },
      onSuccess: (response) {
        final data = response.data;
        if (data['status'] == true) {
          singleModelTest.value = SingleModelTestModel.fromJson(data);
          singleModelApiCallStatus.value = ApiCallStatus.success;
        } else {
          singleModelApiCallStatus.value = ApiCallStatus.error;
        }
      },
      onError: (error) {
        singleModelApiCallStatus.value = ApiCallStatus.error;
      },
    );
  }




  @override
  void onInit() {
   fetchModelTests();
    super.onInit();
  }

}
