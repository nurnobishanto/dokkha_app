import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../components/custom_snackbar.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';
import '../models/my_orders_details_model.dart';

class MyOrdersDetailsController extends GetxController {

  // Data Model
  Rx<MyOrdersDetailsModel> model = MyOrdersDetailsModel().obs;

  // API Call Status
  var apiCallStatus = ApiCallStatus.holding.obs;

  // Fetch Order from API
  Future<void> fetchMyOrdersDetails({required int id}) async {
    apiCallStatus.value = ApiCallStatus.loading;
    String? token = MySharedPref.getUserToken();
    String  url = "${AppConstants.myOrdersDetails}/$id";

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
          model.value = MyOrdersDetailsModel.fromJson(response.data);
          apiCallStatus.value = ApiCallStatus.success;
        } else {
          apiCallStatus.value = ApiCallStatus.error;
          CustomSnackBar.showCustomErrorToast(
              message: response.data['message'] ?? "অর্ডার তথ্য লোড করতে ব্যর্থ");
        }
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
        debugPrint("MyOrdersDetails API Error: $error");
        CustomSnackBar.showCustomErrorToast(
            message: "সার্ভার সংযোগে সমস্যা হয়েছে");
      },
    );
  }

}