class AppConstants {
  static const String baseUrl = "https://lokkha.com/api";
  static const String storageUrl = 'https://lokkha.com/uploads/';

  // Auth Endpoints
  static const String checkPhoneNumber = "$baseUrl/check-phone-number";
  static const String sendOtp = "$baseUrl/send-otp";
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String updateProfileRequired =
      "$baseUrl/update-profile-required";
  static const String updateProfileInfo = "$baseUrl/update-profile-info";
  static const String me = "$baseUrl/me";
  static const String authCheck = "$baseUrl/auth-check";
  static const String logout = "$baseUrl/logout";

  // Subjects
  static const String subjects = "$baseUrl/subjects";
  static const String testExamStart = "$baseUrl/test-exam/start";
  // Home Screen api
  static const String sliders = "$baseUrl/sliders";
}
