import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/profile_module/my_orders/models/my_orders_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';

import '../../../../components/custom_snackbar.dart';

class MyOrdersController extends GetxController {
  // Data Model
  Rx<MyOrdersModel> model = MyOrdersModel().obs;

  // API Call Status
  var apiCallStatus = ApiCallStatus.holding.obs;

  // Fetch Order from API
  Future<void> fetchMyOrders({required bool refresh}) async {
    apiCallStatus.value = ApiCallStatus.loading;
    String? token = MySharedPref.getUserToken();
    String url = AppConstants.myOrders;

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    await BaseClient.safeApiCall(
      url,
      headers: headers,
      RequestType.post,
      onSuccess: (response) {
        if (response.data['status'] == true) {
          model.value = MyOrdersModel.fromJson(response.data);
          apiCallStatus.value = ApiCallStatus.success;
        } else {
          apiCallStatus.value = ApiCallStatus.error;
          CustomSnackBar.showCustomErrorToast(
              message: response.data['message'] ?? "Orders লোড করতে ব্যর্থ");
        }
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
        debugPrint("MyOrders API Error: $error");
        CustomSnackBar.showCustomErrorToast(
            message: "সার্ভার সংযোগে সমস্যা হয়েছে");
      },
    );
  }

  @override
  void onInit() {
    fetchMyOrders(refresh: true);
    super.onInit();
  }

}
