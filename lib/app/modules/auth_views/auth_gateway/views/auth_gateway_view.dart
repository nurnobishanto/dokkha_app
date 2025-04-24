import 'package:flutter/material.dart';
import 'package:lokkha/app/components/custom_decision_button.dart';
import 'package:lokkha/app/modules/auth_views/auth_gateway/views/social_login.dart';
import 'package:lokkha/config/constants/app_images.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/auth_gateway_controller.dart';

class AuthGatewayView extends GetView<AuthGatewayController> {
  const AuthGatewayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 8.0.h,
          children: [
            55.h.height,
            Image.asset(AssetImagePaths.appIcon, scale: 4.0),
            Text(
              "সঠিক পথ, স্বল্প খরচ",
              style: AppTextStyles.heading4,
            ),
            Text(
              "কোনো রেজিস্ট্রেশন এর প্রয়োজন নেই সরাসরি লগইন করুন",
              style: AppTextStyles.body1,
            ),
            50.h.height,
            DecisionButton(
              text: "Sign in with google",
              leadingWidget: const FaIcon(FontAwesomeIcons.google, size: 20),
              onPressed: () {
                Get.to(const SocialLoginWebView(
                  url: 'https://lokkha.com/api/auth/google/redirect',
                ));
              },
            ),
            DecisionButton(
              text: "Sign in with Facebook",
              leadingWidget: const FaIcon(FontAwesomeIcons.facebook, size: 20),
              onPressed: () {},
            ),
            DecisionButton(
              text: "Sign in with Phone",
              leadingWidget: const FaIcon(FontAwesomeIcons.phone, size: 20),
              onPressed: () {
                Get.toNamed(Routes.SIGN_UP);
                // if (controller.isRegister) {
                //   debugPrint("isRegister");
                //   Get.toNamed(Routes.SIGNIN);
                // } else {
                //   debugPrint("Not Register");
                //   Get.toNamed(Routes.SIGN_UP);
                // }
              },
            ),
            const Spacer(),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text:
                      'লগ ইন করে, আপনি আমাদের সাথে সম্মত হন।', // by logging in you agree to our
                  style: AppTextStyles.custom(fontSize: 11.0.sp),
                ),
                TextSpan(
                  text: ' শর্তাবলী ও নীতিমালা',
                  style: AppTextStyles.custom(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(Routes.TERMS_CONDITION);
                    },
                ),
              ]),
            ),
            Text(
              "Version 1.0.0",
              style: AppTextStyles.custom(fontSize: 11.0.sp),
            ),
          ],
        ).paddingAll(8.00.r),
      ),
    );
  }
}
