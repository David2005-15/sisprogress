import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'calendar_tile.dart';

class LittleCalendar extends StatelessWidget {
  final String date;
  final List<Color> colors;
  final List<String> days;
  final Function(int) onTaps;

  const LittleCalendar({
    required this.days,
    required this.onTaps,
    required this.colors,
    required this.date,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.fromLTRB(16, 33, 16, 0),
    child: Column(
      children: <Widget> [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget> [
            IconButton(
              splashColor: Colors.transparent,  
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 36,
                color: Colors.white,
              ),
            ),

            Text(
              date,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,  
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: const Icon(
                Icons.chevron_right_rounded,
                size: 36,
                color: Colors.white,
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            CalendarTile(weekDay: days[0], day: 17, index: 0, color: colors[0], onTap: onTaps, context: context,),
            CalendarTile(weekDay: days[1], day: 17, index: 1, color: colors[1], onTap: onTaps, context: context,),
            CalendarTile(weekDay: days[2], day: 17, index: 2, color: colors[2], onTap: onTaps, context: context,),
            CalendarTile(weekDay: days[3], day: 17, index: 3, color: colors[3], onTap: onTaps, context: context,),
            CalendarTile(weekDay: days[4], day: 17, index: 4, color: colors[4], onTap: onTaps, context: context,),
            CalendarTile(weekDay: days[5], day: 17, index: 5, color: colors[5], onTap: onTaps, context: context,), 
            CalendarTile(weekDay: days[6], day: 17, index: 6, color: colors[6], onTap: onTaps, context: context,),
            // CalendarTile("Tuesday", 18),
            // CalendarTile("Wednesday", 19),
            // CalendarTile("Thursday", 20),
            // CalendarTile("Friday", 21),
            // CalendarTile("Saturday ", 22),
            // CalendarTile("Sunday ", 23),
          ],
        )
      ],
    )
  );
  }

}