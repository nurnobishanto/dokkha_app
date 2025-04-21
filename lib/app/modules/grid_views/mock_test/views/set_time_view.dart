import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/auth_views/signin/views/signin_view.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import '../../../../../styles/text_style.dart';
import '../../../../components/custom_action_button.dart';
import '../../../../components/custom_text_field.dart';
import '../../../../helper/global.dart';
import '../controllers/mock_test_set_time_controller.dart';

class SetTimeView extends StatelessWidget {
  const SetTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    final MockTestSetTimeController controller =
        Get.put(MockTestSetTimeController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'সময় নির্ধারণ',
          style: kHeadingTextStyle.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: LightThemeColors.primaryColor,
      ),
      body: Obx(() {
        // Create DropdownMenuItems from the questionType map
        List<Map<String, String>> dropdownItems =
            controller.questionType.entries.map((entry) {
          return {
            'key': entry.key,
            'value': entry.value,
          };
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'সময় নির্ধারণ করুন',
                            style: AppTextStyles.body,
                          ),
                          const SizedBox(width: 5.00),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 100,
                              maxHeight: 40,
                            ),
                            padding: EdgeInsets.zero,
                            width: 40,
                            height: 30,
                            child: Transform.scale(
                              scale: 0.7,
                              child: Switch.adaptive(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: controller.isSetTime.value,
                                onChanged: (value) {
                                  controller.isSetTime.value = value;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      controller.isSetTime.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16.00),
                                const Text(
                                  'মিনিটে সময় নির্ধারণ করুন',
                                ),
                                const SizedBox(height: 3.00),
                                CustomTextField(
                                  controller: controller.setTimeCon,
                                  hintText: "মিনিটে সময় নির্ধারণ",
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "this field is required";
                                    }
                                    final parsedValue = int.tryParse(val);
                                    if (parsedValue == null) {
                                      return 'please enter A valid number';
                                    } else if (parsedValue < 10) {
                                      return 'Must be at least 10';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 6.00),
                      // Negative Mark
                      Row(
                        children: [
                          Text(
                            "নেগেটিভ মার্কিং",
                          ),
                          const SizedBox(width: 3.00),
                          Container(
                            constraints: const BoxConstraints(
                              maxWidth: 100,
                              maxHeight: 40,
                            ),
                            padding: EdgeInsets.zero,
                            width: 40,
                            height: 30,
                            child: Transform.scale(
                              scale: 0.7,
                              child: Switch.adaptive(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: controller.isNegativeMarkChecked.value,
                                onChanged: (value) {
                                  controller.isNegativeMarkChecked.value =
                                      value;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.00),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(
                                  alpha: 0.4), // Corrected opacity usage
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              "প্রতিটি ভুলের জন্য ০.২৫ নম্বর কাটা যাবে",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.00),
                      Text(
                        "প্রশ্নের ধরন নির্বাচন করুন",
                      ),
                      const SizedBox(height: 3.00),

                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: dropdownItems.map((Map<String, String> item) {
                          return Obx(() => InkWell(
                                onTap: () {
                                  controller.selectedKey.value =
                                      item['key'] ?? '';
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Radio<String>(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      value: item['key'] ?? '',
                                      groupValue: controller.selectedKey.value,
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          controller.selectedKey.value =
                                              newValue;
                                        }
                                      },
                                    ),
                                    Text(
                                      item['value'] ?? '',
                                    ),
                                  ],
                                ),
                              ));
                        }).toList(),
                      ),

                      //
                      // Container(
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //         color: Colors.black.withValues(alpha: 0.3)),
                      //     borderRadius: BorderRadius.circular(8),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      //     child: DropdownButton<String>(
                      //       items: dropdownItems,
                      //       value: controller.selectedKey.value.isEmpty
                      //           ? null
                      //           : controller.selectedKey.value,
                      //       onChanged: (String? newValue) {
                      //         if (newValue != null) {
                      //           controller.selectedKey.value = newValue;
                      //         }
                      //       },
                      //       hint: Text(""selectQuestionType"),
                      //       isExpanded: true,
                      //       icon: const Icon(Icons.arrow_drop_down),
                      //       elevation: 16,
                      //       style: const TextStyle(color: Colors.black),
                      //       underline: const SizedBox.shrink(),
                      //     ),
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 35,
                      //   child: CustomDropdownButton(
                      //     items: dropdownItems,
                      //     dropdownValue: controller.dropdownValue,
                      //     onChanged: (value) {
                      //       controller.dropdownValue.value = value!;
                      //     },
                      //   ),
                      // ),
                      const SizedBox(height: 50.00),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(),
                          ),
                          const SizedBox(width: 10.00),
                          Text("নির্বাচিত বিষয়"),
                          const SizedBox(width: 10.00),
                          const Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: controller.selectedSubjects.map((subject) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Text(
                                "${subject.name.toString()} (${subject.quantity.toString()})",
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: (isLoggedIn.value == false)
                    ? CustomActionButton(
                        text: "প্রিমিয়াম প্যাকেজ কিনুন",
                        onPressed: () {
                          Get.to(SignInView());
                        })
                    : CustomActionButton(
                        text: "পরীক্ষা শুরু করুন",
                        onPressed: () {
                          // Map<String, dynamic> data = {
                          //   'duration': controller.setTimeCon.text,
                          //   'type': controller.dropdownValue.value,
                          //   'negative_mark':
                          //       controller.isNegativeMarkChecked.value,
                          //   'subjects': controller.selectedSubjects
                          //       .map((subject) => subject.toMap())
                          //       .toList(), // Convert each subject to map
                          // };
                          // if (kDebugMode) {
                          //   print("Question paper Data: $data}");
                          // }

                          //controller.postMockExamStart();
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
