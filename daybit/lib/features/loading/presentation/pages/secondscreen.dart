import 'package:daybit/features/Auth/presentation/login/login_scren.dart';
import 'package:daybit/features/Auth/presentation/signin/screen1.dart';
import 'package:daybit/core/config/app_vectors.dart';
import 'package:daybit/shared/utils/app_navigation.dart';
import 'package:daybit/shared/widgets/primary_button.dart';
import 'package:daybit/shared/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late AnimationController _exitController;
  late Animation<double> _exitAnimation;

  @override
  void initState() {
    super.initState();
    // Entrance animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Exit animation controller
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _exitAnimation = CurvedAnimation(
      parent: _exitController,
      curve: Curves.easeInOut,
    );

    // Start the entrance animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing calculations
    final isSmallScreen = screenWidth < 360;
    final isMediumScreen = screenWidth >= 360 && screenWidth < 400;
    final isLargeScreen = screenWidth >= 600;

    // Responsive padding
    final horizontalPadding = isSmallScreen
        ? 24.0
        : (isMediumScreen ? 28.0 : (isLargeScreen ? 48.0 : 32.0));

    // Responsive mascot size
    final mascotSize = isSmallScreen
        ? screenWidth * 0.40
        : (isLargeScreen ? screenWidth * 0.35 : screenWidth * 0.45);

    // Responsive font sizes
    final daybitFontSize = isSmallScreen
        ? 28.0
        : (isMediumScreen ? 32.0 : (isLargeScreen ? 48.0 : 36.0));
    final taglineFontSize = isSmallScreen
        ? 13.0
        : (isMediumScreen ? 14.0 : (isLargeScreen ? 20.0 : 16.0));
    final primaryButtonFontSize = isSmallScreen
        ? 15.0
        : (isMediumScreen ? 16.0 : (isLargeScreen ? 22.0 : 18.0));
    final secondaryButtonFontSize = isSmallScreen
        ? 12.0
        : (isMediumScreen ? 13.0 : (isLargeScreen ? 18.0 : 14.0));

    // Responsive button heights
    final buttonHeight = isSmallScreen ? 52.0 : (isLargeScreen ? 70.0 : 60.0);

    // Responsive spacing
    final titleSpacing = isSmallScreen ? 12.0 : (isLargeScreen ? 24.0 : 16.0);
    final buttonSpacing = isSmallScreen ? 16.0 : (isLargeScreen ? 28.0 : 20.0);
    final bottomSpacing = isSmallScreen ? 40.0 : (isLargeScreen ? 80.0 : 60.0);

    // Constrain maximum width for very large screens
    final maxWidth = isLargeScreen ? 600.0 : double.infinity;

    return Scaffold(
      backgroundColor: const Color(0xFF272727),
      body: AnimatedBuilder(
        animation: Listenable.merge([_scaleAnimation, _exitAnimation]),
        builder: (context, child) {
          final screenHeight = MediaQuery.of(context).size.height;
          return Transform.translate(
            offset: Offset(
              screenWidth * (1 - _scaleAnimation.value),
              -screenHeight * _exitAnimation.value,
            ),
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),

                        // Chick illustration
                        SizedBox(
                          width: mascotSize,
                          height: mascotSize,
                          child: SvgPicture.asset(
                            AppVectors.toki,
                            fit: BoxFit.contain,
                          ),
                        ),

                        // "DAYBIT" text with Itim font (explicit font override)
                        Text(
                          'DAYBIT',
                          style: GoogleFonts.itim(
                            fontSize: daybitFontSize,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF6FAE6C),
                            letterSpacing: 2,
                          ),
                        ),

                        SizedBox(height: titleSpacing),

                        // "MAKE DISCIPLINE FEEL EASY." text (uses default Inclusive Sans)
                        Text(
                          'MAKE DISCIPLINE FEEL EASY.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: taglineFontSize,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(255, 255, 255, 0.6),
                            letterSpacing: 0.5,
                          ),
                        ),

                        const Spacer(flex: 3),

                        // "GET STARTED" button
                        PrimaryButton(
                          text: 'GET STARTED',
                          onTap: () {
                            AppNavigation.pushWithSlideTransition(
                              context,
                              const Screen1(),
                              direction: SlideDirection.up,
                              duration: const Duration(milliseconds: 700),
                            );
                          },
                          height: buttonHeight,
                          fontSize: primaryButtonFontSize,
                        ),

                        SizedBox(height: buttonSpacing),

                        // "I ALREADY HAVE AN ACCOUNT" button
                        SecondaryButton(
                          text: 'I ALREADY HAVE AN ACCOUNT',
                          onTap: () {
                            _exitController.forward().then((_) {
                              AppNavigation.pushWithTransition(
                                context,
                                const LoginScreen(),
                                duration: Duration.zero,
                              ).then((_) {
                                // When returning from login, animate back in
                                _exitController.reverse();
                              });
                            });
                          },
                          height: buttonHeight,
                          fontSize: secondaryButtonFontSize,
                        ),

                        SizedBox(height: bottomSpacing),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
