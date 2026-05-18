import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharmacypro/core/services/shared_pref/shared_pref.dart';

import 'app.dart';
import 'core/di/dependency_injection.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPref().instantiatePreferences();
  setupDependencies();

  runApp(const PharmaChainApp());
}
