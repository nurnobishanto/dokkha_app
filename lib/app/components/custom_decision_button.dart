import 'package:flutter/material.dart';
import '../../config/theme/light_theme_colors.dart';

class DecisionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? leadingWidget; // Accepts Icon, Image, or any Widget
  final Color? borderColor;
  final double? height;

  const DecisionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.leadingWidget, // Optional widget (icon/image/custom widget)
    this.borderColor = LightThemeColors.primaryColor,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: borderColor ?? LightThemeColors.primaryColor,
            width: 2, // Border width
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingWidget != null) ...[
              leadingWidget!,
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
