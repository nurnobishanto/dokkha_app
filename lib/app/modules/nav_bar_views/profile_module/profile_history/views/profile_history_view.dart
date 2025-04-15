import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../config/constants/app_images.dart';
import '../../../../../../config/theme/light_theme_colors.dart';
import '../../../../../../styles/text_style.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/profile_history_controller.dart';

class ProfileHistoryView extends GetView<ProfileHistoryController> {
  const ProfileHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //Get.toNamed(Routes.PROFILE_UPDATE);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: GetBuilder(
          init: ProfileHistoryController(),
          builder: (context) {
            return Column(
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
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 1.4,
                  ),
                  itemCount:
                      controller.items.length, // Ensure itemCount is provided
                  itemBuilder: (context, i) {
                    return customInfoCard(
                      controller.items[i].toString(),
                      controller.value[i].toString(),
                      Colors.black.withValues(alpha: .7),
                    );
                  },
                ),
                3.h.height,

                /// Badge
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ব্যাজ",
                    style: AppTextStyles.custom(
                      fontSize: 17.00.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                3.h.height,
                Row(
                  spacing: 15.0.w,
                  children: [
                    Image.asset(AssetImagePaths.badgeImg, scale: 8),
                    Image.asset(AssetImagePaths.badgeImg, scale: 8),
                    Image.asset(AssetImagePaths.badgeImg, scale: 8),
                    Image.asset(AssetImagePaths.badgeImg, scale: 8),
                    Image.asset(AssetImagePaths.badgeImg, scale: 8),
                  ],
                )
              ],
            ).paddingAll(8.0.h);
          }),
    );
  }
}

Widget customInfoCard(String value, String title, Color color) {
  return Container(
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
