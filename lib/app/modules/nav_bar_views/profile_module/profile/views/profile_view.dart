import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/helper/api_helper.dart';
import 'package:lokkha/app/modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import 'package:lokkha/app/modules/nav_bar_views/profile_module/favorite_question/views/fav_question.dart';
import 'package:lokkha/app/routes/app_pages.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../../../styles/text_style.dart';
import '../../../../../helper/global.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Obx(() {
      final token = MySharedPref.getUserToken();
      final isTokenValid = token.isNotEmpty;
      if (!isLoggedIn.value || !isTokenValid) {
        debugPrint("Error: Not logged in or token missing. isLoggedIn: ${isLoggedIn.value}");
        return const AuthGatewayView();
      }


      final profileData = profileDataModel.value.data;
      if (profileData == null) {
        debugPrint("🚫 data is null");
      } else {
        debugPrint("✅ data is present");
        debugPrint("🧑‍💼 Name: ${profileData.name}");
        debugPrint("📸 Image: ${profileData.image}");
        debugPrint("📧 Email: ${profileData.email}");
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile View"),
        ),
        body: profileData == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(8.0.r),
                child: Column(
                  spacing: 5.00.h,
                  children: [
                    10.h.height,
                    CachedNetworkImage(
                      imageUrl:
                          "${AppConstants.storageUrl}${profileData.image}",
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 48.0.r,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => CircleAvatar(
                        radius: 48.0.r,
                        backgroundImage: const NetworkImage(
                            "https://media.istockphoto.com/id/827247322/vector/danger-sign-vector-icon-attention-caution-illustration-business-concept-simple-flat-pictogram.jpg?s=612x612&w=0&k=20&c=BvyScQEVAM94DrdKVybDKc_s0FBxgYbu-Iv6u7yddbs="),
                      ),
                    ),
                    10.h.height,
                    Text(
                      profileData.name ?? "no name",
                      style: AppTextStyles.body1,
                    ),
                    10.h.height,
                    ...[
                      // CustomProfileButton(
                      //   onTap: () {},
                      //   text: 'একাউন্ট',
                      //   icon: Icons.edit_note_rounded,
                      // ),
                      CustomProfileButton(
                        onTap: () => Get.toNamed(Routes.PROFILE_UPDATE),
                        text: 'প্রোফাইল আপডেট করুন',
                        icon: Icons.edit_note_rounded,
                      ),
                      // CustomProfileButton(
                      //   onTap: () {},
                      //   text: 'সকল প্যাকেজ',
                      //   icon: Icons.edit_note_rounded,
                      // ),
                      CustomProfileButton(
                        onTap: () {

                          Get.to(const FavQuestionListScreen());

                        },
                        text: 'ফেভারিট প্রশ্ন',
                        icon: Icons.edit_note_rounded,
                      ),
                      // CustomProfileButton(
                      //   onTap: () {},
                      //   text: 'অর্ডারস হিস্ট্রি',
                      //   icon: Icons.edit_note_rounded,
                      // ),
                      // CustomProfileButton(
                      //   onTap: () {},
                      //   text: 'রিভিউ',
                      //   icon: Icons.edit_note_rounded,
                      // ),
                      CustomProfileButton(
                        onTap: controller.logout,
                        text: 'লগ আউট',
                        icon: Icons.edit_note_rounded,
                      ),
                    ]
                  ],
                ),
              ),
      );
    });
  }
}

// class ProfileView extends GetView<ProfileController> {
//   const ProfileView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     if (isLoggedIn.value) {
//       getMeProfileInfo();
//       debugPrint('TEST VIEW');
//     }
//     var profileData = profileDataModel.value.data;
//     return !isLoggedIn.value
//         ? const AuthGatewayView()
//         : Scaffold(
//             appBar: AppBar(),
//             body: Obx(() {
//               return Column(
//                 spacing: 5.h,
//                 children: [
//                   10.h.height,
//                   Center(
//                     child: CircleAvatar(
//                       radius: 50.0.r,
//                       backgroundColor: LightThemeColors.primaryColor,
//                       child: CircleAvatar(
//                         radius: 48.0.r,
//                         backgroundColor: Colors.white,
//                         child: CircleAvatar(
//                           radius: 48.0.r,
//                           backgroundColor: Colors.white,
//                           backgroundImage: (profileData!.image != null &&
//                                   profileData.image.isNotEmpty)
//                               ? CachedNetworkImageProvider(
//                                   "${AppConstants.storageUrl}${profileData.image}",
//                                 )
//                               : const CachedNetworkImageProvider(
//                                   "https://www.smeal.psu.edu/alumni/images/photo-not-available-176.jpg/image_view_fullscreen",
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     profileDataModel.value.data!.name ?? "no name",
//                     style: AppTextStyles.body1,
//                   ),
//                   10.h.height,
//                   CustomProfileButton(
//                     onTap: () {},
//                     text: 'একাউন্ট',
//                     icon: Icons.edit_note_rounded,
//                   ),
//                   CustomProfileButton(
//                     onTap: () {
//                       Get.toNamed(Routes.PROFILE_UPDATE);
//                     },
//                     text: 'প্রোফাইল আপডেট করুন',
//                     icon: Icons.edit_note_rounded,
//                   ),
//                   CustomProfileButton(
//                     onTap: () {},
//                     text: 'সাবস্ক্রিপশন',
//                     icon: Icons.edit_note_rounded,
//                   ),
//                   CustomProfileButton(
//                     onTap: () {},
//                     text: 'আপগ্রেড',
//                     icon: Icons.edit_note_rounded,
//                   ),
//                   CustomProfileButton(
//                     onTap: () {},
//                     text: 'সাপোর্ট',
//                     icon: Icons.edit_note_rounded,
//                   ),
//                   CustomProfileButton(
//                     onTap: () {},
//                     text: 'রিভিউ',
//                     icon: Icons.edit_note_rounded,
//                   ),
//                   CustomProfileButton(
//                     onTap: () {
//                       controller.logout();
//                     },
//                     text: 'লগ আউট',
//                     icon: Icons.edit_note_rounded,
//                   ),
//                 ],
//               ).paddingAll(8.0.r);
//             }),
//           );
//   }
// }

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
