import 'package:dokkha/app/components/custom_action_button.dart';
import 'package:dokkha/app/components/custom_text_form_field.dart';
import 'package:dokkha/config/constants/app_images.dart';
import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:dokkha/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: SignInController(),
            builder: (x) {
              return SafeArea(
                child: Column(
                  spacing: 5.00.h,
                  children: [
                    40.height,
                    Image.asset(AssetImagePaths.appIcon, scale: 8.0),
                    const Text("শূন্য হাওয়ার শূন্য ভরিতে বুকখানি করি শুনো",
                        style: AppTextStyles.heading,
                        textAlign: TextAlign.center),
                    Text(
                      "কোনো রেজিস্ট্রেশন এর প্রয়োজন নেই সরাসরি লগইন করুন",
                      style: AppTextStyles.custom(
                          color: LightThemeColors.primaryColor),
                    ),
                    100.h.height,
                    Text(
                      "আপনার ফোন নম্বর দিয়ে লগইন করুন",
                      style: AppTextStyles.custom(
                        fontSize: 17.00.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    2.0.h.height,
                    CustomTextFormField(
                      controller: controller.phoneController,
                      prefixIcon: const Icon(FontAwesomeIcons.phone),
                      hintText: "Enter you 11 digit phone number",
                    ),
                    1.0.h.height,
                    controller.isRegister
                        ? CustomTextFormField(
                            controller: controller.passwordController,
                            prefixIcon: const Icon(FontAwesomeIcons.lock),
                            hintText: "Enter your password",
                            obscureText: true,
                          )
                        : const SizedBox.shrink(),
                    1.0.h.height,
                    CustomActionButton(
                      text: "Continue",
                      onPressed: () {
                        debugPrint(controller.phoneController.text);
                        Get.toNamed(Routes.VERIFY_OTP,
                            arguments: controller.phoneController.text);
                      },
                    ),
                  ],
                ).paddingAll(8.00.r),
              );
            }));
  }
}
