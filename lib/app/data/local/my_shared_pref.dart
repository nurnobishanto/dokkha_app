import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/translations/localization_service.dart';
import '../../models/mock_subject_select_model.dart';
import '../../modules/subject_sections/models/sub_sec_select_model.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // internal shared preferences instance
  static late SharedPreferences _prefs;

  // Keys
  static const String _fcmTokenKey = 'fcm_token';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _subSectionKey = 'sub_section_key';
  static const String _userTokenKey = 'user_token';
  static const String _mockSubjectsKey = 'mock_subjects';
  static const String _randomQuestionCheckKey = 'random_question_check';

  /// Initialize shared preferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// For testing/mocking if needed
  static void setStorage(SharedPreferences preferences) {
    _prefs = preferences;
  }

  // ───── User Token ─────
  static Future<void> setUserToken(String token) async =>
      await _prefs.setString(_userTokenKey, token);

  static String getUserToken() => _prefs.getString(_userTokenKey) ?? "";

  static Future<void> removeUserToken() async =>
      await _prefs.remove(_userTokenKey);

  // ───── Theme ─────
  static Future<void> setThemeIsLight(bool isLight) async =>
      await _prefs.setBool(_lightThemeKey, isLight);

  static bool getThemeIsLight() => _prefs.getBool(_lightThemeKey) ?? true;

  // ───── Language ─────
  static Future<void> setCurrentLanguage(String languageCode) async =>
      await _prefs.setString(_currentLocalKey, languageCode);

  static Locale getCurrentLocal() {
    final langCode = _prefs.getString(_currentLocalKey);
    return LocalizationService.supportedLanguages[langCode] ??
        LocalizationService.defaultLanguage;
  }

  // ───── FCM Token ─────
  static Future<void> setFcmToken(String token) async =>
      await _prefs.setString(_fcmTokenKey, token);

  static String? getFcmToken() => _prefs.getString(_fcmTokenKey);

  // ───── General Clear ─────
  static Future<void> clear() async => await _prefs.clear();

  // ───── MockSubject ─────
  static Future<void> addOrUpdateMockSubjectSelect(
      MockSubjectSelect subject) async {
    List<String> list = _prefs.getStringList(_mockSubjectsKey) ?? [];
    List<MockSubjectSelect> subjects =
        list.map(MockSubjectSelect.fromJson).toList();

    int index = subjects.indexWhere((s) => s.id == subject.id);
    if (index != -1) {
      subjects[index] = subject;
    } else {
      subjects.add(subject);
    }

    List<String> updatedList = subjects.map((e) => e.toJson()).toList();
    await _prefs.setStringList(_mockSubjectsKey, updatedList);
  }

  static Future<void> removeMockSubjectSelect(MockSubjectSelect subject) async {
    List<String> list = _prefs.getStringList(_mockSubjectsKey) ?? [];
    List<MockSubjectSelect> subjects =
        list.map(MockSubjectSelect.fromJson).toList();

    subjects.removeWhere((s) => s.id == subject.id);

    List<String> updatedList = subjects.map((e) => e.toJson()).toList();
    await _prefs.setStringList(_mockSubjectsKey, updatedList);
  }

  static Future<List<MockSubjectSelect>> getMockSubjects() async {
    List<String> list = _prefs.getStringList(_mockSubjectsKey) ?? [];
    return list.map(MockSubjectSelect.fromJson).toList();
  }

  static Future<void> clearMockSubjects() async =>
      await _prefs.remove(_mockSubjectsKey);

  static Future<bool> isMockSubjectExist(int id) async {
    List<String> list = _prefs.getStringList(_mockSubjectsKey) ?? [];
    List<MockSubjectSelect> subjects =
        list.map(MockSubjectSelect.fromJson).toList();

    return subjects.any((s) => s.id == id);
  }

  /// ───── Subject Section ─────
  static Future<void> addOrUpdateSubjectSectionSelect(
      SubjectSectionSelect subject) async {
    List<String> list = _prefs.getStringList(_subSectionKey) ?? [];
    List<SubjectSectionSelect> subjects =
        list.map(SubjectSectionSelect.fromJson).toList();

    int index = subjects.indexWhere((s) => s.id == subject.id);
    if (index != -1) {
      subjects[index] = subject;
    } else {
      subjects.add(subject);
    }

    List<String> updatedList = subjects.map((e) => e.toJson()).toList();
    await _prefs.setStringList(_subSectionKey, updatedList);
  }

  static Future<void> removeSubjectSectionSelect(
      SubjectSectionSelect subject) async {
    List<String> list = _prefs.getStringList(_subSectionKey) ?? [];
    List<SubjectSectionSelect> subjects =
        list.map(SubjectSectionSelect.fromJson).toList();

    subjects.removeWhere((s) => s.id == subject.id);

    List<String> updatedList = subjects.map((e) => e.toJson()).toList();
    await _prefs.setStringList(_subSectionKey, updatedList);
  }

  static Future<List<SubjectSectionSelect>> getSubjectSection() async {
    List<String> list = _prefs.getStringList(_subSectionKey) ?? [];
    return list.map(SubjectSectionSelect.fromJson).toList();
  }

  static Future<void> clearSubjectSection() async =>
      await _prefs.remove(_subSectionKey);

  static Future<bool> isSubjectSectionExist(int id) async {
    List<String> list = _prefs.getStringList(_subSectionKey) ?? [];
    List<SubjectSectionSelect> subjects =
        list.map(SubjectSectionSelect.fromJson).toList();

    return subjects.any((s) => s.id == id);
  }

  /// ───── Random Question Counter ─────
  static Future<void> incrementRandomQuestionCheck() async {
    int current = _prefs.getInt(_randomQuestionCheckKey) ?? 0;
    current++;
    await _prefs.setInt(_randomQuestionCheckKey, current);
  }

  static Future<int> getRandomQuestionCheck() async =>
      _prefs.getInt(_randomQuestionCheckKey) ?? 0;
}
