import 'package:flutter/material.dart';
import '../../../../shared/widgets/arrow_button.dart';
import 'onboarding_option_widget.dart';

class OnboardingContent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Map<String, dynamic>> options;
  final int selectedOptionIndex;
  final Function(int) onOptionSelected;
  final VoidCallback onNext;
  final double scaleFactor;

  const OnboardingContent({
    super.key,
    required this.title,
    this.subtitle,
    required this.options,
    required this.selectedOptionIndex,
    required this.onOptionSelected,
    required this.onNext,
    this.scaleFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive calculations
    final titleSize = (22 * scaleFactor).clamp(18.0, 32.0);
    final subtitleSize = (16 * scaleFactor).clamp(14.0, 24.0);
    final contentPadding = (30 * scaleFactor).clamp(20.0, 40.0);
    final buttonSize = (70 * scaleFactor).clamp(50.0, 90.0);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10 * scaleFactor),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        contentPadding,
        40 * scaleFactor,
        contentPadding,
        20 * scaleFactor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),

          // Subtitle
          if (subtitle != null) ...[
            SizedBox(height: 16 * scaleFactor),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: subtitleSize,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],

          SizedBox(height: 30 * scaleFactor),

          // Options List
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.0 * scaleFactor),
                  child: OnboardingOptionWidget(
                    label: option['label'],
                    emoji: option['emoji'],
                    description: option['description'],
                    isSelected: selectedOptionIndex == index,
                    onTap: () => onOptionSelected(index),
                  ),
                );
              },
            ),
          ),

          // Next Button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(top: 10 * scaleFactor),
              child: ArrowButton(onTap: onNext, size: buttonSize),
            ),
          ),
        ],
      ),
    );
  }
}
