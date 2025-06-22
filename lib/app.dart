// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//   final AuthService authService = AuthService();
//   static bool _isAuthChecked = false;
//   fetchAppVersion();
//   @override
//   Widget build(BuildContext context) {
//     if (!_isAuthChecked) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         authService.authCheck();
//       });
//       _isAuthChecked = true;
//     }
//
//     return ScreenUtilInit(
//       // Todo: Figma art board size
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       useInheritedMediaQuery: true,
//       rebuildFactor: (old, data) => true,
//       builder: (context, widget) {
//         printAppInfo();
//         return GetMaterialApp(
//           // todo add your app name
//           title: AppStrings.appName,
//           initialBinding: InitialBindings(),
//           useInheritedMediaQuery: true,
//           debugShowCheckedModeBanner: false,
//           builder: (context, widget) {
//             bool themeIsLight = MySharedPref.getThemeIsLight();
//             return Theme(
//               data: MyTheme.getThemeData(isLight: themeIsLight),
//               child: MediaQuery(
//                 // prevent font from scaling (some people use big/small device fonts)
//                 // but we want our app font to still the same and don't get affected
//                 data: MediaQuery.of(context)
//                     .copyWith(textScaler: const TextScaler.linear(1.0)),
//                 child: widget!,
//               ),
//             );
//           },
//           initialRoute: AppPages.INITIAL,
//           getPages: AppPages.routes,
//           locale: MySharedPref.getCurrentLocal(),
//           translations: LocalizationService.getInstance(),
//         );
//       },
//     );
//   }
// }
