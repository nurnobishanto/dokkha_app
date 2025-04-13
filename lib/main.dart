import 'package:lokkha/app.dart';
import 'package:flutter/material.dart';
import 'app/data/local/my_shared_pref.dart';

Future<void> main() async {
  // wait for bindings
  WidgetsFlutterBinding.ensureInitialized();
  // init shared preference
  await MySharedPref.init();
  runApp(const MyApp());
}
