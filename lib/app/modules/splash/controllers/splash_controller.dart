import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/config/constants/global.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      //Get.offAllNamed(Routes.AUTH_GATEWAY);
      // if (MySharedPref.getUserToken().isNotEmpty && MySharedPref.getUserToken() != ''&& isLoggedIn.value) {
      //   Get.offAllNamed(Routes.NAVBAR);
      // } else {
      //   Get.offAllNamed(Routes.AUTH_GATEWAY);
      // }
    });
  }
}
