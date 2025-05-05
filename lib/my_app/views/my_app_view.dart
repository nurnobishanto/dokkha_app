import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/nav_bar_views/home/controllers/home_controller.dart';
import '../../app/bindings/initial_bindings.dart';
import '../../app/data/local/my_shared_pref.dart';
import '../../app/helper/global.dart';
import '../../app/routes/app_pages.dart';
import '../../app/services/auth_service.dart';
import '../../config/constants/app_strings.dart';
import '../../config/theme/my_theme.dart';
import '../../config/translations/localization_service.dart';

class MyApp extends StatelessWidget {
 // final GlobalKey<NavigatorState> navigatorKey;
  //const MyApp({super.key, required this.navigatorKey});
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("MyApp Called");

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, widget) {
        printAppInfo(); // optional log
        return GetMaterialApp(
         // navigatorKey: navigatorKey,
          title: AppStrings.appName,
          initialBinding: InitialBindings(),
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          builder: (context, widget) {
            bool isLight = MySharedPref.getThemeIsLight();
            return Theme(
              data: MyTheme.getThemeData(isLight: isLight),
              child: MediaQuery(
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
