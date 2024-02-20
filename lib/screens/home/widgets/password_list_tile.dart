import 'package:flutter/material.dart';

import '../../../models/password.dart';
import '../../view_password/view_password.dart';

class PasswordListTile extends StatelessWidget {
  final Password password;
  const PasswordListTile(this.password, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(password.title),
      subtitle: Text(password.username),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ViewPasswordScreen(password)));
      },
    );
  }
}
