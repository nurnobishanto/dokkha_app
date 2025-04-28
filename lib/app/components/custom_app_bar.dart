import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/theme/light_theme_colors.dart';
import '../../styles/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor = LightThemeColors.primaryColor,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      actions: actions,
      title: Text(
        title,
        style: AppTextStyles.heading4.copyWith(color: Colors.white),
      ),
    );
  }
}
