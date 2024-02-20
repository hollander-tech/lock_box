import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
                'Your account has not yet been verified. Please click the link in the verification email sent to ${_auth.currentUser!.email}'),
            const SizedBox(height: 16.0,),
            ElevatedButton.icon(onPressed: () {
              _auth.currentUser!.sendEmailVerification();
            }, icon: const Icon(Icons.email), label: const Text("Resend verification email"),)
          ],
        ),
      ),
    );
  }
}
