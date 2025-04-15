import 'package:get/get.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/helper/global.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("Splash called initial");
    //Future.delayed(const Duration(seconds: 10), () {
    //  print("Splash called After 10 Second");
    //     //Get.offAllNamed(Routes.AUTH_GATEWAY);
    //     // if (MySharedPref.getUserToken().isNotEmpty && MySharedPref.getUserToken() != ''&& isLoggedIn.value) {
    //     //   Get.offAllNamed(Routes.NAVBAR);
    //     // } else {
    //     //   Get.offAllNamed(Routes.AUTH_GATEWAY);
    //     // }
    //});
  }
}
