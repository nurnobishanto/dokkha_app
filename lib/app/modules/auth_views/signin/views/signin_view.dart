import 'package:cached_network_image/cached_network_image.dart';
import 'package:dokkha/app/components/custom_action_button.dart';
import 'package:dokkha/app/components/custom_decision_button.dart';
import 'package:dokkha/config/constants/app_images.dart';
import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:dokkha/config/extensions/widget_extensions.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:dokkha/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../../../utils/utils.dart';
import '../controllers/signin_controller.dart';

class SignInView extends GetView<SigninController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 10.0.h,
          children: [
            Image.asset(AssetImagePaths.appIcon, scale: 8.0),
            const Text(
              "শূন্য হাওয়ার শূন্য ভরিতে বুকখানি করি শুনো",
              style: AppTextStyles.heading,
            ),
            17.height,
            Text(
              "কোনো রেজিস্ট্রেশন এর প্রয়োজন নেই সরাসরি লগইন করুন",
              style: AppTextStyles.custom(color: LightThemeColors.primaryColor),
            ),
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
              onPressed: () {},
            ),
            CustomActionButton(text: "text", onPressed: () {})
          ],
        ).paddingAll(8.00.r),
      ),
    );
  }
}
