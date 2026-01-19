import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final Size size;

  const HabitCard({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    // Calculate width to fit 2 items with spacing
    // screen width - padding (24*2) - spacing (16) / 2
    final double itemWidth = (size.width - 48 - 16) / 2;

    return Container(
      width: itemWidth,
      height: itemWidth, // Square
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}
