import 'package:daybit/features/Home/presentation/widgets/active_habits_grid.dart';
import 'package:daybit/features/Home/presentation/widgets/completed_habits_drawer.dart';
import 'package:daybit/features/Home/presentation/widgets/home_header.dart';
import 'package:daybit/features/Home/presentation/widgets/track_habit_section.dart';
import 'package:daybit/features/Home/presentation/widgets/weekly_calendar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _completedHabits = [];

  void _addCompletedHabit() {
    setState(() {
      _completedHabits.add("MOCK COMPLETED HABIT");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable Main Content
        SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 150),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const HomeHeader(),
                  const SizedBox(height: 30),
                  const WeeklyCalendar(),
                  const SizedBox(height: 30),
                  TrackHabitSection(onAddHabit: _addCompletedHabit),

                  const ActiveHabitsGrid(),
                ],
              ),
            ),
          ),
        ),

        // Completed Habits Drawer at bottom
        CompletedHabitsDrawer(completedHabits: _completedHabits),
      ],
    );
  }
}
