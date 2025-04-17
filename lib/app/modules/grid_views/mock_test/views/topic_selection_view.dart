import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/modules/grid_views/mock_test/models/subject_model.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import '../../../../../styles/text_style.dart';
import '../../../../components/custom_text_field.dart';

class TopicSelectionView extends StatelessWidget {
  final Subject subject;
  const TopicSelectionView({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "selectedTopics",
          // style: kHeadingTextStyle.copyWith(color: LightThemeColors.white),
          style: AppTextStyles.body,
        ),
        iconTheme: const IconThemeData(color: LightThemeColors.white),
        centerTitle: true,
        backgroundColor: LightThemeColors.primary,
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
                      subject: subject,
                      padding: 0,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "AppConstant.setNumberOfQuestions.tr",
                ),
                CustomTextField(
                  // controller: controller.setNumberCon,
                  hintText: "numberOFQuestions",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "thisFieldIsRequired";
                    }
                    final parsedValue = int.tryParse(val);
                    if (parsedValue == null) {
                      return "pleaseEnterAValidNumber";
                    } else if (parsedValue < 10) {
                      return "thisValueMustBeEqualToOrGreaterThan10";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.00),
                Row(
                  children: [
                    Expanded(
                      child: CustomActionButton(
                        text: "addMoreTopic",
                        onPressed: () async {
                          // if (controller.subjects.last.id != null) {
                          //   MockSubjectSelect newSubject = MockSubjectSelect(
                          //     id: controller.subjects.last.id,
                          //     name: controller.subjects.last.name,
                          //     quantity: min(
                          //         int.tryParse(controller.setNumberCon.text)!
                          //             .toInt(),
                          //         controller.subjects.last.max!.toInt()),
                          //   );
                          //
                          //   await MySharedPref.addOrUpdateMockSubjectSelect(
                          //       newSubject);
                          //
                          //   controller.getSubjects();
                          // }

                          //Get.toNamed(Routes.ADD_MORE_TOPIC);
                        },
                      ),
                    ),
                    const SizedBox(width: 8.00),
                    Expanded(
                      child: CustomActionButton(
                        text: "startExam",
                        onPressed: () async {
                          // if (controller.subjects.last.id != null) {
                          //   MockSubjectSelect newSubject = MockSubjectSelect(
                          //     id: controller.subjects.last.id,
                          //     name: controller.subjects.last.name,
                          //     quantity: min(
                          //         int.tryParse(controller.setNumberCon.text)!
                          //             .toInt(),
                          //         controller.subjects.last.max!.toInt()),
                          //   );
                          //
                          //   await MySharedPref.addOrUpdateMockSubjectSelect(
                          //       newSubject);
                          //   controller.getSubjects();
                          // }
                          // Get.off(const ExamSetTimeScreen());
                        },
                      ),
                    ),
                  ],
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
  final double padding;
  const CustomExpandSubject(
      {super.key, required this.subject, required this.padding});

  @override
  Widget build(BuildContext context) {
    RxBool? isChecked = false.obs;
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(left: padding),
        child: ExpansionTile(
          title: Text(subject.name.toString()),
          leading: Checkbox(
              value: isChecked.value,
              onChanged: (value) {
                isChecked.value = value!;
              }),
          children: subject.children!
              .map((child) =>
                  CustomExpandSubject(subject: child, padding: (padding + 10)))
              .toList(),
        ),
      );
    });
  }
}
