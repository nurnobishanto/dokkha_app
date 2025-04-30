import 'package:lokkha/app.dart';
import 'package:flutter/material.dart';
import 'app/data/local/my_shared_pref.dart';
import 'my_app/views/my_app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("Initializing SharedPreferences...");
  await MySharedPref.init();
  debugPrint("Init complete. Starting app...");
  runApp(const MyApp());
}

// void main() {
//   runApp(const MaterialApp(home: Scaffold(body: Center(child: Text("Hello")))));
// }
