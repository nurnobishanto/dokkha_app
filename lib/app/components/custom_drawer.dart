import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/core/widgets/base_webview.dart';
import 'package:lokkha/app/modules/drawer_pages/views/customer_support_view.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/extensions/widget_extensions.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lokkha/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/constants/app_images.dart';
import '../helper/global.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("Build Drawer///");
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: <Widget>[
          /// Reduced height for Drawer Header
          70.h.height,
          Image.asset(
            AssetImagePaths.appIcon,
            height: 100,
          ),
          20.h.height,

          /// Drawer Items (standard)
          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(FontAwesomeIcons.infoCircle,
                color: LightThemeColors.primaryColor, size: 20),
            title:
                const Text('আমাদের সম্পর্কে', style: TextStyle(fontSize: 14)),
            onTap: () {
              Get.to(
                 const BaseWebView(title: "আমাদের সম্পর্কে", url: AppConstants.about),
              );
            },
          ),
          // const Divider(
          //   height: 0.5,
          //   color: LightThemeColors.primaryColor,
          // ),
          // ListTile(
          //   visualDensity: VisualDensity.standard,
          //   leading: const FaIcon(FontAwesomeIcons.facebook,
          //       color: LightThemeColors.primaryColor, size: 20),
          //   title: const Text('ফেইসবুক গ্রুপ', style: TextStyle(fontSize: 14)),
          //   onTap: () {},
          // ),
          // const Divider(height: 0.5, color: LightThemeColors.primaryColor),
          //
          // ListTile(
          //   visualDensity: VisualDensity.standard,
          //   leading: const FaIcon(FontAwesomeIcons.facebookMessenger,
          //       color: LightThemeColors.primaryColor, size: 20),
          //   title:
          //       const Text('মেসেঞ্জার চ্যাট', style: TextStyle(fontSize: 14)),
          //   onTap: () {},
          // ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(FontAwesomeIcons.share,
                color: LightThemeColors.primaryColor, size: 20),
            title: const Text('শেয়ার', style: TextStyle(fontSize: 14)),
            onTap: () {
              if (Platform.isAndroid) {
                SharePlus.instance.share(
                  ShareParams(
                      text:
                          "https://play.google.com/store/apps/details?id=$appPackage"),
                );
              } else if (Platform.isIOS) {
                SharePlus.instance.share(
                  ShareParams(
                      text:
                          "https://apps.apple.com/us/app/app name/id6670564455"),
                );
              }
            },
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(FontAwesomeIcons.headset,
                color: LightThemeColors.primaryColor, size: 20),
            title:
                const Text('কাস্টমার সাপোর্ট', style: TextStyle(fontSize: 14)),
            onTap: () {

              //Get.to(const CustomerSupportView());
            },
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),
          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(FontAwesomeIcons.userShield,
                color: LightThemeColors.primaryColor, size: 20),
            title:
                const Text('প্রাইভেসি পলিসি', style: TextStyle(fontSize: 14)),
            onTap: () => Get.to(
              const BaseWebView(
                  title: "প্রাইভেসি পলিসি", url: AppConstants.privacyPolicy),
            ),
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(FontAwesomeIcons.moneyBillWave,
                color: LightThemeColors.primaryColor, size: 20),
            title: const Text('রিফান্ড পলিসি', style: TextStyle(fontSize: 14)),
            onTap: () => Get.to(
              const BaseWebView(
                  title: "রিফান্ড পলিসি", url: AppConstants.refundPolicy),
            ),
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),
          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(FontAwesomeIcons.award,
                color: LightThemeColors.primaryColor, size: 20),
            title: const Text('কন্টেস্ট পলিসি', style: TextStyle(fontSize: 14)),
            onTap: () => Get.to(
              const BaseWebView(
                  title: "কন্টেস্ট পলিসি", url: AppConstants.contestPolicy),
            ),
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),
          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(FontAwesomeIcons.fileContract,
                color: LightThemeColors.primaryColor, size: 20),
            title: const Text('টার্মস এন্ড কন্ডিশন',
                style: TextStyle(fontSize: 14)),
            onTap: () => Get.to(
              const BaseWebView(
                  title: "টার্মস এন্ড কন্ডিশন", url: AppConstants.termsPolicy),
            ),
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),
          15.h.height,

          /// App Version (standard)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'অ্যাপ ভার্শন: $appVersion',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10.0.w), // Reduced horizontal padding
    );
  }
}

// Reusable DrawerItem widget
// class _DrawerItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//
//   const _DrawerItem({
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           visualDensity: VisualDensity.standard,
//           leading: Icon(icon, size: 20, color: LightThemeColors.primaryColor),
//           title: Text(title, style: const TextStyle(fontSize: 14)),
//           onTap: onTap,
//         ),
//         const Divider(height: 0.5, color: LightThemeColors.primaryColor),
//       ],
//     );
//   }
// }
