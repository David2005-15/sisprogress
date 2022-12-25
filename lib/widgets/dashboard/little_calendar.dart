import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'calendar_tile.dart';

class LittleCalendar extends StatefulWidget {
  final String date;
  final List<Color> colors;
  final List<String> days;
  final Function(int) onTaps;
  final List<int> dayNumber;
  final List<VoidCallback> slideFunctions;

  const LittleCalendar({
    required this.slideFunctions,
    required this.dayNumber,
    required this.days,
    required this.onTaps,
    required this.colors,
    required this.date,
    super.key
  });
  
  @override
  State<StatefulWidget> createState() => LittleCalendarWidget();
}

class LittleCalendarWidget extends State<LittleCalendar> {
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
              onPressed: widget.slideFunctions[0],
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 36,
                color: Colors.white,
              ),
            ),

            Text(
              widget.date,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,  
              highlightColor: Colors.transparent,
              onPressed: widget.slideFunctions[1],
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
            CalendarTile(weekDay: widget.days[0], day: widget.dayNumber[0], index: 0, color: widget.colors[0], onTap: widget.onTaps, context: context,),
            CalendarTile(weekDay: widget.days[1], day: widget.dayNumber[1], index: 1, color: widget.colors[1], onTap: widget.onTaps, context: context,),
            CalendarTile(weekDay: widget.days[2], day: widget.dayNumber[2], index: 2, color: widget.colors[2], onTap: widget.onTaps, context: context,),
            CalendarTile(weekDay: widget.days[3], day: widget.dayNumber[3], index: 3, color: widget.colors[3], onTap: widget.onTaps, context: context,),
            CalendarTile(weekDay: widget.days[4], day: widget.dayNumber[4], index: 4, color: widget.colors[4], onTap: widget.onTaps, context: context,),
            CalendarTile(weekDay: widget.days[5], day: widget.dayNumber[5], index: 5, color: widget.colors[5], onTap: widget.onTaps, context: context,), 
            CalendarTile(weekDay: widget.days[6], day: widget.dayNumber[6], index: 6, color: widget.colors[6], onTap: widget.onTaps, context: context,),
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


  
