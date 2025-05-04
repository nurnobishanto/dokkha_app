
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../helper/api_helper.dart';
import '../models/package_checkout_model.dart';
import '../views/payment_webview.dart';

class PremiumPackageCheckoutController extends GetxController {
  final RxBool isChecked = false.obs;
  final TextEditingController couponController = TextEditingController();
  RxBool isCheckedCondition = false.obs;
  //************************** Text Field Area ******************************* */
  final Rx<TextEditingController> nameController = TextEditingController(
    text: profileDataModel.value.data!.name ?? '',
  ).obs;
  final Rx<TextEditingController> phoneController =
      TextEditingController(text: profileDataModel.value.data!.phone?? '')
          .obs;

  final Rx<TextEditingController> mailController =
      TextEditingController(text: profileDataModel.value.data!.email).obs;
  RxBool isLoading = false.obs;

  //final otp = MySharedPref.getOTPNumber();

  RxObjectMixin<PackageCheckoutModel> dataModel = PackageCheckoutModel().obs;

  Future<void> makePayment(int id) async {
    String email = mailController.value.text.toString().trim();
    String? token = MySharedPref.getUserToken();
    String orderPlaceUrl = "${AppConstants.packageOrderUrl}/$id";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // Create a map containing
    Map<String, dynamic> data = {
      //'coupon_code': couponModel.value.discount,
      'email': email,
      'payment_method': selectedPaymentMethod.value,
    };

    BaseClient.safeApiCall(
      orderPlaceUrl,
      RequestType.post,
      data: data,
      headers: headers,
      onSuccess: (response) {
        if (response.data["status"]) {
          print("PAYMENT: ${response.data["status"]}");
          isLoading.value = false;
          PackageCheckoutModel data =
              PackageCheckoutModel.fromJson(response.data);
          dataModel.value = data;
          Get.to(PaymentWebView(url: data.paymentUrl.toString()));
        } else {
          isLoading.value = false;
          CustomSnackBar.showCustomToast(
              title: "Something Went Wrong!",
              message: response.data["message"].toString());
        }
      },
    );
  }

  //

  RxInt selectedPayment = 0.obs;
  RxString selectedPaymentMethod = RxString("bkash"); // Default selected index

  void setSelectedPayment(int index) {
    selectedPayment.value = index;
    switch (selectedPayment.value) {
      case 0:
        selectedPaymentMethod.value = "bkash";
        break;
      case 1:
        selectedPaymentMethod.value = "nagad";
        break;
      case 2:
        selectedPaymentMethod.value = "sslcommerz";
        break;
      default:
        selectedPaymentMethod.value = "bkash";
        break;
    }
  }

/// Apply coupon Method...
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  RxString appliedCouponMessage = "".obs;
  RxInt discountAmount = (-1).obs;
  RxInt totalAmount = (-1).obs;
  Future<void> couponApply(String couponCode, String price, BuildContext context) async {
    apiCallStatus = ApiCallStatus.loading;
    update();
    String ? token = MySharedPref.getUserToken();
    const String url = AppConstants.couponApply;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final data = {
      'coupon_code': couponCode,
      'price': price,
    };

    await BaseClient.safeApiCall(
      url,
      headers: headers,
      RequestType.post,
      data: data,
      onSuccess: (response) {
        final status = response.data["status"];
        final message = response.data["message"];

        if (status == true) {
          apiCallStatus = ApiCallStatus.success;
          appliedCouponMessage.value = message; // Optional
          discountAmount.value = int.tryParse(response.data["discount"].toString()) ?? -1;
          totalAmount.value = int.tryParse(response.data["discount_price"].toString()) ?? -1;
          CustomSnackBar.showCustomToast(message: message);
        } else {
          apiCallStatus = ApiCallStatus.error;
          appliedCouponMessage.value = "";
          discountAmount.value = -1;
          totalAmount.value = -1;
          CustomSnackBar.showCustomErrorToast(message: message);
        }

        update();
      },
      onError: (error) {
        apiCallStatus = ApiCallStatus.error;
        update();
        debugPrint("Coupon API error: $error");
        CustomSnackBar.showCustomErrorToast(message: "সার্ভারে সমস্যা হয়েছে");
      },
    );
  }

  void updateCoupon() {
    if (!isChecked.value) {
      couponController.clear();
      // কুপন ইনঅ্যাক্টিভ হলে status reset করা যায়
      apiCallStatus = ApiCallStatus.holding;
      // কুপন success message-এর জন্য আলাদা ভ্যারিয়েবল reset করতে পারো
      appliedCouponMessage.value = "";
      discountAmount.value = -1;
      totalAmount.value = -1;
    }
  }
  @override
  void onInit() {
    getMeProfileInfo();
    super.onInit();
  }


}
