import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/global.dart';
import '../../routes/app_pages.dart';

class MessengerRedirectScreen extends StatefulWidget {
  const MessengerRedirectScreen({super.key});

  @override
  State<MessengerRedirectScreen> createState() =>
      _MessengerRedirectScreenState();
}

class _MessengerRedirectScreenState extends State<MessengerRedirectScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoggedIn.value) {
        _redirectToMessenger();
      } else {
        _goToSignInRequired();
      }
    });
  }

  Future<void> _redirectToMessenger() async {
    await Future.delayed(const Duration(milliseconds: 0));
    const messengerUrl = 'https://m.me/lokkhabd';
    final uri = Uri.parse(messengerUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Messenger could not be launched");
      Get.snackbar(
        "Error",
        "Could not launch Messenger",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _goToSignInRequired() {
    Get.off(() => Scaffold(
          appBar: AppBar(
            title: Text(
              "Messenger Support",
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: LightThemeColors.primaryColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Get.offAllNamed(Routes.NAVBAR);
              },
            ),
          ),
          body: const AuthGatewayView(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messenger Support",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: LightThemeColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.offAll(() => Get.offAllNamed(Routes.NAVBAR));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie animation for Messenger or chat loading
              SizedBox(
                width: 150,
                height: 150,
                child: Lottie.asset(
                  "assets/lottie/messenger.json",
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                ),
              ),

              Text(
                "Redirecting To Messenger",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                "Messenger Wait",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
