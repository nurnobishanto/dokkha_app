import 'package:get/get.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/models/slider_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

class HomeApiService {
  final Rx<SliderModel> sliderModel = SliderModel().obs;
  final Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.holding.obs;
  Future<void> fetchSliders() async {
    const url = AppConstants.sliders;
    apiCallStatus.value = ApiCallStatus.loading;
    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      onSuccess: (response) {
        if (response.data['status']) {
          sliderModel.value = SliderModel.fromJson(response.data);
          apiCallStatus.value = ApiCallStatus.success;
        } else {
          apiCallStatus.value = ApiCallStatus.error;
        }
      },
      onError: (_) {
        apiCallStatus.value = ApiCallStatus.error;
      },
    );
  }


}
