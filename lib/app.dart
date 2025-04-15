import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/bindings/initial_bindings.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/routes/app_pages.dart';
import 'app/services/auth_service.dart';
import 'config/constants/app_strings.dart';
import 'app/helper/global.dart';
import 'config/theme/my_theme.dart';
import 'config/translations/localization_service.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AuthService authService = AuthService();
  static bool _isAuthChecked = false;

  @override
  Widget build(BuildContext context) {
    if (!_isAuthChecked) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        authService.authCheck();
      });
      _isAuthChecked = true;
    }

    return ScreenUtilInit(
      // Todo: Figma art board size
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        printAppInfo();
        return GetMaterialApp(
          // todo add your app name
          title: AppStrings.appName,
          initialBinding: InitialBindings(),
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            bool themeIsLight = MySharedPref.getThemeIsLight();
            return Theme(
              data: MyTheme.getThemeData(isLight: themeIsLight),
              child: MediaQuery(
                // prevent font from scaling (some people use big/small device fonts)
                // but we want our app font to still the same and don't get affected
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: widget!,
              ),
            );
          },
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: MySharedPref.getCurrentLocal(),
          translations: LocalizationService.getInstance(),
        );
      },
    );
  }
}
