
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';

import '../../../../../styles/text_style.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../helper/global.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_call_status.dart';
import '../../../../views/widgets/web_exam_view.dart';
import '../../../auth_views/auth_gateway/views/auth_gateway_view.dart';
import '../../../drawer_pages/views/customer_support_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FA),
      appBar: CustomAppBar(
        title: 'প্রোফাইল',
        centerTitle: true,
      ),
      body: Obx(() {
        final status = controller.profileApiStatus.value;
        final profileData = myUser;
        if (status == ApiCallStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!isLoggedIn.value || MySharedPref.getUserToken().isEmpty) {
          return const AuthGatewayView();
        }


        if (status == ApiCallStatus.error || profileData == null) {
          return const Center(child: Text("তথ্য লোড করা সম্ভব হয়নি"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER CARD ---
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    buildAvatar(myUser, radius: 45.r),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                profileData.name ?? "User Name",
                                style: AppTextStyles.body1.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (havePackage.value) ...[
                                SizedBox(width: 6.w),
                                Icon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: 13.sp,
                                  color: LightThemeColors.primaryColor,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "আইডি: ${profileData.userId ?? ""}",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 13.sp),
                          ),
                          Text(
                            profileData.phone ?? "ফোন নম্বর নেই",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.toNamed(Routes.PROFILE_UPDATE),
                      icon: const Icon(FontAwesomeIcons.userPen,
                          size: 18, color: LightThemeColors.primaryColor,),
                    )
                  ],
                ),
              ),

              SizedBox(height: 24.h),
              _buildSectionLabel("আপনার ড্যাশবোর্ড"),

              // --- GRID OPTIONS ---
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 2,
                children: [
                  _buildGridItem(
                    onTap: () => Get.toNamed(Routes.MY_PACKAGES),
                    text: 'আমার প্যাকেজ',
                    icon: FontAwesomeIcons.boxOpen,
                    color: Colors.orange,
                  ),
                  _buildGridItem(
                    onTap: () => Get.toNamed(Routes.MY_COURSES),
                    text: 'আমার কোর্স',
                    icon: FontAwesomeIcons.graduationCap,
                    color: Colors.purple,
                  ),
                  _buildGridItem(
                    onTap: () => Get.to(WebExamView(
                        title: "Favourite Question",
                        url: AppConstants.myQuestions)),
                    text: 'ফেভারিট প্রশ্ন',
                    icon: FontAwesomeIcons.solidHeart,
                    color: Colors.redAccent,
                  ),
                  _buildGridItem(
                    onTap: () => Get.toNamed(Routes.MY_ORDERS),
                    text: 'আমার অর্ডারস',
                    icon: FontAwesomeIcons.receipt,
                    color: Colors.teal,
                  ),
                ],
              ),

              SizedBox(height: 24.h),
              _buildSectionLabel("অন্যান্য"),

              // --- LIST OPTIONS ---
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    _buildListItem(
                      onTap: () {
                        Get.defaultDialog(
                          title: "অ্যাকাউন্ট ডিলিট",
                          middleText: "কাস্টমার সার্ভিসের সাথে যোগাযোগ করুন।",
                          onConfirm: () {
                            Get.back();
                            Get.to(const CustomerSupportView());
                          },
                        );
                      },
                      text: 'অ্যাকাউন্ট ডিলিট করুন',
                      icon: FontAwesomeIcons.trashCan,
                      color: Colors.red,
                    ),
                    const Divider(height: 0, indent: 50),
                    _buildListItem(
                      onTap: () {
                        Get.defaultDialog(
                          title: "লগ আউট",
                          titleStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          middleText: "আপনি কি নিশ্চিতভাবে লগ আউট করতে চান?",
                          middleTextStyle: TextStyle(fontSize: 14.sp),
                          textConfirm: "হ্যাঁ",
                          textCancel: "না",
                          confirmTextColor: Colors.white,
                          cancelTextColor: Colors.black,
                          buttonColor: Colors.redAccent,
                          onConfirm: () {
                            Get.back();
                            controller.logout();
                          },
                        );
                      },
                      text: 'লগ আউট',
                      icon: FontAwesomeIcons.arrowRightFromBracket,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w, bottom: 12.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey[800],
        ),
      ),
    );
  }

  Widget _buildGridItem({
    required VoidCallback onTap,
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18.sp),
              SizedBox(height: 8.h),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem({
    required VoidCallback onTap,
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color, size: 18.sp),
      title: Text(
        text,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    );
  }
}
