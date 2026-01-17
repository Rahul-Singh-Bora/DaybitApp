import 'package:flutter/material.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/progress_bar_widget.dart';
import 'building_plan.dart';

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({super.key});

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentStepNotifier = ValueNotifier(0);

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
      'title': 'What do you want to improve right now?',
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
          'emoji': null,
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
    _currentStepNotifier.dispose();
    super.dispose();
  }

  void _handleNext() {
    final currentStep = _currentStepNotifier.value;
    if (_selectedOptions[currentStep] != -1) {
      if (currentStep < _questions.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // Final step completion logic
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BuildingPlanPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an option to continue')),
      );
    }
  }

  void _handleBack() {
    if (_currentStepNotifier.value > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _onPageChanged(int index) {
    _currentStepNotifier.value = index;
  }

  Future<void> _handleOptionSelect(int stepIndex, int optionIndex) async {
    if (_selectedOptions[stepIndex] != -1 &&
        _selectedOptions[stepIndex] != optionIndex) {
      // Shrink previous selection
      setState(() {
        _selectedOptions[stepIndex] = -1;
      });
      await Future.delayed(const Duration(milliseconds: 150));
    }
    // Grow new selection
    if (mounted) {
      setState(() {
        _selectedOptions[stepIndex] = optionIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Calculate Responsive Scale Factor
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 400; // Base design width

    // Responsive sizes for static elements
    final horizontalPadding = (32 * scaleFactor).clamp(16.0, 48.0);
    final topBarSpacing = (40 * scaleFactor).clamp(20.0, 60.0);
    final questionTitleSize = (18 * scaleFactor).clamp(14.0, 24.0);
    final progressTextSize = (16 * scaleFactor).clamp(12.0, 20.0);
    final iconSize = (28 * scaleFactor).clamp(24.0, 36.0);

    return Scaffold(
      backgroundColor: const Color(0xFF272727),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    horizontalPadding /
                    2, // Slightly less padding for back button
                vertical: 8.0 * scaleFactor,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
            ),

            // Progress Section
            ValueListenableBuilder<int>(
              valueListenable: _currentStepNotifier,
              builder: (context, currentStep, child) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
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
                                iconSize: iconSize,
                              ),
                              Text(
                                '0${currentStep + 1}/03',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: progressTextSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (currentStep < _questions.length - 1) {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
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
                                iconSize: iconSize,
                              ),
                            ],
                          ),
                          SizedBox(height: 8 * scaleFactor),
                          OnboardingProgressBar(
                            currentStep: currentStep + 1,
                            totalSteps: 3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: topBarSpacing),
                    // Question Title
                    Center(
                      child: Text(
                        _questions[currentStep]['questionTitle'],
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: questionTitleSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: 20 * scaleFactor),

            // PageContent using Reusable Widget
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _onPageChanged,
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  final options =
                      question['options'] as List<Map<String, dynamic>>;

                  return OnboardingContent(
                    title: question['title'],
                    subtitle: question['subtitle'],
                    options: options,
                    selectedOptionIndex: _selectedOptions[index],
                    onOptionSelected: (optionIndex) =>
                        _handleOptionSelect(index, optionIndex),
                    onNext: _handleNext,
                    scaleFactor: scaleFactor,
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
