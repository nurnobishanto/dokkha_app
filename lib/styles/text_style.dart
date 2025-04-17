import 'package:flutter/material.dart';

/// AppTextStyle format as follows:
/// [fontWeight][fontSize][colorName][opacity]
/// Example: bold18White05
TextStyle kHeadingTextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 23.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );

  static const TextStyle title = TextStyle(
    fontSize: 16.00,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle body = TextStyle(
    fontSize: 13.00,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );
  static const TextStyle paragraph = TextStyle(
    fontSize: 14.00,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  /// Helper method to modify text styles dynamically
  static TextStyle custom({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    TextDecoration? decoration,
    double? letterSpacing,
  }) {
    return body.copyWith(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }
}

