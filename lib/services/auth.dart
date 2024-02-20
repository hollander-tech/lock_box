import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lock_box/providers/passwords.dart';
import 'package:provider/provider.dart';

import '../screens/home/home.dart';
import '../screens/login/login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool checkAuthState() => _auth.currentUser != null;
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  AuthGateState createState() => AuthGateState();
}

class AuthGateState extends State<AuthGate> {
  final AuthService _authService = AuthService();
  late Future _fetchFuture;

  @override
  void initState() {
    if (_authService.checkAuthState()) {
      PasswordProvider passwordProvider =
          Provider.of<PasswordProvider>(context, listen: false);

      passwordProvider.passwordsRef = passwordProvider.firestore
          .collection('passwords')
          .doc(passwordProvider.auth.currentUser!.uid)
          .collection('passwords');
      _fetchFuture = passwordProvider.fetch();
    }
    _authService._auth.setPersistence(Persistence.SESSION);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _authService.checkAuthState()
        ? FutureBuilder(
            future: _fetchFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const HomeScreen();
              }
            })
        : const LoginScreen();
  }
}
