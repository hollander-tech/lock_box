import 'package:flutter/material.dart';
import 'package:lock_box/providers/passwords.dart';
import 'package:provider/provider.dart';

import '../../../services/auth.dart';

class DeleteButton extends StatelessWidget {
  final String docId;
  const DeleteButton(this.docId, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: const Text(
                        'Are you sure you want to delete this password entry?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await Provider.of<PasswordProvider>(context,
                                  listen: false)
                              .deletePassword(docId);
                          if (!context.mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const AuthGate()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ));
        },
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.resolveWith((states) => Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
              mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.delete),
            SizedBox(width: 12.0),
            Text('Delete')
          ]),
        ));
  }
}
