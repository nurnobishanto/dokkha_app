
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/controllers/home_controller.dart';
import 'package:lokkha/app/modules/subject_sections/views/sub_sec_set_time_view.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../components/custom_snackbar.dart';
import '../../../components/custom_text_field.dart';
import '../../../models/mock_subject_select_model.dart';
import '../../../models/subject.dart';
import '../controllers/subject_section_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import '../../../../../styles/text_style.dart';
import '../models/sub_sec_select_model.dart';

class SubjectSectionView extends GetView<SubjectSectionController> {
  final Subject? subject;
  const SubjectSectionView({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    Get.put(SubjectSectionController());
    final setNumberController = TextEditingController(text: "20");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "নির্বাচিত বিষয়গুলি",
          style: AppTextStyles.heading4.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: LightThemeColors.white),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20.00),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomExpandSubject(
                      subject: subject!,
                      topic: subject!,
                      padding: 0,
                      initialExpand: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.00),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: setNumberController,
                    hintText: "প্রশ্ন সংখ্যা সেট করুন",
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "This field is required";
                      }
                      final parsedValue = int.tryParse(val);
                      if (parsedValue == null) {
                        return "please enter valid number";
                      } else if (parsedValue < 5) {
                        return "Must be at least 10";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8.00),
                Expanded(
                  child: CustomActionButton(
                    text: "এগিয়ে যান",
                    onPressed: () async {
                      if (setNumberController.text.isNotEmpty) {
                        SubjectSectionSelect newSubject = SubjectSectionSelect(
                          id: subject?.id ?? 0,
                          name: subject?.name ?? '',
                          quantity: min(
                            int.tryParse(setNumberController.text)!.toInt(),
                            subject!.questionCount!.toInt(),
                          ),
                        );
                        await MySharedPref.addOrUpdateSubjectSectionSelect(
                            newSubject);
                        controller.getSubjects();
                        Get.to(const SubSectionsSetTimeView());
                      } else {
                        CustomSnackBar.showCustomErrorToast(
                            message: "please enter number of question!");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomExpandSubject extends StatelessWidget {
  final Subject subject;
  final Subject topic;
  final double padding;
  final bool initialExpand;

  const CustomExpandSubject(
      {super.key,
      required this.subject,
      required this.topic,
      required this.padding,
      required this.initialExpand});

  @override
  Widget build(BuildContext context) {
    final isExpanded = false.obs;
    return FutureBuilder<bool>(
      future: MySharedPref.isMockSubjectExist(topic.id!.toInt()),
      builder: (context, snapshot) {
        final isChecked = (snapshot.data ?? false).obs;
        return Obx(() {
          return Container(
            margin: EdgeInsets.only(left: padding),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
            ),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                // backgroundColor: Colors.blue,
                minTileHeight: 0.00,
                showTrailingIcon: false,
                visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
                initiallyExpanded: initialExpand,
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                onExpansionChanged: (expanded) => isExpanded.value = expanded,
                title: Container(
                  decoration: BoxDecoration(
                    color: LightThemeColors.white,
                    borderRadius: BorderRadius.circular(7.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  // padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
                  child: Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        value: isChecked.value,
                        onChanged: (value) {
                          // debugPrint("Checked Box: $value");
                          isChecked.value = value!;
                          MockSubjectSelect newSubject = MockSubjectSelect(
                            id: topic.id,
                            name: topic.name,
                            parentId: subject.id,
                            max: topic.questionCount!.toInt(),
                          );
                          if (value) {
                            MySharedPref.addOrUpdateMockSubjectSelect(
                                newSubject);
                          } else {
                            MySharedPref.removeMockSubjectSelect(newSubject);
                          }
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      2.0.w.width,
                      Expanded(
                        child: Text(
                          topic.name.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyles.body2,
                        ),
                      ),
                      Obx(() => AnimatedRotation(
                            turns: isExpanded.value ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.keyboard_arrow_down),
                          )),
                    ],
                  ),
                ),
                children: topic.children!
                    .map((child) => CustomExpandSubject(
                          subject: subject,
                          topic: child,
                          padding: 10,
                          initialExpand: false,
                        ))
                    .toList(),
              ),
            ),
          );
        });
      },
    );
  }
}
