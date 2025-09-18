import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lokkha/config/extensions/common_extension.dart';

import '../../../../config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';

class ExamCategoryCard extends StatelessWidget {
  final String title;
  final Color? borderColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const ExamCategoryCard({
    super.key,
    required this.title,
    this.borderColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
        decoration: BoxDecoration(
          color: LightThemeColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: borderColor ??
                LightThemeColors.primaryColor.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // center horizontally
          crossAxisAlignment: CrossAxisAlignment.center, //  center vertically
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.graduationCap,
              color: iconColor ?? LightThemeColors.primaryColor,
              size: 20.sp,
            ),
            3.w.width,
            Flexible(
              child: Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.center,
                //softWrap: true,       // allow wrapping
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.heading5.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
