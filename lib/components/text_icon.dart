import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final Widget label;
  final Icon icon;
  const TextIcon({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 8),
          label,
        ],
      ),
    );
  }
}
