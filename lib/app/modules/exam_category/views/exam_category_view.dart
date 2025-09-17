import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:lokkha/config/extensions/common_extension.dart';

import '../../../../config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';
import '../controllers/exam_category_controller.dart';
import '../widgets/exam_category_card.dart';

class ExamCategoryView extends GetView<ExamCategoryController> {
  const ExamCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamCategoryView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              5.h.height,
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: LightThemeColors.primaryColor,
                        thickness: 2,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      "প্রিমিয়াম কোর্স সূমহ",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading4,
                    ),
                    Expanded(
                      child: Divider(
                        color: LightThemeColors.primaryColor,
                        thickness: 2,
                        indent: 8,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.all(8),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (_, x) {
                  return ExamCategoryCard(
                    title: "Exam Category ${x + 1}",
                    onTap: () {
                      print("Tapped category ${x + 1}");
                    },
                  );
                },
                separatorBuilder: (x, i) => 8.h.height,
              ),
              10.h.height,
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        color: LightThemeColors.primaryColor,
                        thickness: 2,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      "ফ্রি কোর্স সূমহ",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading4,
                    ),
                    Expanded(
                      child: Divider(
                        color: LightThemeColors.primaryColor,
                        thickness: 2,
                        indent: 8,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.all(8),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (_, x) {
                  return ExamCategoryCard(
                    title: "Exam Category ${x + 1}",
                    onTap: () {
                      print("Tapped category ${x + 1}");
                    },
                  );
                },
                separatorBuilder: (x, i) => 8.h.height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
