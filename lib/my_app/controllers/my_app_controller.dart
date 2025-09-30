import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../app/helper/global.dart';
import '../../app/services/auth_service.dart';

class MyAppController extends GetxController {
  // final AuthService _authService = AuthService();
  RxString appVersion = ''.obs;

  @override
  void onReady() {
    super.onReady();
    debugPrint("MyApp Controller Called");
    _initializeApp();
  }

  void _initializeApp() async {
    // await _authService.authCheck();
    await fetchAppVersion();
  }
}
