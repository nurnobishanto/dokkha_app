import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/config/constants/app_strings.dart';
import 'package:lokkha/utils/constants.dart';

/// 🌍 GLOBAL CONFIG: shared across the entire app.

/// ✅ App Info
String appName = AppStrings.appName;
String appVersion = "1.0.0";
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
    print("ℹ️ $message");
  }
}

void logError(String error) {
  if (enableLogging) {
    print("❌ $error");
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
