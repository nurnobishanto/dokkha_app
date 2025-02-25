import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/components/custom_text_form_field.dart';
import 'package:lokkha/config/constants/app_images.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../sign_up/controllers/sign_up_controller.dart';
import '../controllers/signin_controller.dart';

class SignInView extends GetView<SignInController> {
  final String phoneNumber;
  final String type;

  SignInView({super.key})
      : phoneNumber = Get.arguments['phoneNumber'],
        type = Get.arguments['type'];

  @override
  Widget build(BuildContext context) {
    debugPrint('MY PHONE $phoneNumber');
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
                    const Text("এক টাকা দিয়ে লক্ষ্যে পৌঁছান",
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
                      //controller: controller.phoneController.text,
                      readOnly: true,
                      prefixIcon: const Icon(FontAwesomeIcons.phone),
                      hintText: phoneNumber,
                      //hintText: "আপনার ১১ সংখ্যার ফোন নম্বর লিখুন",
                    ),
                    1.0.h.height,
                    CustomTextFormField(
                      controller: controller.passwordController,
                      prefixIcon: const Icon(FontAwesomeIcons.lock),
                      hintText: "আপনার পাসওয়ার্ড লিখুন",
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          //Get.toNamed(Routes.FORGET_PASSWORD);
                          Get.toNamed(Routes.VERIFY_OTP, arguments: {
                            'phoneNumber': phoneNumber,
                            'type': type,
                          });
                        },
                        child: Text(
                          'OTP দিয়ে লগইন করুন!',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.custom(
                              color: LightThemeColors.primaryColor),
                        ),
                      ),
                    ),
                    1.0.h.height,
                    CustomActionButton(
                      text: "এগিয়ে যান",
                      isLoading: controller.isLoading,
                      onPressed: () {
                        controller.login(
                          phoneNumber,
                          type,
                          controller.passwordController.text,
                        );
                      },
                    ),
                  ],
                ).paddingAll(8.00.r),
              );
            }));
  }
}
