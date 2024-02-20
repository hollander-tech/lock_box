
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {

  final bool isEditing;
  final TextEditingController controller;
  const TitleField({required this.controller, required this.isEditing, super.key});

  @override
  Widget build(BuildContext context) {
    return isEditing
        ?
    TextField(
      controller: controller,
      style: Theme.of(context).textTheme.headlineMedium,
    )
        : Text(
      controller.text,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

}