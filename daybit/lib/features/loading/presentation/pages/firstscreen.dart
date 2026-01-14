import 'package:daybit/core/config/app_lottie.dart';
import 'package:daybit/core/config/app_vectors.dart';
import 'package:daybit/shared/utils/app_navigation.dart';
import 'package:daybit/shared/widgets/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'secondscreen.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to second screen with instant transition
        // Let the second screen handle its own slide-in animation
        AppNavigation.pushWithTransition(
          context,
          const SecondScreen(),
          duration: Duration.zero,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleArrowTap() {
    if (!_isAnimating) {
      setState(() {
        _isAnimating = true;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive scale factors
    final scaleFactor = screenWidth / 400; // Base width of 400
    final fontSize = (52 * scaleFactor).clamp(32.0, 72.0);
    final horizontalPadding = (32 * scaleFactor).clamp(20.0, 48.0);
    final topSpacing = (60 * scaleFactor).clamp(40.0, 80.0);
    final bottomSpacing = (80 * scaleFactor).clamp(40.0, 100.0);
    final buttonSize = (80 * scaleFactor).clamp(60.0, 100.0);
    final circleSize = (182 * scaleFactor).clamp(140.0, 220.0);
    final decorSize = (30 * scaleFactor).clamp(24.0, 36.0);

    return Scaffold(
      backgroundColor: const Color(0xFF272727),
      body: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(-screenWidth * _scaleAnimation.value, 0),
            child: Stack(
              children: [
                // Green circle in top-left corner
                Positioned(
                  top: -circleSize * 0.45,
                  left: -circleSize * 0.45,
                  child: SvgPicture.asset(
                    AppVectors.rectangle3,
                    width: circleSize * 1.2,
                    height: circleSize * 1.2,
                  ),
                ),

                // Main content
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: topSpacing),

                        // "PROGRESS" with decorative crown on last S
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Text(
                              'PROGRESS',
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.0,
                                letterSpacing: -1,
                              ),
                            ),
                            Positioned(
                              top: -(decorSize * 0.6),
                              right: -(decorSize * 0.7),
                              child: Transform.rotate(
                                angle: 0.10,
                                child: SvgPicture.asset(
                                  AppVectors.group39,
                                  width: decorSize,
                                  height: decorSize,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // "STARTS WITH"
                        Text(
                          'STARTS WITH',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF6FAE6C),
                            height: 1.0,
                            letterSpacing: -1,
                          ),
                        ),

                        // "DAILY"
                        Text(
                          'DAILY',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.0,
                            letterSpacing: -1,
                          ),
                        ),

                        // "ACTION"
                        Text(
                          'ACTION',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.0,
                            letterSpacing: -1,
                          ),
                        ),

                        const Spacer(),

                        // Lottie animation in center
                        Center(
                          child: Lottie.asset(
                            AppLottie.runningCharacter,
                            width: screenWidth * 0.5,
                            height: screenWidth * 0.5,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const Spacer(),

                        // Bottom arrow button with slide animation
                        Center(
                          child: ArrowButton(
                            onTap: _handleArrowTap,
                            size: buttonSize,
                          ),
                        ),

                        SizedBox(height: bottomSpacing),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
