import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/fast_practice_controller.dart';

class FastPracticeView extends GetView<FastPracticeController> {
  const FastPracticeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 80,
                color: LightThemeColors.iconColor,
              ),
              const SizedBox(height: 20),
              const Text(
                "Coming Soon!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.iconColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "We're working on it. Stay tuned!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
