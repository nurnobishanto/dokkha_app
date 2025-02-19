import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOptionSelector extends StatelessWidget {
  final String title;
  final List<String> options;
  final int selectedOptionIndex;
  final Function(int) onOptionSelected;

  const CustomOptionSelector({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOptionIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
        ),
        5.h.height,
        // List of options displayed as buttons
        Column(
          children: List.generate(options.length, (index) {
            return GestureDetector(
              onTap: () {
                onOptionSelected(index);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: LightThemeColors.primary.withOpacity(.5)),
                  color: selectedOptionIndex == index
                      ? LightThemeColors.primary
                      : LightThemeColors.primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontSize: 15.0,
                          color: selectedOptionIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
