import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsernameField extends StatelessWidget {
  final bool isEditing;
  final TextEditingController controller;
  const UsernameField(
      {required this.controller, required this.isEditing, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Username/Email",
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        isEditing
            ? TextField(
                controller: controller,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : Row(
                children: [
                  Expanded(
                    child: Text(
                      controller.text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: controller.text))
                            .then(
                          (value) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Username copied to clipboard!')));
                          },
                        );
                      })
                ],
              )
      ],
    );
  }
}
