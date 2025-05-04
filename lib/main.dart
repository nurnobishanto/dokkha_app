import 'dart:async';

import 'package:flutter/material.dart';
import 'app/data/local/my_shared_pref.dart';
import 'my_app/views/my_app_view.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   debugPrint("Initializing SharedPreferences...");
//   await MySharedPref.init();
//   debugPrint("Init complete. Starting app...");
//   runApp(const MyApp());
// }

// void main() {
//   runApp(const MaterialApp(home: Scaffold(body: Center(child: Text("Hello")))));
// }
//

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("Initializing SharedPreferences...");
  await MySharedPref.init();
  debugPrint("Init complete. Starting app...");

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (_) => ErrorScreen(errorDetails: details),
      ),
    );
  };

  runZonedGuarded(() {
    runApp(const MyApp());
  }, (error, stack) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (_) => ErrorScreen(
          errorDetails: FlutterErrorDetails(
            exception: error,
            stack: stack,
          ),
        ),
      ),
    );
  });
}

class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const ErrorScreen({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "An error occurred:\n\n${errorDetails.exceptionAsString()}",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
