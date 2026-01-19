import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ActiveHabitsGrid extends StatelessWidget {
  const ActiveHabitsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual habits data
    final hasHabits = false; // Change to true when habits exist

    if (!hasHabits) {
      return Transform.translate(
        offset: const Offset(0, -30), // Pull up by 30 pixels
        child: Center(
          child: Column(
            children: [
              // Lottie animation
              Lottie.asset(
                'lib/features/Home/Assets/lottie/Squirrel Sleeping.json',
                width: 400,
                height: 300,
                fit: BoxFit.contain,
              ),

              Text(
                'No habits yet',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap the + button to add your first habit',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color.fromRGBO(255, 255, 255, 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // When habits exist, show them in a grid
  }
}
