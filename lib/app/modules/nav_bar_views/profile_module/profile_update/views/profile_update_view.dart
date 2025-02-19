import 'package:dokkha/app/components/custom_action_button.dart';
import 'package:dokkha/app/components/custom_drop_down_button.dart';
import 'package:dokkha/app/components/custom_text_form_field.dart';
import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:dokkha/styles/text_style.dart';
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
          'AppConstant.updateProfileInfo.tr',
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
              20.h.height,
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
              //  *********************** Show the user Name **************************
              const SizedBox(height: 40.0),
              // Text full name Filed
              const Text(
                'Name',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 5.0),
              const CustomTextFormField(
                controller: null,
                hintText: 'No update Name',
              ),

              const SizedBox(height: 10.0),
              const Text(
                'School/Collage',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 5.0),
              const CustomTextFormField(
                controller: null,
                hintText: 'No update school/collage',
              ),

              const SizedBox(height: 10.0),
              const Text(
                'Batch',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 5.0),
              CustomDropdownButton(
                items: ["A", 'B', 'C'],
                dropdownValue: controller.batchDropDownValue,
                onChanged: (v) {
                  controller.batchDropDownValue = v!;
                },
              ),

              const SizedBox(height: 10.0),
              const Text(
                'Type',
                style: AppTextStyles.body,
              ),
              5.h.height,
              CustomDropdownButton(
                items: const ["A", 'B', 'C'],
                dropdownValue: controller.batchDropDownValue,
                onChanged: (v) {
                  controller.batchDropDownValue = v!;
                },
              ),
              5.h.height,
              const Text(
                'Target',
                style: AppTextStyles.body,
              ),
              5.h.height,
              CustomDropdownButton(
                items: const ["A", 'B', 'C'],
                dropdownValue: controller.batchDropDownValue,
                onChanged: (v) {
                  controller.batchDropDownValue = v!;
                },
              ),
              5.h.height,
              const Text(
                'Difficult Questions',
                style: AppTextStyles.body,
              ),
              CupertinoRadio<String>(
                value: "b",

                groupValue: controller.groupValue,
                onChanged: (value) {
                  controller.groupValue = value!;
                },
              ),
              5.h.height,
              const SizedBox(height: 5.0),
              10.h.height,
              const Text(
                'Phone',
                style: AppTextStyles.body,
              ),
              const CustomTextFormField(
                controller: null,
                readOnly: true,
                hintText: '017********',
                //obscureText: true,
              ),
              5.h.height,

              /// Password Area
              const Text(
                'পাসওয়ার্ড',
                style: AppTextStyles.heading,
              ),
              10.h.height,
              const Text(
                'পরিবর্তন করতে না চাইলে খালি রাখো',
                style: AppTextStyles.body,
              ),
              5.h.height,
              const Text(
                'New Password',
                style: AppTextStyles.body,
              ),
              3.h.height,
              const CustomTextFormField(
                controller: null,
                hintText: 'No update Mail',
                obscureText: true,
              ),
              5.h.height,
              const Text(
                'Confirm Password',
                style: AppTextStyles.body,
              ),
              3.h.height,
              const CustomTextFormField(
                controller: null,
                hintText: 'No update Mail',
                obscureText: true,
              ),
              20.h.height,
              CustomActionButton(text: "Update", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
