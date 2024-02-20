import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final bool isEditing;
  final TextEditingController controller;
  const NotesField(
      {required this.controller, required this.isEditing, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Notes",
              style: Theme.of(context).textTheme.bodyMedium,
            )),
        isEditing
            ? TextField(
                controller: controller,
                style: Theme.of(context).textTheme.bodyLarge,
                maxLines: null,
              )
            : Text(
                controller.text,
                style: Theme.of(context).textTheme.bodyLarge,
              )
      ],
    );
  }
}
