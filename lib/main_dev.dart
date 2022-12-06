import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'app_entry.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'testing',
    options: DefaultFirebaseOptions.currentPlatform,
  );
 // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(
    const MyApp(),
  );
}
