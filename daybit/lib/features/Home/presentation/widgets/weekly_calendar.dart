import 'package:daybit/features/Home/presentation/widgets/calendar_day_item.dart';
import 'package:flutter/material.dart';

class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(days.length, (index) {
        final day = days[index];
        final dateNum = (14 + index).toString();

        bool isToday = day == 'Wed';
        bool isDone = day == 'Mon' || day == 'Tue';

        return CalendarDayItem(
          dayName: day,
          dateNumber: dateNum,
          isToday: isToday,
          isDone: isDone,
        );
      }),
    );
  }
}
