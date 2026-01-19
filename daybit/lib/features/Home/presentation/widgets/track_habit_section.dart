import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackHabitSection extends StatelessWidget {
  final VoidCallback onAddHabit;

  const TrackHabitSection({super.key, required this.onAddHabit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Track Your\nhabit',
          style: GoogleFonts.inter(
            fontSize: 42,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFF6FAE6C),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onAddHabit,
            icon: const Icon(Icons.add, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
