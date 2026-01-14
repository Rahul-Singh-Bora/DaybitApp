import 'package:flutter/material.dart';

/// A reusable secondary button widget with outlined style
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double fontSize;
  final Color borderColor;
  final Color textColor;
  final FontWeight fontWeight;
  final double letterSpacing;
  final double borderWidth;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 60.0,
    this.fontSize = 14.0,
    this.borderColor = const Color(0xFF6FAE6C),
    this.textColor = const Color(0xFF6FAE6C),
    this.fontWeight = FontWeight.w600,
    this.letterSpacing = 0.5,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(height / 2),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
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
        ),
      ),
    );
  }
}
