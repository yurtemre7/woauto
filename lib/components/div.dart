import 'package:flutter/material.dart';

class Div extends StatelessWidget {
  const Div({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey.withValues(alpha: 0.5),
    );
  }
}
