import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarDayItem extends StatelessWidget {
  final String dayName;
  final String dateNumber;
  final bool isToday;
  final bool isPast;
  final bool isDone;

  const CalendarDayItem({
    super.key,
    required this.dayName,
    required this.dateNumber,
    this.isToday = false,
    this.isPast = false,
    this.isDone = false,
  });

  @override
  Widget build(BuildContext context) {
    // Premium "Unseen" Design with RGBO for opacity
    return Column(
      children: [
        Text(
          dayName.toUpperCase(),
          style: GoogleFonts.inter(
            color: isToday ? const Color(0xFF6FAE6C) : Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width:
              44, // Fixed width for all (Standardized & fits with ~4px spacing)
          height: 75,

          decoration: BoxDecoration(
            color: isToday
                ? const Color(0xFF6FAE6C) // App Green (Darker than Neon)
                : const Color(0xFF333333), // Subtle Dark for others
            borderRadius: BorderRadius.circular(25),
            border: isToday
                ? Border.all(color: Colors.white24, width: 1)
                : Border.all(color: Colors.white10, width: 1),
            boxShadow: null, // Removed shiny effect entirely as requested
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isDone)
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.check,
                    color: Color(0xFF6FAE6C),
                    size: 16,
                  ),
                )
              else
                Text(
                  dateNumber,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                  ),
                ),

              if (isToday) ...[
                const SizedBox(height: 4),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
