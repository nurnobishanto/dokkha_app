import 'package:dokkha/config/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Splash Called");
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (_) => SizedBox(
              height: size.height / 5,
              width: size.width / 1.7,
              child: Image.asset(AssetImagePaths.appIcon)),
        ),
      ),
    );
  }
}
