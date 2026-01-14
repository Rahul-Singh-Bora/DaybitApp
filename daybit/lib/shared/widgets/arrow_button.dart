import 'package:flutter/material.dart';

/// A reusable circular arrow button widget with customizable properties
class ArrowButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final double? iconSize;

  const ArrowButton({
    super.key,
    required this.onTap,
    this.size = 80.0,
    this.backgroundColor = const Color(0xFF6FAE6C),
    this.iconColor = Colors.white,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final calculatedIconSize = iconSize ?? size * 0.45;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_forward,
          color: iconColor,
          size: calculatedIconSize,
        ),
      ),
    );
  }
}
