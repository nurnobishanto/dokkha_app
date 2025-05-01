import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lokkha/app/components/custom_snackbar.dart';
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
    text: profileDataModel.value.data!.name.toString(),
  ).obs;
  final Rx<TextEditingController> phoneController =
      TextEditingController(text: profileDataModel.value.data!.phone.toString())
          .obs;

  final Rx<TextEditingController> mailController =
      TextEditingController(text: profileDataModel.value.data!.email).obs;
  RxBool isLoading = false.obs;

  //final otp = MySharedPref.getOTPNumber();

  RxObjectMixin<PackageCheckoutModel> dataModel = PackageCheckoutModel().obs;

  Future<void> makePayment(int id) async {
    String email = mailController.value.text.toString().trim();
    String? token = MySharedPref.getUserToken();
    String orderPlaceUrl = "${AppConstants.packageOrderUrl}$id";

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // Create a map containing
    Map<String, dynamic> data = {
      //'discount': couponModel.value.discount,
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
          PackageCheckoutModel data = PackageCheckoutModel.fromJson(response.data);
          dataModel.value = data;
          //Get.to(PaymentWebView(url: data.paymentUrl.toString()));
          Get.to( const PaymentWebView(url:'https://bdtaxation.com/api/order/1748/payment?payment_method=bkash' ),);
        } else {
          isLoading.value = false;
          CustomSnackBar.showCustomToast(title: "Something Went Wrong!", message: response.data["message"].toString());
        }
      },
    );

  }

  //

  RxInt selectedPayment = 0.obs;
  RxString selectedPaymentMethod = RxString("BKASH"); // Default selected index

  void setSelectedPayment(int index) {
    selectedPayment.value = index;
    switch (selectedPayment.value) {
      case 0:
        selectedPaymentMethod.value = "BKASH";
        break;
      case 1:
        selectedPaymentMethod.value = "NAGAD";
        break;
      case 2:
        selectedPaymentMethod.value = "SSLCOMMERZ";
        break;
      default:
        selectedPaymentMethod.value = "BKASH";
        break;
    }
  }
  //
  // RxObjectMixin<CouponModel> couponModel =
  //     CouponModel(discount: "0", status: false, finalAmount: " 0").obs;
  //
  // Future<void> postCoupon(String couponCode, String price, context) async {
  //   String? token = MySharedPref.getUserToken();
  //   String url = AppUrl.couponCode;
  //   NetworkApiServices networkApiServices = NetworkApiServices();
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   Map<String, dynamic> data = {
  //     'code': couponCode,
  //     'amount': price,
  //     'model': "Package",
  //   };
  //   var response =
  //       await networkApiServices.postApi(data, url, headers: headers);
  //   if (kDebugMode) {
  //     print("response: ${response["finalAmount"]}");
  //   }
  //   if (response["status"]) {
  //     log(" Coupon Done");
  //     CouponModel cm = CouponModel.fromJson(response);
  //     couponModel.value = cm;
  //     Utils.toastMessage(response["message"]);
  //   } else if (!response["status"]) {
  //     couponModel.value =
  //         CouponModel(discount: "0", status: false, finalAmount: " 0");
  //     //     : "কিছু ভুল হয়েছে। দয়া করে আবার চেষ্টা করুন।";
  //     showErrorDialog(context, response);
  //   } else {
  //     couponModel.value =
  //         CouponModel(discount: "0", status: false, finalAmount: " 0");
  //     Utils.snackBar("Something Went Wrong!", "");
  //   }
  // }
  //
  // void updateCoupon() {
  //   if (!isChecked.value) {
  //     couponModel.value =
  //         CouponModel(discount: "0", status: false, finalAmount: " 0");
  //     couponController.text = "";
  //   }
  // }
}
