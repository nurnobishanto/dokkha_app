import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';
import '../models/model_test_categories_model.dart';

class ModelTestCategoriesController extends GetxController {
  Rx<ModelTestCategoriesModel?> modelTestList =
      Rx<ModelTestCategoriesModel?>(null);
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.holding.obs;
  Future<void> fetchCategoriesModelTests() async {
    apiCallStatus.value = ApiCallStatus.loading;
    String? token = MySharedPref.getUserToken();
    final String url = AppConstants.modelTestCategories;
    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      headers: {'Authorization': 'Bearer $token'},
      onLoading: () {
        apiCallStatus.value = ApiCallStatus.loading;
      },
      onSuccess: (response) {
        final data = response.data;
        if (data['status']) {
          modelTestList.value = ModelTestCategoriesModel.fromJson(data);
          apiCallStatus.value = ApiCallStatus.success;
          update();
        } else {
          apiCallStatus.value = ApiCallStatus.error;
          update();
        }
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
        update();
      },
    );
  }

  @override
  void onInit() {
    fetchCategoriesModelTests();
    super.onInit();
  }
}
