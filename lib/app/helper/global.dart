import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:lokkha/config/constants/app_strings.dart';
import 'package:lokkha/utils/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 🌍 GLOBAL CONFIG: shared across the entire app.

/// ✅ App Info
String appName = AppStrings.appName;
RxString appVersion = ''.obs;
String appPackage = '';
String appAuthor = "Techyfo";

/// ✅ Environment
bool isDebugMode = true;
bool isProduction = false;
bool enableLogging = true;

/// ✅ API & Headers
Map<String, String> defaultHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json",
};

/// ✅ Authentication / User Info (Reactive)
RxString? currentUserId = ''.obs;
RxString? userName = ''.obs;
RxString? userEmail = ''.obs;
RxString? userPhone = ''.obs;
RxString? userRole = ''.obs;
RxBool isLoggedIn = false.obs;

/// ✅ Device Info
String? deviceId;
String? deviceOS;
String? deviceBrand;
String? deviceModel;
Size? screenSize;

/// ✅ Theme Settings
RxBool isDarkMode = false.obs;
Rx<ThemeMode> currentThemeMode = ThemeMode.system.obs;
Color primaryColor = Colors.blue;

/// ✅ Feature Toggles
RxBool isNewFeatureEnabled = true.obs;
RxBool isMaintenanceMode = false.obs;

/// ✅ Flags / App State
RxBool isLoading = false.obs;
RxBool hasNetwork = true.obs;
RxBool showIntro = true.obs;
RxBool isKeyboardOpen = false.obs;

/// ✅ UI & Layout
double defaultPaddingHorizontal = 8.0.w;
double defaultRadius = 12.0;
EdgeInsets defaultMargin = EdgeInsets.all(8.0.r);

/// ✅ File & Media
RxString? imageUploadPath = ''.obs;
RxString? downloadedFilePath = ''.obs;
List<String> supportedImageTypes = ["jpg", "png", "jpeg"];

/// ✅ Helper Methods

void printAppInfo() {
  if (!enableLogging) return;
  debugPrint("🧾 App Info:");
  debugPrint("📱 $appName v$appVersion by $appAuthor");
  debugPrint("🌐 API: ${AppConstants.baseUrl}");
  debugPrint("🔧 Debug: $isDebugMode");
  debugPrint("👤 Logged In: ${isLoggedIn.value}");
}

void clearAuth() {
  currentUserId?.value = '';
  isLoggedIn.value = false;
  logInfo("🚪 Logged Out");
}

void toggleThemeMode() {
  isDarkMode.value = !isDarkMode.value;
  currentThemeMode.value = isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  logInfo("🎨 Theme: ${isDarkMode.value ? 'Dark' : 'Light'}");
}

void setDeviceInfo({
  required String id,
  required String os,
  required String brand,
  required String model,
  required Size size,
}) {
  deviceId = id;
  deviceOS = os;
  deviceBrand = brand;
  deviceModel = model;
  screenSize = size;
  logInfo("📱 Device Set: $deviceBrand $deviceModel");
}

void updateKeyboardStatus(bool isOpen) {
  isKeyboardOpen.value = isOpen;
  logInfo("⌨️ Keyboard: ${isOpen ? 'Open' : 'Closed'}");
}

/// ✅ Logging Utility
void logInfo(String message) {
  if (enableLogging && isDebugMode) {
    debugPrint("ℹ️ $message");
  }
}

void logError(String error) {
  if (enableLogging) {
    debugPrint("❌ $error");
  }
}

/// ✅ Misc Utility
bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

bool isImageFile(String fileName) {
  final ext = fileName.split('.').last.toLowerCase();
  return supportedImageTypes.contains(ext);
}

Future<void> fetchAppVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion.value = packageInfo.version;
}

Future<String?> getDeviceId() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // Unique Android ID
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor; // Unique iOS ID
  }
  return null;
}

String convertDaysToHumanReadable(int days) {
  int years = days ~/ 365;
  int months = (days % 365) ~/ 30;
  int remainingDays = days % 365 % 30;

  List<String> result = [];

  if (years > 0) {
    result.add('$years বছর');
  }
  if (months > 0) {
    result.add('$months মাস');
  }
  if (remainingDays > 0 || result.isEmpty) {
    result.add('$remainingDays দিন');
  }

  return result.join(' ');
}

Widget isCheckedGifImage(String imageUrl) {
  final isGifFile = imageUrl.toLowerCase().endsWith('.gif');
  return isGifFile
      ? Gif(
          image: NetworkImage(imageUrl),
          autostart: Autostart.loop,
          fit: BoxFit.fitWidth,
          height: 110.0.h,
          width: double.infinity,
          placeholder: (context) =>
              const Center(child: CircularProgressIndicator()),
          onFetchCompleted: () {
            // You can handle something here if needed
          },
        )
      : CachedNetworkImage(
          imageUrl: imageUrl,
          height: 110.0.h,
          width: double.infinity,
          fit: BoxFit.fitWidth,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
}
