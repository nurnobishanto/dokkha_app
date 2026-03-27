import 'package:flutter/material.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';

class SectionTitleWithDivider extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final double dividerHeight;
  final EdgeInsetsGeometry padding;

  const SectionTitleWithDivider({
    super.key,
    required this.title,
    this.color = LightThemeColors.primaryColor,
    this.fontSize = 18,
    this.dividerHeight = 1.5,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: transparentDivider(
                beginTransparent: true, height: dividerHeight),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: color,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: transparentDivider(
                beginTransparent: false, height: dividerHeight),
          ),
        ],
      ),
    );
  }
}

Widget transparentDivider(
    {required bool beginTransparent, double height = 1.5}) {
  final colors = beginTransparent
      ? [
          Colors.transparent,
          LightThemeColors.primaryColor.withValues(alpha: 0.3),
          LightThemeColors.primaryColor..withValues(alpha: 0.6),
        ]
      : [
          LightThemeColors.primaryColor..withValues(alpha: 0.6),
          LightThemeColors.primaryColor..withValues(alpha: 0.3),
          Colors.transparent,
        ];

  return Container(
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: colors),
    ),
  );
}
