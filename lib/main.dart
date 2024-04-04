import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lock_box/providers/passwords.dart';
import 'package:lock_box/services/auth.dart';
import 'package:provider/provider.dart';

import 'color_schemes.g.dart';
import 'firebase_options.dart';
import 'env/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  FirebaseUIAuth.configureProviders([
    GoogleProvider(
        clientId: Platform.isIOS ? Env.googleClientIdIos : Platform.isAndroid ? Env.googleClientIdAndroid : Env.googleClientIdWeb,
    ),
  ]);
  runApp(ChangeNotifierProvider(
    create: (context) => PasswordProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LockBox',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme, textTheme: GoogleFonts.poppinsTextTheme()),
      home: const AuthGate(),
    );
  }
}
