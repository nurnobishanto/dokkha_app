import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../helper/global.dart';
import '../controllers/navbar_controller.dart';

class NavbarView extends GetView<NavbarController> {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavbarController>(
        builder: (controller) {
          return controller.nabBarBody[controller.currentIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<NavbarController>(
        builder: (controller) {
          return BottomNavigationBar(
            backgroundColor: LightThemeColors.softBg,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex,
            selectedItemColor: LightThemeColors.primaryColor, // selected color
            // unselectedItemColor: Colors.grey.shade400,             // unselected color
            onTap: controller.changeIndex,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 18),
                label: "হোম",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.edit, size: 18),
                label: "পরীক্ষা",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.chat, size: 20),
                label: "Messenger",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.inventory, size: 18),
                label: "প্রিমিয়াম",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person, size: 18),
                label: !isLoggedIn.value ? "লগইন" : "প্রোফাইল",
                backgroundColor: LightThemeColors.primaryColor,
              ),
            ],
          );
        },
      ),
    );
  }
}
