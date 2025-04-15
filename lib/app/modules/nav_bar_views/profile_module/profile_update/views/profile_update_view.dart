import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/components/custom_drop_down_button.dart';
import 'package:lokkha/app/components/custom_text_form_field.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/styles/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../config/constants/app_images.dart';
import '../../../../../helper/api_helper.dart';
import '../../../../navbar/controllers/navbar_controller.dart';
import '../controllers/profile_update_controller.dart';

class ProfileUpdateView extends GetView<ProfileUpdateController> {
  const ProfileUpdateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        title: Text(
          'প্রোফাইল আপডেট করুন',
          style: kHeadingTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: LightThemeColors.primary,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              15.h.height,
              const Text(
                'নাম',
                style: AppTextStyles.body,
              ),
              2.h.height,
              CustomTextFormField(
                controller: controller.nameController,
                hintText: 'আপনার নাম লিখুন',
              ),
              10.h.height,
              const Text(
                'ইমেইল',
                style: AppTextStyles.body,
              ),
              2.h.height,
              CustomTextFormField(
                controller: controller.emailController,
                hintText: 'আপনার ইমেইল ঠিকানা লিখুন',
              ),
              10.h.height,
              const Text("জন্ম তারিখ", style: AppTextStyles.body),
              2.h.height,
              CustomTextFormField(
                hintText: controller.dob.value.trim().isEmpty
                    ? profileDataModel
                    .value
                    .data!
                    .dateOfBirth
                    .toString()
                    .split(' ')
                    .first
                    : controller.dob.value,
                readOnly: true,
                onTap: () => controller.selectDate(context),
              ),

              10.h.height,
              const Text(
                'লিঙ্গ',
                style: AppTextStyles.body,
              ),
              2.h.height,
              CustomDropdownButton(
                items: const ["পুরুষ", 'মহিলা', 'অন্যান্য'],
                dropdownValue: controller.gender.value,
                onChanged: (v) {
                  controller.gender.value = v!;
                },
              ),
              10.h.height,
              const Text(
                'পেশা',
                style: AppTextStyles.body,
              ),
              2.h.height,
              CustomTextFormField(
                controller: controller.occupationController,
                hintText: 'পেশা প্রদর্শিত হবে',
              ),
              10.h.height,
              const Text(
                'প্রতিষ্ঠান',
                style: AppTextStyles.body,
              ),
              2.h.height,
              CustomTextFormField(
                controller: controller.organizationController,
                hintText: 'প্রতিষ্ঠানের নাম প্রদর্শিত হবে',
              ),
              20.h.height,
              const Text(
                'পাসওয়ার্ড',
                style: AppTextStyles.heading,
              ),
              10.h.height,
              const Text(
                'পরিবর্তন করতে না চাইলে এই অংশ ফাঁকা রাখুন',
                style: AppTextStyles.body,
              ),
              5.h.height,
              const Text(
                'নতুন পাসওয়ার্ড',
                style: AppTextStyles.body,
              ),
              3.h.height,
              CustomTextFormField(
                controller: controller.pwdController,
                hintText: 'নতুন পাসওয়ার্ড লিখুন',
                obscureText: true,
              ),
              5.h.height,
              const Text(
                'পাসওয়ার্ড নিশ্চিত করুন',
                style: AppTextStyles.body,
              ),
              3.h.height,
              CustomTextFormField(
                controller: controller.confirmPwdController,
                hintText: 'পুনরায় পাসওয়ার্ড লিখুন',
                obscureText: true,
              ),
              20.h.height,
              CustomActionButton(
                text: "আপডেট করুন",
                onPressed: () {
                  controller.updateProfileInfo(context);
                },
              ),
              30.h.height,
            ],
          ),
        ),
      ),
    );
  }
}
