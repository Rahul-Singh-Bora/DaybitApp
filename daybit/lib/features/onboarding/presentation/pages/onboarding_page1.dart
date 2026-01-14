import 'package:flutter/material.dart';
import 'package:daybit/shared/widgets/arrow_button.dart';
import '../widgets/onboarding_option_widget.dart';
import '../widgets/progress_bar_widget.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Store selected index for each step. -1 indicates no selection.
  final List<int> _selectedOptions = [-1, -1, -1];

  final List<Map<String, dynamic>> _questions = [
    {
      'questionTitle': 'Question 1',
      'title': 'What do you want to improve right now?',
      'subtitle': null,
      'options': [
        {'emoji': '💪', 'label': 'Fitness & Health'},
        {'emoji': '📚', 'label': 'Study & Learning'},
        {'emoji': '🧠', 'label': 'Focus & Productivity'},
        {'emoji': '😴', 'label': 'Sleep & Routine'},
        {'emoji': '🧘', 'label': 'Mental Well-being'},
        {'emoji': '📖', 'label': 'Reading & Self-growth'},
      ],
    },
    {
      'questionTitle': 'Question 2',
      'title': 'What do you want to improve right now?', // Keeping as per image
      'subtitle': 'We’ll schedule them at the best time for you.',
      'options': [
        {'emoji': null, 'label': 'Morning'},
        {'emoji': null, 'label': 'Afternoon'},
        {'emoji': null, 'label': 'Evening'},
        {'emoji': null, 'label': 'Night'},
      ],
    },
    {
      'questionTitle': 'Question 3',
      'title': 'How intense should your habits be?',
      'subtitle': 'Start easy or push yourself — your choice.',
      'options': [
        {
          'emoji':
              null, // Radio button style implies bullets maybe? But design shows just circle and text
          'label': 'Easy',
          'description': 'Small steps, low effort',
        },
        {
          'emoji': null,
          'label': 'Balanced',
          'description': 'Realistic and consistent',
        },
        {'emoji': null, 'label': 'Challenging', 'description': 'Push me hard'},
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleNext() {
    if (_selectedOptions[_currentStep] != -1) {
      if (_currentStep < _questions.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Final step completion logic
        // TODO: Navigate to Home or next feature
        print("Onboarding Completed: $_selectedOptions");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an option to continue')),
      );
    }
  }

  void _handleBack() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context); // Go back to "Let's Start" page
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentStep = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF272727),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation Bar (Back Arrow)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),

            // Progress Indicator Section (Arrows + Bar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _handleBack,
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white70,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Text(
                        '0${_currentStep + 1}/03',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Allow going forward via top arrow only if option selected?
                          // Usually top arrows allow browsing, but bottom is for "Next".
                          // Requirement: "the abouve arrow can change the question"
                          // Design typically allows browsing back/forth.
                          if (_currentStep < _questions.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white70,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OnboardingProgressBar(
                    currentStep: _currentStep + 1,
                    totalSteps: 3,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Question Title (Animated or Static? Usually static but content changes)
            Center(
              child: Text(
                _questions[_currentStep]['questionTitle'],
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // PageView for Questions
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable swipe as per "two arrow above user can go through"
                onPageChanged: _onPageChanged,
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  final options =
                      question['options'] as List<Map<String, dynamic>>;

                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 10,
                    ), // Optional visual spacing
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question['title'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.2,
                          ),
                        ),
                        if (question['subtitle'] != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            question['subtitle'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                        const SizedBox(height: 30),

                        // Options List
                        Expanded(
                          child: ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (context, optionIndex) {
                              final option = options[optionIndex];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: OnboardingOptionWidget(
                                  label: option['label'],
                                  emoji: option['emoji'],
                                  description: option['description'],
                                  isSelected:
                                      _selectedOptions[index] == optionIndex,
                                  onTap: () async {
                                    if (_selectedOptions[index] != -1 &&
                                        _selectedOptions[index] !=
                                            optionIndex) {
                                      // Shrink previous selection
                                      setState(() {
                                        _selectedOptions[index] = -1;
                                      });
                                      // Wait for shrink animation
                                      await Future.delayed(
                                        const Duration(milliseconds: 150),
                                      );
                                    }
                                    // Grow new selection
                                    if (mounted) {
                                      setState(() {
                                        _selectedOptions[index] = optionIndex;
                                      });
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        // Next Button (Green Arrow)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: ArrowButton(onTap: _handleNext, size: 70),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
