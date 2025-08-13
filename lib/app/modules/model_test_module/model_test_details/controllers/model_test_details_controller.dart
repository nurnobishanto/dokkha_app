import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';
import '../../models/single_model_test_model.dart';

class ModelTestDetailsController extends GetxController {
 late final int id;
  @override
  void onInit() {
    id = Get.arguments['id'] as int;
    fetchSingleModelTest(id);
    super.onInit();
  }

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  Rx<SingleModelTestModel?> model = Rx<SingleModelTestModel?>(null);
  Future<void> fetchSingleModelTest(int id) async {
    apiCallStatus = ApiCallStatus.loading;
    String? token = MySharedPref.getUserToken();
    final String url = "${AppConstants.modelTest}/$id";
    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      headers: {'Authorization': 'Bearer $token'},
      onLoading: () {
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        final data = response.data;
        if (data['status'] == true) {
          model.value = SingleModelTestModel.fromJson(data);
          apiCallStatus = ApiCallStatus.success;
          update();
        } else {
          apiCallStatus = ApiCallStatus.error;
          update();
        }
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }


}
