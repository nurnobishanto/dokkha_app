import 'dart:io';
import 'package:dokkha/config/extensions/common_extension.dart';
import 'package:dokkha/config/extensions/widget_extensions.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/constants/app_images.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: <Widget>[
          /// Reduced height for Drawer Header
          20.h.height,
          Image.asset(
            AssetImagePaths.appIcon,
            height: 100,
          ),
          20.h.height,

          /// Drawer Items (standard)
          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const Icon(
              Icons.web,
              size: 20,
              color: LightThemeColors.primaryColor,
            ),
            title:
                const Text('আমাদের সম্পর্কে', style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
          const Divider(
            height: 0.5,
            color: LightThemeColors.primaryColor,
          ),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const Icon(
              Icons.add_card_outlined,
              size: 20,
              color: LightThemeColors.primaryColor,
            ),
            title: const Text('ফেইসবুক গ্রুপ', style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const FaIcon(
              FontAwesomeIcons.tasks,
              size: 18,
              color: LightThemeColors.primaryColor,
            ),
            title:
                const Text('মেসেঞ্জার চ্যাট', style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const Icon(
              Icons.chat_sharp,
              size: 20,
              color: LightThemeColors.primaryColor,
            ),
            title: const Text('শেয়ার', style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const Icon(
              Icons.support,
              size: 20,
              color: LightThemeColors.primaryColor,
            ),
            title:
                const Text('কাস্টমার সাপোর্ট', style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const Icon(
              Icons.info_outlined,
              size: 20,
              color: LightThemeColors.primaryColor,
            ),
            title:
                const Text('প্রাইভেসি পলিসি', style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),

          ListTile(
            visualDensity: VisualDensity.standard,
            leading: const Icon(
              Icons.perm_device_information,
              size: 20,
              color: LightThemeColors.primaryColor,
            ),
            title: const Text('টার্মস এন্ড কন্ডিশন',
                style: TextStyle(fontSize: 14)),
            onTap: () {},
          ),
          const Divider(height: 0.5, color: LightThemeColors.primaryColor),
          15.h.height,

          /// App Version (standard)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                'অ্যাপ ভার্শন: 1.0.0',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 10.0.w), // Reduced horizontal padding
    );
  }
}
