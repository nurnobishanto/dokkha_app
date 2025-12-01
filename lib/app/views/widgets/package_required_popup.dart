import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_action_button.dart';
import '../../routes/app_pages.dart';

class PackageRequiredPopup extends StatelessWidget {
  const PackageRequiredPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.purple[50],
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.workspace_premium,
              size: 60,
              color: Colors.purple[800],
            ),
            const SizedBox(height: 15),
            Text(
              "প্রিমিয়াম মেম্বারশিপ প্রয়োজন",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple[900],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "অ্যাপের সকল ফিচার ব্যবহার করতে হলে আপনাকে আমাদের প্রিমিয়াম মেম্বার হতে হবে। আপনার জন্য যেকোনো একটি প্যাকেজ বেছে নিন।",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomActionButton(
              text: "প্যাকেজ নিন",
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.PREMIUM_PACKAGES);
              },
            ),
          ],
        ),
      ),
    );
  }
}
