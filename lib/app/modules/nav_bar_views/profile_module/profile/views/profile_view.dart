import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../config/constants/app_images.dart';
import '../../../../../../config/theme/light_theme_colors.dart';
import '../../../../../../styles/text_style.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        spacing: 5.h,
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
          const Text(
            'Sadman',
            style: AppTextStyles.body,
          ),
          10.h.height,
          CustomProfileButton(
            onTap: () {},
            text: 'একাউন্ট',
            icon: Icons.edit_note_rounded,
          ),
          CustomProfileButton(
            onTap: () {},
            text: 'সাবস্ক্রিপশন',
            icon: Icons.edit_note_rounded,
          ),
          CustomProfileButton(
            onTap: () {},
            text: 'আপগ্রেড',
            icon: Icons.edit_note_rounded,
          ),
          CustomProfileButton(
            onTap: () {},
            text: 'সাপোর্ট',
            icon: Icons.edit_note_rounded,
          ),
          CustomProfileButton(
            onTap: () {},
            text: 'রিভিউ',
            icon: Icons.edit_note_rounded,
          ),
          CustomProfileButton(
            onTap: () {},
            text: 'লগ আউট',
            icon: Icons.edit_note_rounded,
          ),
        ],
      ).paddingAll(8.0.r),
    );
  }
}

class CustomProfileButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final IconData icon;

  const CustomProfileButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.blue),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 11.0,
            ),
            5.w.width,
          ],
        ),
      ),
    );
  }
}
