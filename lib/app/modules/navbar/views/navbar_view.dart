import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
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
