import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {

  final Widget child;

  const BodyContainer({required this.child,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: child,
        ),
      ),
    );
  }

}