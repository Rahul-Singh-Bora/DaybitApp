import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Firstscreen extends StatelessWidget {
  const Firstscreen({super.key});

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
    final iconSize = (36 * scaleFactor).clamp(28.0, 48.0);
    final circleSize = (182 * scaleFactor).clamp(140.0, 220.0);
    final decorSize = (30 * scaleFactor).clamp(24.0, 36.0);

    return Scaffold(
      backgroundColor: const Color(0xFF272727),
      body: Stack(
        children: [
          // Green circle in top-left corner
          Positioned(
            top: -circleSize * 0.45,
            left: -circleSize * 0.45,
            child: SvgPicture.asset(
              'lib/features/loading/assets/vector/Rectangle 3.svg',
              width: circleSize * 1.2,
              height: circleSize * 1.2,
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                        style: GoogleFonts.getFont(
                          'Inclusive Sans',
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
                            'lib/features/loading/assets/vector/Group 39.svg',
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
                    style: GoogleFonts.getFont(
                      'Inclusive Sans',
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
                    style: GoogleFonts.getFont(
                      'Inclusive Sans',
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
                    style: GoogleFonts.getFont(
                      'Inclusive Sans',
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
                      'lib/features/loading/assets/lottie/Running character.json',
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const Spacer(),

                  // Bottom arrow button
                  Center(
                    child: Container(
                      width: buttonSize,
                      height: buttonSize,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6FAE6C),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: iconSize,
                      ),
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
  }
}
