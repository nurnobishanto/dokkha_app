import 'package:get/get.dart';

import '../modules/auth_views/auth_gateway/bindings/auth_gateway_binding.dart';
import '../modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import '../modules/auth_views/forget_password/bindings/forget_password_binding.dart';
import '../modules/auth_views/forget_password/views/forget_password_view.dart';
import '../modules/auth_views/sign_up/bindings/sign_up_binding.dart';
import '../modules/auth_views/sign_up/views/sign_up_view.dart';
import '../modules/auth_views/signin/bindings/signin_binding.dart';
import '../modules/auth_views/signin/views/signin_view.dart';
import '../modules/auth_views/terms_condition/bindings/terms_condition_binding.dart';
import '../modules/auth_views/terms_condition/views/terms_condition_view.dart';
import '../modules/auth_views/verify_otp/bindings/verify_otp_binding.dart';
import '../modules/auth_views/verify_otp/views/verify_otp_view.dart';
import '../modules/grid_views/ajker_bissho/bindings/ajker_bissho_binding.dart';
import '../modules/grid_views/ajker_bissho/views/ajker_bissho_view.dart';
import '../modules/grid_views/ajker_porikkha/bindings/ajker_porikkha_binding.dart';
import '../modules/grid_views/ajker_porikkha/views/ajker_porikkha_view.dart';
import '../modules/grid_views/jobs_update/bindings/jobs_update_binding.dart';
import '../modules/grid_views/jobs_update/views/jobs_update_view.dart';
import '../modules/grid_views/mock_test/bindings/mock_test_binding.dart';
import '../modules/grid_views/mock_test/views/mock_test_view.dart';
import '../modules/grid_views/notice_board/bindings/notice_board_binding.dart';
import '../modules/grid_views/notice_board/views/notice_board_view.dart';
import '../modules/nab_bar_views/blog/bindings/blog_binding.dart';
import '../modules/nab_bar_views/blog/views/blog_view.dart';
import '../modules/nab_bar_views/contest/bindings/contest_binding.dart';
import '../modules/nab_bar_views/contest/views/contest_view.dart';
import '../modules/nab_bar_views/home/bindings/home_binding.dart';
import '../modules/nab_bar_views/home/views/home_view.dart';
import '../modules/nab_bar_views/profile/bindings/profile_binding.dart';
import '../modules/nab_bar_views/profile/views/profile_view.dart';
import '../modules/nab_bar_views/question_bank/bindings/question_bank_binding.dart';
import '../modules/nab_bar_views/question_bank/views/question_bank_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../views/views/onboarding_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.QUESTION_BANK,
      page: () => const QuestionBankView(),
      binding: QuestionBankBinding(),
    ),
    GetPage(
      name: _Paths.CONTEST,
      page: () => const ContestView(),
      binding: ContestBinding(),
    ),
    GetPage(
      name: _Paths.BLOG,
      page: () => const BlogView(),
      binding: BlogBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MOCK_TEST,
      page: () => const MockTestView(),
      binding: MockTestBinding(),
    ),
    GetPage(
      name: _Paths.AJKER_PORIKKHA,
      page: () => const AjkerPorikkhaView(),
      binding: AjkerPorikkhaBinding(),
    ),
    GetPage(
      name: _Paths.JOBS_UPDATE,
      page: () => const JobsUpdateView(),
      binding: JobsUpdateBinding(),
    ),
    GetPage(
      name: _Paths.AJKER_BISSHO,
      page: () => const AjkerBisshoView(),
      binding: AjkerBisshoBinding(),
    ),
    GetPage(
      name: _Paths.NOTICE_BOARD,
      page: () => const NoticeBoardView(),
      binding: NoticeBoardBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION,
      page: () => const TermsConditionView(),
      binding: TermsConditionBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_GATEWAY,
      page: () => const AuthGatewayView(),
      binding: AuthGatewayBinding(),
    ),
  ];
}
