import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/models/vocabulary.dart';
import 'package:lokkha/app/modules/current_affairs/controllers/international_current_affairs_controller.dart';
import 'package:lokkha/app/modules/vocabulary/controllers/vocabulary_controller.dart';
import 'package:lokkha/app/modules/vocabulary/models/vocabulary_model.dart';
import 'package:lokkha/app/views/widgets/explanation_dialog.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/styles/text_style.dart';

import '../../../../config/theme/light_theme_colors.dart';
import '../../../components/custom_search_bar.dart';
import '../../../models/category.dart';

class VocabularyView extends StatelessWidget {
  const VocabularyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());

    return Scaffold(
      appBar: const CustomAppBar(title: 'Vocabulary'),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomSearchBar(
                  onChanged: null,
                  hintText: 'Search Vocabulary...',
                ),
                10.0.height,
                FilterRow(vocabularyController: controller),
                10.0.height,
                Center(
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    alignment: WrapAlignment.center,
                    children: controller.model.value.alphabets!.map((char) {
                      return InkWell(
                        onTap: () {
                          controller.selectedAlphabet.value = char.toString();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 4.0.r, horizontal: 10),
                          decoration: BoxDecoration(
                            color: char == controller.selectedAlphabet.value
                                ? LightThemeColors.primaryColor
                                : LightThemeColors.white,
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
                            char,
                            style: TextStyle(
                                color: char == controller.selectedAlphabet.value
                                    ? LightThemeColors.white
                                    : LightThemeColors.primaryColor),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class FilterRow extends StatelessWidget {
  final VocabularyController vocabularyController;
  const FilterRow({super.key, required this.vocabularyController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() => SizedBox(
          height: 35.0.h,
          width: MediaQuery.of(context).size.width * 0.45, // Adjusted width instead of double.infinity
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<Category>(
              value: vocabularyController.selectedType.value,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              hint: const Text("Select Type"),
              items: (vocabularyController.model.value.types ?? []).map((type) {
                return DropdownMenuItem<Category>(
                  value: type,
                  child: Text(type.name.toString()),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) vocabularyController.setType(value);
              },
            ),
          ),
        )),


        //  const SizedBox(width: 10),

        //  Category Dropdown
        // Obx(() => Expanded(
        //       child: Container(
        //         width: double.infinity,
        //         height: 35.0.h,
        //         padding: const EdgeInsets.symmetric(horizontal: 12),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           border: Border.all(color: Colors.grey.shade300),
        //           borderRadius: BorderRadius.circular(8.0.r),
        //         ),
        //         child: DropdownButton<String>(
        //           isExpanded: true,
        //           value: controller.selectedCategory.value,
        //           underline: const SizedBox(),
        //           icon: const Icon(Icons.arrow_drop_down),
        //           items: categories.map((category) {
        //             return DropdownMenuItem(
        //               value: category,
        //               child: Text(category),
        //             );
        //           }).toList(),
        //           onChanged: (value) {
        //             if (value != null) controller.setCategory(value);
        //           },
        //         ),
        //       ),
        //     )),
      ],
    );
  }
}
