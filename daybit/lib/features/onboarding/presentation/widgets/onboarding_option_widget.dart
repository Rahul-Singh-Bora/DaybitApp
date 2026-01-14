import 'package:flutter/material.dart';

class OnboardingOptionWidget extends StatelessWidget {
  final String label;
  final String? emoji; // Made nullable
  final String? description; // Added description
  final bool isSelected;
  final VoidCallback onTap;

  const OnboardingOptionWidget({
    super.key,
    required this.label,
    this.emoji,
    this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align to center vertically
          children: [
            // Custom Radio Button
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black, // Always black border
                  width: 2.5,
                ),
                color: Colors.transparent,
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: isSelected ? Curves.easeOutBack : Curves.easeOut,
                  width: isSelected ? 14 : 0,
                  height: isSelected ? 14 : 0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Emoji (if present)
            if (emoji != null) ...[
              Text(emoji!, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
            ],

            // Text Content (Label + Description)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Wrap content
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey, // Lighter color for description
                        height: 1.2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
