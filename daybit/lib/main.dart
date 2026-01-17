import 'package:daybit/features/onboarding/presentation/pages/building_plan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const DaybitApp());
}

class DaybitApp extends StatelessWidget {
  const DaybitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daybit',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6FAE6C),
          brightness: Brightness.dark,
          primary: const Color(0xFF6FAE6C),
          surface: const Color(0xFF272727),
        ),
        scaffoldBackgroundColor: const Color(0xFF272727),
        // Set Inclusive Sans as the default font
        textTheme: GoogleFonts.inclusiveSansTextTheme(
          ThemeData.dark().textTheme,
        ).apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: const BuildingPlanPage(),
    );
  }
}
