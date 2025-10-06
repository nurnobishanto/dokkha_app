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
            currentIndex: controller.currentIndex,
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
                // icon: !isLoggedIn.value
                //     ? const FaIcon(FontAwesomeIcons.rightToBracket, size: 18)
                //     : const FaIcon(FontAwesomeIcons.user, size: 18),
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

// Future<void> handleInitialUri() async {
//   try {
//     final initialLink = await getInitialLink();
//     if (initialLink != null) {
//       final uri = Uri.parse(initialLink);
//       final token = uri.queryParameters['token'];
//       if (token != null) {
//         print("🔑 Token received from link: $token");
//         // You can now use this token to hit your backend and log in/register
//         // Example: Navigate to Login or Home page
//       }
//     }
//   } catch (e) {
//     print("Error reading deep link: $e");
//   }
// }
