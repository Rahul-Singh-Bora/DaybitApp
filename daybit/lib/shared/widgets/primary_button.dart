import 'package:flutter/material.dart';

/// A reusable primary button widget with solid background
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final FontWeight fontWeight;
  final double letterSpacing;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 60.0,
    this.fontSize = 18.0,
    this.backgroundColor = const Color(0xFF6FAE6C),
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.letterSpacing = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
              letterSpacing: letterSpacing,
            ),
          ),
        ),
      ),
    );
  }
}
