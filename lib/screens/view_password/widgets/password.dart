import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordField extends StatefulWidget {
  final bool isEditing;
  final TextEditingController controller;
  const PasswordField(
      {required this.controller, required this.isEditing, super.key});

  @override
  State<StatefulWidget> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        widget.isEditing
            ? TextField(
                controller: widget.controller,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : Row(
                children: [
                  Expanded(
                    child: Text(
                      isObscure ? "************" : widget.controller.text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() {
                            isObscure = !isObscure;
                          })),
                  IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                                ClipboardData(text: widget.controller.text))
                            .then(
                          (value) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Password copied to clipboard!')));
                          },
                        );
                      })
                ],
              )
      ],
    );
  }
}
