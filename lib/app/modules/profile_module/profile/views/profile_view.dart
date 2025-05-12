import 'package:lokkha/app/modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import 'package:lokkha/app/routes/app_pages.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../styles/text_style.dart';
import '../../../../helper/global.dart';
import '../../../../services/api_call_status.dart';
import '../../favorite_question/views/fav_question_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return Obx(() {
      final status = controller.profileApiStatus.value;
      final profileData = myUser;

      if (!isLoggedIn.value) return const AuthGatewayView();

      switch (status) {
        case ApiCallStatus.loading:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );

        case ApiCallStatus.error:
          return const Scaffold(
              body: Center(child: Text("প্রোফাইল ডেটা লোড করতে ব্যর্থ হয়েছে")));

        case ApiCallStatus.success:
          if (profileData == null) {
            return const Scaffold(
              body: Center(child: Text("প্রোফাইল তথ্য পাওয়া যায়নি")),
            );
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("প্রোফাইল"),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(8.0.r),
              child: Column(
                spacing: 5.0,
                children: [
                  10.h.height,
                  // CachedNetworkImage(
                  //   imageUrl: "${AppConstants.storageUrl}${profileData.image}",
                  //   imageBuilder: (context, imageProvider) => CircleAvatar(
                  //     radius: 48.0.r,
                  //     backgroundImage: imageProvider,
                  //   ),
                  //   placeholder: (context, url) =>
                  //       const CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => CircleAvatar(
                  //     radius: 48.0.r,
                  //     backgroundImage: const NetworkImage(
                  //       "https://lokkha.com/uploads/files/shares/app/avatar.png",
                  //     ),
                  //   ),
                  // ),
                  buildAvatar(myUser,radius: 64),
                  10.h.height,
                  Text(
                    profileData.name ?? "no name",
                    style: AppTextStyles.body1,
                  ),
                  Text(
                   "আইডি: ${profileData.userId ?? ""}",
                    style: AppTextStyles.body1,
                  ),

                  10.h.height,
                  CustomProfileButton(
                    onTap: () => Get.toNamed(Routes.PROFILE_UPDATE),
                    text: 'প্রোফাইল আপডেট করুন',
                    icon: Icons.edit_note_rounded,
                  ),
                  CustomProfileButton(
                    onTap: () => Get.toNamed(Routes.MY_PACKAGES),
                    text: 'সকল প্যাকেজ',
                    icon: Icons.edit_note_rounded,
                  ),
                  CustomProfileButton(
                    onTap: () => Get.to(const FavQuestionListScreen()),
                    text: 'ফেভারিট প্রশ্ন',
                    icon: Icons.edit_note_rounded,
                  ),
                  CustomProfileButton(
                    onTap: () => Get.toNamed(Routes.MY_ORDERS),
                    text: 'অর্ডারস হিস্ট্রি',
                    icon: Icons.edit_note_rounded,
                  ),
                  CustomProfileButton(
                    onTap: controller.logout,
                    text: 'লগ আউট',
                    icon: Icons.edit_note_rounded,
                  ),
                ],
              ),
            ),
          );

        default:
          return const SizedBox();
      }
    });
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
