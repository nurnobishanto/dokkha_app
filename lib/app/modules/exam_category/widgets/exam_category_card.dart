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
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.graduationCap,
              color: iconColor ?? LightThemeColors.primaryColor,
              size: 22.sp,
            ),
            10.w.width,
            Flexible(
              child: Text(
                title,
                style: AppTextStyles.heading5.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
