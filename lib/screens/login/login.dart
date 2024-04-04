import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../env/env.dart';
import '../../services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/logo.png'),
            width: 200.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            "LockBox",
            style: GoogleFonts.poppins()
                .copyWith(fontSize: 72.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 32.0),
          SizedBox(
              width: 320.0,
              child: GoogleSignInButton(
                onError: (e) => print(e),
                label: "Sign in with HL Account",
                loadingIndicator: const CircularProgressIndicator(),
                clientId: Platform.isIOS ? Env.googleClientIdIos : Platform.isAndroid ? Env.googleClientIdAndroid : Env.googleClientIdWeb,
                onSignedIn: (UserCredential? credential) =>
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthGate())),
              )),
        ],
      )),
    );
  }
}
