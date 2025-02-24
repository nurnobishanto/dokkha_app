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
      // drawer: const TemCustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.h.height, // Space at the top
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
              20.h.height, // Space below the avatar

              // Show the user Name
              const Text(
                'Name',
                style: AppTextStyles.body,
              ),
              2.h.height,
              const CustomTextFormField(
                controller: null,
                hintText: 'No update Name',
              ),
              10.h.height,

              // Email
              const Text(
                'Email',
                style: AppTextStyles.body,
              ),
              2.h.height,
              const CustomTextFormField(
                controller: null,
                hintText: 'No update email',
              ),
              10.h.height,

              // Gender
              const Text(
                'Gender',
                style: AppTextStyles.body,
              ),
              2.h.height,
              CustomDropdownButton(
                items: const ["Male", 'Female'],
                dropdownValue: controller.genderDropDownValue,
                onChanged: (v) {
                  controller.genderDropDownValue = v!;
                },
              ),
              10.h.height,

              // Phone
              const Text(
                'Phone',
                style: AppTextStyles.body,
              ),
              2.h.height,
              const CustomTextFormField(
                controller: null,
                readOnly: true,
                hintText: '017********',
              ),
              20.h.height, // Space below the phone input field

              // Password Area
              const Text(
                'পাসওয়ার্ড',
                style: AppTextStyles.heading,
              ),
              10.h.height, // Space below the password heading
              const Text(
                'পরিবর্তন করতে না চাইলে খালি রাখো',
                style: AppTextStyles.body,
              ),
              5.h.height, // Space before the password input field
              const Text(
                'New Password',
                style: AppTextStyles.body,
              ),
              3.h.height, // Space between the text and the input field
              const CustomTextFormField(
                controller: null,
                hintText: 'No update Mail',
                obscureText: true,
              ),
              5.h.height, // Space below the new password input field

              const Text(
                'Confirm Password',
                style: AppTextStyles.body,
              ),
              3.h.height, // Space between the text and the input field
              const CustomTextFormField(
                controller: null,
                hintText: 'No update Mail',
                obscureText: true,
              ),
              20.h.height, // Space below the confirm password input field

              CustomActionButton(text: "Update", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
