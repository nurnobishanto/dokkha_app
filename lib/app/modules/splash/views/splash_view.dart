import 'package:lokkha/config/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Splash Called");
    //Get.put(SplashController());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (_) => Center(
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetImagePaths.seamlessImg),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height / 5,
                    width: size.width / 1.7,
                    child: Image.asset(AssetImagePaths.appIcon),
                  ),
                  Text('সঠিক পথে, স্বল্প সময়ে', style: AppTextStyles.heading4.copyWith(color: LightThemeColors.primaryColor),textAlign: TextAlign.center,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
