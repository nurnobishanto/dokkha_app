import 'package:flutter/material.dart';
import 'package:dokkha/app/components/custom_decision_button.dart';
import 'package:dokkha/config/constants/app_images.dart';
import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:dokkha/styles/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class OnboardingView extends GetView {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 10.0.h,
          children: [
            Image.asset(AssetImagePaths.appIcon, scale: 8.0),
            const Text(
              "এক টাকা দিয়ে লক্ষ্যে পৌঁছান",
              style: AppTextStyles.heading,
            ),
            Text(
              "কোনো রেজিস্ট্রেশন এর প্রয়োজন নেই সরাসরি লগইন করুন",
              style: AppTextStyles.custom(color: LightThemeColors.primaryColor),
            ),
            50.h.height,
            DecisionButton(
              text: "Sign in with google",
              leadingWidget: const FaIcon(FontAwesomeIcons.google, size: 20),
              onPressed: () {},
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
                Get.toNamed(Routes.SIGNIN);
              },
            ),
            const Spacer(),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'by logging in you agree to our',
                  style: AppTextStyles.custom(fontSize: 11.0.sp),
                ),
                TextSpan(
                  text: ' Terms & Conditions',
                  style: AppTextStyles.custom(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('tapped');
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
