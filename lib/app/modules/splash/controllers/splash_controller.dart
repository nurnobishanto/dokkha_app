import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/app_update_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint("Splash called initial");
    Future.delayed(const Duration(seconds: 2), () {
      final AppUpdateService appUpdateService = AppUpdateService();
      appUpdateService.startUpdateService();
      Get.offAllNamed(Routes.NAVBAR);
    });
  }
}
