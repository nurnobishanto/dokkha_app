import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/translations/localization_service.dart';
import '../../modules/grid_views/mock_test/models/mock_subject_select_model.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';

  // Keys for user login token
  static const String _userTokenKey = 'user_token';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }


  // Setter method to save user login token
   static Future<void> setUserToken(String token)async{
      await _sharedPreferences.setString(_userTokenKey, token);
   }

   // Getter method to retrieve user login token
  static String getUserToken(){
    return _sharedPreferences.getString(_userTokenKey)??"";
  }

  // Method to remove user token
  static Future<void> removeUserToken() async {
    await _sharedPreferences.remove(_userTokenKey);
  }


  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ?? true; // todo set the default theme (true for light, false for dark)

  /// save current locale
  static Future<void> setCurrentLanguage(String languageCode) =>
      _sharedPreferences.setString(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal(){
      String? langCode = _sharedPreferences.getString(_currentLocalKey);
      // default language is english
      if(langCode == null){
        return LocalizationService.defaultLanguage;
      }
      return LocalizationService.supportedLanguages[langCode]!;
  }

  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() =>
      _sharedPreferences.getString(_fcmTokenKey);

  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();



  /// For add or update
  static Future<void> addOrUpdateMockSubjectSelect(MockSubjectSelect subject) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current list of subject JSON strings (if any)
    List<String> subjectsList = prefs.getStringList('mockSubjects') ?? [];

    // Convert the existing JSON strings into objects
    List<MockSubjectSelect> subjects = subjectsList
        .map((subjectJson) => MockSubjectSelect.fromJson(subjectJson))
        .toList();

    // Check if the subject with the same ID already exists
    int existingIndex = subjects.indexWhere((s) => s.id == subject.id);

    if (existingIndex != -1) {
      // If exists, update the object
      subjects[existingIndex] = subject;
    } else {
      // If not, add the new object
      subjects.add(subject);
    }

    // Convert updated list back to JSON strings
    List<String> updatedSubjectsList = subjects.map((s) => s.toJson()).toList();

    // Store the updated list in SharedPreferences
    await prefs.setStringList('mockSubjects', updatedSubjectsList);
  }

/// For Remove
  static Future<void> removeMockSubjectSelect(MockSubjectSelect subject) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the current list of subject JSON strings (if any)
    List<String> subjectsList = prefs.getStringList('mockSubjects') ?? [];

    // Convert the existing JSON strings into objects
    List<MockSubjectSelect> subjects = subjectsList
        .map((subjectJson) => MockSubjectSelect.fromJson(subjectJson))
        .toList();

    // Remove subject by matching ID
    subjects.removeWhere((s) => s.id == subject.id);

    // Convert updated list back to JSON strings
    List<String> updatedSubjectsList = subjects.map((s) => s.toJson()).toList();

    // Store the updated list in SharedPreferences
    await prefs.setStringList('mockSubjects', updatedSubjectsList);
  }

  static Future<bool> isMockSubjectExist(int id) async {
    final prefs = await SharedPreferences.getInstance();

    // Get current list
    List<String> subjectsList = prefs.getStringList('mockSubjects') ?? [];

    // Convert to object list
    List<MockSubjectSelect> subjects = subjectsList
        .map((subjectJson) => MockSubjectSelect.fromJson(subjectJson))
        .toList();

    // Check if any subject has this id
    return subjects.any((s) => s.id == id);
  }






  static Future<List<MockSubjectSelect>> getMockSubjects() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the list of subject JSON strings from SharedPreferences
    List<String> subjectsList = prefs.getStringList('mockSubjects') ?? [];

    // Convert the list of JSON strings back into MockSubjectSelect objects
    List<MockSubjectSelect> subjects = subjectsList
        .map((subjectJson) => MockSubjectSelect.fromJson(subjectJson))
        .toList();

    return subjects;
  }
  static Future<void> clearMockSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('mockSubjects'); // Removes the entire list
  }


}
