import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
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
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home", backgroundColor: LightThemeColors.primaryColor),
              BottomNavigationBarItem(icon: Icon(Icons.food_bank_outlined), label: "Q Bank"),
              BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Contest"),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: "Blog"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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