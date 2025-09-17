import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'app/data/local/my_shared_pref.dart';
import 'app/helper/global.dart';
import 'my_app/views/my_app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(".env load failed: $e");
  }

  // Init SharedPreferences safely
  try {
    await MySharedPref.init();
  } catch (e) {
    debugPrint("SharedPreferences init failed: $e");
  }

  // Init OneSignal safely
  final oneSignalAppId = dotenv.env['ONESIGNAL_APP_ID'];
  if (oneSignalAppId != null && oneSignalAppId.isNotEmpty) {
    try {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      OneSignal.initialize(oneSignalAppId);
      OneSignal.Notifications.requestPermission(true);
    } catch (e) {
      debugPrint("OneSignal init failed: $e");
    }
  } else {
    debugPrint("ONESIGNAL_APP_ID not found in .env");
  }

  fetchAppVersion();
  runApp(const MyApp());
}

// void main() {
//   runApp(const MaterialApp(home: Scaffold(body: Center(child: Text("Hello")))));
// }
//

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   debugPrint("Initializing SharedPreferences...");
//   await MySharedPref.init();
//   debugPrint("Init complete. Starting app...");
//
//   FlutterError.onError = (FlutterErrorDetails details) {
//     FlutterError.presentError(details);
//     navigatorKey.currentState?.pushReplacement(
//       MaterialPageRoute(
//         builder: (_) => ErrorScreen(errorDetails: details),
//       ),
//     );
//   };
//
//   runZonedGuarded(() {
//     runApp(MyApp(
//       navigatorKey: navigatorKey,
//     ));
//   }, (error, stack) {
//     navigatorKey.currentState?.pushReplacement(
//       MaterialPageRoute(
//         builder: (_) => ErrorScreen(
//           errorDetails: FlutterErrorDetails(
//             exception: error,
//             stack: stack,
//           ),
//         ),
//       ),
//     );
//   });
// }

// class ErrorScreen extends StatelessWidget {
//   final FlutterErrorDetails errorDetails;
//   const ErrorScreen({super.key, required this.errorDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Error")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Text(
//             "An error occurred:\n\n${errorDetails.exceptionAsString()}",
//             style: const TextStyle(fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
