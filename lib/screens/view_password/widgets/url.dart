import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlField extends StatelessWidget {
  final bool isEditing;
  final TextEditingController controller;
  const UrlField(
      {required this.controller, required this.isEditing, super.key});

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(controller.text))) {
      throw Exception('Could not launch ${controller.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "URL",
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
                      icon: const Icon(Icons.open_in_browser),
                      onPressed: () => _launchUrl())
                ],
              )
      ],
    );
  }
}
