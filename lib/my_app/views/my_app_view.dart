import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/views/widgets/random.dart';
import '../../app/bindings/initial_bindings.dart';
import '../../app/data/local/my_shared_pref.dart';
import '../../app/helper/global.dart';
import '../../app/routes/app_pages.dart';
import '../../config/constants/app_strings.dart';
import '../../config/theme/my_theme.dart';
import '../../config/translations/localization_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("MyApp Started....");

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        printAppInfo();
        final isLight = MySharedPref.getThemeIsLight();
        return GetMaterialApp(
          // showPerformanceOverlay: true,
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBindings(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          //home: RandomPage(),
          useInheritedMediaQuery: true,
          locale: MySharedPref.getCurrentLocal(),
          translations: LocalizationService.getInstance(),
          builder: (context, widget) => Theme(
            data: MyTheme.getThemeData(isLight: isLight),
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: widget!,
            ),
          ),
        );
      },
    );
  }
}
