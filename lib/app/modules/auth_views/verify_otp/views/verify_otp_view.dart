import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/config/constants/app_images.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  final String phoneNumber;
  final String type;

  // Constructor accepting both type and phoneNumber as arguments
  VerifyOtpView({super.key})
      : phoneNumber =
            Get.arguments['phoneNumber'], // Get the phone number from arguments
        type = Get.arguments['type']; // Get the type from arguments

  @override
  Widget build(BuildContext context) {
    controller.sendOtp(phoneNumber, type);
    //Get.find<VerifyOtpController>().sendOtp(phoneNumber, type);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetImagePaths.seamlessImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            120.h.height,
            Image.asset(AssetImagePaths.otpImg, scale: 1.9),
            Center(
              child: Text(
                "আপনার এই $phoneNumber ফোন নম্বর এ ৬ ডিজিটের OTP পাঠানো ভেরিফাই করুন",
                textAlign: TextAlign.center,
              ),
            ),
            10.h.height,
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
            10.h.height,
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "OTP পাচ্ছো না? ",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Resend OTP",
                      style: AppTextStyles.custom(
                        color: LightThemeColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.sendOtp(phoneNumber, type);
                          debugPrint("Resend OTP tapped!");
                        },
                    ),
                  ],
                ),
              ),
            ),
            50.h.height,
            CustomActionButton(
              text: "Verify",
              onPressed: () {
                Get.toNamed(Routes.NAVBAR);
              },
            ),
          ],
        ).paddingAll(8.00.r),
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
