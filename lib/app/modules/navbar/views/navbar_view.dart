import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../data/local/my_shared_pref.dart';
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
            onTap: (index) => controller.changeIndex(index), // Call method to update index
            items:  [
              const  BottomNavigationBarItem(icon:FaIcon(FontAwesomeIcons.house,size: 18.00), label: "হোম", backgroundColor: LightThemeColors.primaryColor),
              const  BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.newspaper,size: 18.00), label: "ব্লগ",backgroundColor: LightThemeColors.primaryColor),
              const  BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.boxOpen,size: 18.00), label: "প্রিমিয়াম",backgroundColor: LightThemeColors.primaryColor),
              controller.showProfile?
                const BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.user, size: 18.0),
                  label: "প্রোফাইল",
                  backgroundColor: LightThemeColors.primaryColor,
                ):
              const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user, size: 18.0),
                label: "লগইন",
                backgroundColor: LightThemeColors.primaryColor,
              )
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