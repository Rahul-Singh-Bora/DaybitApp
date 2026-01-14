import 'package:daybit/core/config/app_images.dart';
import 'package:daybit/core/config/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing
    final isSmallScreen = screenWidth < 360;
    final isLargeScreen = screenWidth >= 600;

    final horizontalPadding = isSmallScreen
        ? 24.0
        : (isLargeScreen ? 48.0 : 32.0);
    final titleFontSize = isSmallScreen ? 21.0 : (isLargeScreen ? 31.0 : 25.0);
    final mascotSize = isSmallScreen
        ? screenWidth * 0.65
        : (isLargeScreen ? screenWidth * 0.50 : screenWidth * 0.70);
    final buttonFontSize = isSmallScreen ? 16.0 : (isLargeScreen ? 22.0 : 18.0);

    return Scaffold(
      backgroundColor: const Color(0xFF272727),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const Spacer(flex: 1),

              // Title text
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.4,
                  ),
                  children: const [
                    TextSpan(text: 'Let\'s personalize this for you\n'),
                    TextSpan(text: 'Answer a few quick questions\n'),
                    TextSpan(text: 'so we can build habits that\n'),
                    TextSpan(text: 'actually fit '),
                    TextSpan(
                      text: 'your life.',
                      style: TextStyle(color: Color(0xFF8B9DFF)),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Mascot with background
              SizedBox(
                width: mascotSize,
                height: mascotSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background circular image
                    ClipOval(
                      child: Image.asset(
                        AppImages.backgroundWall,
                        width: mascotSize,
                        height: mascotSize,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Mascot SVG on top
                    SizedBox(
                      width: mascotSize * 0.75,
                      height: mascotSize * 0.75,
                      child: SvgPicture.asset(
                        AppVectors.tokiWriting,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // "Lets Start" button - right aligned with arrow
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Navigate to next screen
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6FAE6C),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lets Start',
                          style: TextStyle(
                            fontSize: buttonFontSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
