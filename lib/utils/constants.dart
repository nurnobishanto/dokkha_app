class AppConstants {
  static const String baseUrl = "https://lokkha.com";
  static const String appUrl = "$baseUrl/api";
  static const String storageUrl = 'https://lokkha.com/uploads/';

  // Auth Endpoints
  static const String checkPhoneNumber = "$appUrl/check-phone-number";
  static const String sendOtp = "$appUrl/send-otp";
  static const String login = "$appUrl/login";
  static const String register = "$appUrl/register";
  static const String appVersionCheckApi = "$appUrl/app/update";
  static const String updateProfileRequired =
      "$appUrl/update-profile-required";
  static const String updateProfileInfo = "$appUrl/update-profile-info";
  static const String me = "$appUrl/me";
  static const String authCheck = "$appUrl/auth-check";
  static const String logout = "$appUrl/logout";

  // Subjects
  static const String subjects = "$appUrl/subjects";
  static const String testExamStart = "$appUrl/test-exam/start";
  static const String testExamSubmit = "$appUrl/test-exam/submit";
  ///  Favorite
  static const String questionFavAdd = "$appUrl/question/favorite/add";
  static const String questionFavRemove = "$appUrl/question/favorite/remove";
  static const String questionFavList = "$appUrl/question/favorite/list";
  /// jobs
  static const String jobsList = "$appUrl/jobs";
  static const String job = "$appUrl/job";
  /// Random Question
  static const String randomQuestion = "$appUrl/random-question";
  /// Current Affairs
  static const String internationalCA = "$appUrl/current-affairs/international";
  static const String nationalCA = "$appUrl/current-affairs/national";
  // Home Screen api
  static const String sliders = "$appUrl/sliders";
  /// Drawer pages
  static const String privacyPolicy = "$appUrl/page/privacy-policy";
  static const String termsPolicy = "$appUrl/page/terms-and-conditions";
  static const String refundPolicy = "$appUrl/page/refund-policy";
  static const String contestPolicy = "$appUrl/page/contest-policy";
  static const String about = "$appUrl/page/about";
  /// Premium Package
  static const String premiumPackage = "$appUrl/packages";
  static const String packageOrderUrl = '$appUrl/package/order';
  static const String couponApply = '$appUrl/coupon-apply';

  /// Contest related
  static const String latestContest = "$appUrl/latest-contest";
  static const String startContest = "$appUrl/contest/";
  static const String latestContestResult = "$appUrl/latest-contest-result";
  static const String allContestList = "$appUrl/contest-list";

  /// Subject Section related..
  static const String subjectSections = "$appUrl/subject-sections";
  /// Subject Section related..
  static const String myPackages = "$appUrl/my-packages";
  static const String myOrders = "$appUrl/my-orders";
  static const String myOrdersDetails = "$appUrl/order-details";
  /// Latest Exam
  static const String latestExam = "$appUrl/latest-exams";

}
