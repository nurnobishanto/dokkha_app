// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/local/my_shared_pref.dart';
import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_styles.dart';

class MyTheme {
  static getThemeData({required bool isLight}) {
    return ThemeData(
      // main color (app bar,tabs..etc)
      primaryColor: isLight
          ? LightThemeColors.primaryColor
          : DarkThemeColors.primaryColor,
      // secondary color (for checkbox,float button, radio..etc)
      canvasColor:
          isLight ? LightThemeColors.accentColor : DarkThemeColors.accentColor,
      // color contrast (if the theme is dark text should be white for example)
      brightness: isLight ? Brightness.light : Brightness.dark,
      // card widget background color
      cardColor:
          isLight ? LightThemeColors.cardColor : DarkThemeColors.cardColor,
      // hint text color
      hintColor: isLight
          ? LightThemeColors.hintTextColor
          : DarkThemeColors.hintTextColor,
      // divider color
      dividerColor: isLight
          ? LightThemeColors.dividerColor
          : DarkThemeColors.dividerColor,
      scaffoldBackgroundColor: isLight
          ? LightThemeColors.scaffoldBackgroundColor
          : DarkThemeColors.scaffoldBackgroundColor,

      // progress bar theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isLight
            ? LightThemeColors.primaryColor
            : DarkThemeColors.primaryColor,
      ),

      // appBar theme
      appBarTheme: MyStyles.getAppBarTheme(isLightTheme: isLight),

      // elevated button theme
      elevatedButtonTheme:
          MyStyles.getElevatedButtonTheme(isLightTheme: isLight),

      // text theme
      textTheme: MyStyles.getTextTheme(isLightTheme: isLight),

      // chip theme
      chipTheme: MyStyles.getChipTheme(isLightTheme: isLight),

      // icon theme
      iconTheme: MyStyles.getIconTheme(isLightTheme: isLight),
      // colorScheme: ColorScheme(
      //   brightness: isLight ? Brightness.light : Brightness.dark,
      //   primary: isLight ? LightThemeColors.primaryColor : DarkThemeColors.primaryColor,
      //   secondary: isLight ? LightThemeColors.s : DarkThemeColors.secondaryColor,
      //   background: isLight
      //       ? LightThemeColors.backgroundColor
      //       : DarkThemeColors.backgroundColor,
      //   surface: isLight ? LightThemeColors.surfaceColor : DarkThemeColors.surfaceColor,
      //   onPrimary: isLight ? LightThemeColors.onPrimaryColor : DarkThemeColors.onPrimaryColor,
      //   onSecondary: isLight ? LightThemeColors.onSecondaryColor : DarkThemeColors.onSecondaryColor,
      //   onBackground: isLight ? LightThemeColors.onBackgroundColor : DarkThemeColors.onBackgroundColor,
      //   onSurface: isLight ? LightThemeColors.onSurfaceColor : DarkThemeColors.onSurfaceColor,
      // ),


    );
  }

  /// update app theme and save theme type to shared pref
  /// (so when the app is killed and up again theme will remain the same)
  static changeTheme() {
    // *) check if the current theme is light (default is light)
    bool isLightTheme = MySharedPref.getThemeIsLight();
    // *) store the new theme mode on get storage
    MySharedPref.setThemeIsLight(!isLightTheme);
    // *) let GetX change theme
    Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
  }

  /// check if the theme is light or dark
  bool get getThemeIsLight => MySharedPref.getThemeIsLight();
}
