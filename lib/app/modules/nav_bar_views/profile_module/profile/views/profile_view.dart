import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokkha/app/modules/navbar/controllers/navbar_controller.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../../../config/constants/app_images.dart';
import '../../../../../../config/theme/light_theme_colors.dart';
import '../../../../../../styles/text_style.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final navBarController = Get.put(NavbarController());
    // if(navBarController.profileDataModel.value.data != null){
    //   print("Valueeee");
    // }else{
    //   print("Nullllll is");
    // }
    var profileData = navBarController.profileDataModel.value.data!;

    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          return Column(
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
                    child: CircleAvatar(
                      radius: 48.0.r,
                      backgroundColor: Colors.white,
                      backgroundImage: (profileData.image != null &&
                              profileData.image.isNotEmpty)
                          ? CachedNetworkImageProvider(
                              "${AppConstants.storageUrl}${profileData.image}",
                            )
                          : const CachedNetworkImageProvider(
                              "https://www.smeal.psu.edu/alumni/images/photo-not-available-176.jpg/image_view_fullscreen",
                            ),
                    ),
                  ),
                ),
              ),
              Text(
                navBarController.profileDataModel.value.data!.name ?? "no name",
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
                onTap: () {
                  controller.logout();
                },
                text: 'লগ আউট',
                icon: Icons.edit_note_rounded,
              ),
            ],
          ).paddingAll(8.0.r);
        }
      ),
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
              offset: const Offset(0, 1),
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
