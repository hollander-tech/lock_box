import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lock_box/providers/passwords.dart';
import 'package:lock_box/screens/add_password/add_password.dart';
import 'package:lock_box/screens/home/widgets/password_list_tile.dart';
import 'package:provider/provider.dart';

import '../../models/password.dart';
import '../../services/auth.dart';
import '../../widgets/body_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LockBox'),
        actions: [
          Tooltip(
            message: 'Logout',
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthGate()));
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BodyContainer(
          child: Consumer<PasswordProvider>(
            builder: (context, provider, child) {
              if (provider.passwords.isEmpty) {
                return const Center(
                    child: Text(
                  'No passwords to display.\nUse the \'Add\' button to get started!',
                  textAlign: TextAlign.center,
                ));
              } else {
                List<Password> sortedPasswords = List.from(provider.passwords);
                sortedPasswords.sort((a, b) => a.title.compareTo(b.title));

                return Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: sortedPasswords.length,
                    itemBuilder: (context, index) =>
                        PasswordListTile(sortedPasswords[index]),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddPasswordScreen()),
        ),
      ),
    );
  }
}
