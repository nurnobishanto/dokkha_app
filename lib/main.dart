import 'package:lokkha/app.dart';
import 'package:flutter/material.dart';
import 'app/data/local/my_shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing SharedPreferences...");
  await MySharedPref.init();
  print("Init complete. Starting app...");
  runApp(MyApp());
}

// void main() {
//   runApp(const MaterialApp(home: Scaffold(body: Center(child: Text("Hello")))));
// }
