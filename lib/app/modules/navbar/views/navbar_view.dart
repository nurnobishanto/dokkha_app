import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex,
            selectedItemColor: LightThemeColors.primaryColor,      // selected color
            // unselectedItemColor: Colors.grey.shade400,             // unselected color
            onTap: controller.changeIndex,
            items: [
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house, size: 18),
                label: "হোম",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.penToSquare, size: 18),
                label: "পরীক্ষা",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.commentDots, size: 20),
                label: "Messenger",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.boxOpen, size: 18),
                label: "প্রিমিয়াম",
                backgroundColor: LightThemeColors.primaryColor,
              ),
              BottomNavigationBarItem(
                icon: const FaIcon(FontAwesomeIcons.user, size: 18),
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