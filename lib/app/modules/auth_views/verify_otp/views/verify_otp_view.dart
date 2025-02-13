import 'package:dokkha/config/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  final String phoneNumber;
  VerifyOtpView({super.key}) : phoneNumber = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetImagePaths.seamlessImg),
            fit: BoxFit.cover,
          ),
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3), // Adjust opacity
            BlendMode.darken, // Blend mode for effect
          ),
          child: Column(
            children: [
              Image.asset(AssetImagePaths.otpImg, scale: 1.5),
              const Center(
                child: Text(
                  "AppConstant.checkYourPhoneNumber.tr",
                ),
              ),
              Pinput(
                length: 6,
                defaultPinTheme: _myOTPTheme,
                focusedPinTheme: _selectOTPTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  // signInController.otp.value = pin;
                  // signUPController.otp.value = pin;
                },
                onChanged: (pin) {
                  debugPrint('Pin Changed: $pin');
                },
                // autofillHints: const [AutofillHints.oneTimeCode],
              ),
            ],
          ).paddingAll(8.00.r),
        ),
      ),
    );
  }
}

final PinTheme _myOTPTheme = PinTheme(
  height: 50.0,
  width: 50.0,
  textStyle: const TextStyle(
    fontSize: 20.0,
    color: LightThemeColors.primary,
    fontWeight: FontWeight.w500,
  ),
  decoration: BoxDecoration(
    //color: LightThemeColors.scaffoldBackgroundColor,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.black),
  ),
);

final PinTheme _selectOTPTheme = PinTheme(
  height: 50.0,
  width: 50.0,
  textStyle: const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: LightThemeColors.primary),
  ),
);
