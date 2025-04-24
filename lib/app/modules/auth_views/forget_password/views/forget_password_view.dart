import 'package:lokkha/app/components/custom_text_form_field.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../../../../components/custom_action_button.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.0.h,
          children: [
            20.0.h.height,
            Center(
              child: Text(
                'পাসওয়ার্ড ভুলে গেছেন?',
                style: AppTextStyles.heading1
                    .copyWith(color: LightThemeColors.primaryColor),
              ),
            ),
            const Text(
              "আপনার ফোন নম্বর এ ৬ ডিজিটের OTP পাঠানো ভেরিফাই করুন",
              textAlign: TextAlign.center,
            ),

            const CustomTextFormField(
              controller: null,
              prefixIcon: Icon(FontAwesomeIcons.phone),
              hintText: "আপনার ১১ সংখ্যার ফোন নম্বর লিখুন",
            ),

            CustomActionButton(
              text: "Verify",
              onPressed: () {
                Get.toNamed(Routes.HOME);
              },
            ),
          ],
        ).paddingAll(8.00.r),
      ),
    );
  }
}
