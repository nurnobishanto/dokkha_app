import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../config/constants/app_images.dart';
import '../../../../../styles/text_style.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Column(
        spacing: 5.0.h,
        children: [
          10.h.height,
          Center(
            child: CircleAvatar(
              radius: 50.0.r,
              backgroundColor: LightThemeColors.primary,
              child: CircleAvatar(
                radius: 48.0.r,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(AssetImagePaths.appIcon),
              ),
            ),
          ),
          2.0.h.height,
          Text(
            "Sadman",
            style: AppTextStyles.custom(
              fontSize: 17.00.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Southeast University",
            style: AppTextStyles.custom(
              fontSize: 17.00.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(color: LightThemeColors.primaryColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customInfoCard('3452',
                  'বর্তমান রাঙ্ক', Colors.blue),
              customInfoCard('0',
                  'মোট পয়েন্ট', Colors.blue),
              customInfoCard('4',
                  'মোট পরীক্ষা', Colors.blue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customInfoCard('3452',
                  'বর্তমান রাঙ্ক', Colors.blue),
              customInfoCard('0',
                  'মোট পয়েন্ট', Colors.blue),
              customInfoCard('4',
                  'মোট পরীক্ষা', Colors.blue),
            ],
          ),
        ],
      ).paddingAll(8.0.h),
    );
  }
}

Widget customInfoCard(String title, String value, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
