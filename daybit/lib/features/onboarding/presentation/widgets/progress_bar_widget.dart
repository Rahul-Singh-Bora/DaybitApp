import 'package:flutter/material.dart';

class OnboardingProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const OnboardingProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress (e.g. 1/3 = 0.33)
    final double progress = currentStep / totalSteps;

    return Stack(
      children: [
        // Background Line
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300], // Light grey background
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // Active Progress Line
        LayoutBuilder(
          builder: (context, constraints) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: constraints.maxWidth * progress,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF6FAE6C), // Green color
                borderRadius: BorderRadius.circular(2),
              ),
            );
          },
        ),
      ],
    );
  }
}
