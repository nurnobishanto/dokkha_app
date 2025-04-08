import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/components/custom_text_form_field.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import '../controllers/profile_update_required_controller.dart';

class ProfileUpdateRequiredView
    extends GetView<ProfileUpdateRequiredController> {
  const ProfileUpdateRequiredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('চলুন শুরু করি!')),
      body: GetBuilder<ProfileUpdateRequiredController>(
          init: ProfileUpdateRequiredController(),
          builder: (_) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  5.0.h.height,
                  const Text("নাম"),
                  CustomTextFormField(
                    controller: controller.nameController,
                    hintText: 'নাম',
                  ),
                  const Text("জন্ম তারিখ"),
                  CustomTextFormField(
                    hintText: 'জন্ম তারিখ',
                    readOnly: true,
                    controller: controller.dobController,
                    onTap: () => controller.selectDate(context),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "লিঙ্গ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        children: ["male", "female", "others"].map((gender) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: gender,
                                groupValue: controller.gender,
                                visualDensity: const VisualDensity(
                                    horizontal: -4, vertical: -4),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (val) {
                                  controller.gender = val!;
                                  controller.update();
                                },
                              ),
                              Text(
                                gender == "male"
                                    ? "পুরুষ"
                                    : gender == "female"
                                        ? "মহিলা"
                                        : "অন্যান্য",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const Text("পেশা"),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          title: const Text("স্টুডেন্ট"),
                          value: "Student",
                          groupValue: controller.occupation,
                          onChanged: (val) {
                            controller.occupation = val!;
                            controller.update();
                          },
                        ),
                        RadioListTile(
                          title: const Text("চাকরিজীবী"),
                          value: "Job Holder",
                          groupValue: controller.occupation,
                          onChanged: (val) {
                            controller.occupation = val!;
                            controller.update();
                          },
                        ),
                        RadioListTile(
                          title: const Text("চাকরি খুঁজছেন"),
                          value: "Job Seeker",
                          groupValue: controller.occupation,
                          onChanged: (val) {
                            controller.occupation = val!;
                            controller.update();
                          },
                        ),
                      ],
                    ),
                  ),
                  25.h.height,
                  CustomActionButton(
                    text: "আপডেট করুন",
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }),
    );
  }
}
