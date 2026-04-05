import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/services/base_client.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../helper/global.dart';
import '../models/notification_model.dart';

class NotificationsController extends GetxController {
  Rx<NotificationModel> model = NotificationModel().obs;

  RxBool isLoading = true.obs;
  String? deviceId;

  Future<void> fetchNotifications() async {
    if (kDebugMode) print("fetchNotifications API  Called...");
    String? token = MySharedPref.getUserToken();
    isLoading.value = true;
    update();

    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = "${AppConstants.notifications}?device_id=$deviceId";

    BaseClient.safeApiCall(url, RequestType.get, headers: headers,
        onSuccess: (response) {
      if (response.data["status"] == true) {
        model.value = NotificationModel.fromJson(response.data);
        unReadNotificationCount.value = model.value.unreadCount!;
        isLoading.value = false;
      } else {
        if (kDebugMode) print("API status false");
        isLoading.value = false;
        CustomSnackBar.showCustomToast(
            title: "Something Went Wrong!",
            message: response.data["message"].toString());
      }
    }, onError: (err) {
      isLoading.value = false;
      if (kDebugMode) print("Error fetching Notifications: $err");
    });
  }

  Future<void> markAsRead(int notificationId, bool isRead) async {
    String? token = MySharedPref.getUserToken();

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final url = "${AppConstants.notifications}/$notificationId/read";
    final data = {'device_id': deviceId, 'is_read': isRead};

    BaseClient.safeApiCall(url, RequestType.post, headers: headers, data: data,
        onSuccess: (response) {
      if (response.data['status']) {
        debugPrint("Success");
        fetchNotifications();
        model.refresh();
      } else {
        if (kDebugMode) print("API status false");
        isLoading.value = false;
        CustomSnackBar.showCustomToast(
            title: "Something Went Wrong!",
            message: response.data["message"].toString());
      }
    }, onError: (err) {
      isLoading.value = false;
      if (kDebugMode) print("Error fetching Notifications: $err");
    });
  }

  @override
  void onInit() async {
    deviceId = await getDeviceId();
    debugPrint("Device ID: $deviceId");
    fetchNotifications();
    super.onInit();
  }
}
