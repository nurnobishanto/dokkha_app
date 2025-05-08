import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/app_update_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("Splash called initial");
    Future.delayed(const Duration(seconds: 1), () {
      final AppUpdateService appUpdateService = AppUpdateService();
      appUpdateService.startUpdateService();
      Get.offAllNamed(Routes.NAVBAR);
      // if (MySharedPref.getUserToken().isNotEmpty && MySharedPref.getUserToken() != ''&& isLoggedIn.value) {
      //   Get.offAllNamed(Routes.NAVBAR);
      // } else {
      //   Get.offAllNamed(Routes.AUTH_GATEWAY);
      // }
    });
  }
}
