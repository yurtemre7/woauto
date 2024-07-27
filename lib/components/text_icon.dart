import 'package:flutter/material.dart';
import 'package:woauto/utils/extensions.dart';

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
          8.w,
          label,
        ],
      ),
    );
  }
}
