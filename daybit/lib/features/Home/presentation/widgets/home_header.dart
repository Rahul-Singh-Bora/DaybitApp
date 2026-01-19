import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white70),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),
            ),
            // DAYBIT branding in center
            Text(
              'DAYBIT',
              style: GoogleFonts.itim(
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6FAE6C),
                letterSpacing: 1.5,
              ),
            ),
            // Spacer to balance the row
            const SizedBox(width: 48),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Good Morning,\nRahul',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
