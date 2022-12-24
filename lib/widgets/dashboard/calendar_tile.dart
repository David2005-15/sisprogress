import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../data class/date.dart';

class CalendarTile extends StatelessWidget {
  final int index;
  final int day;
  final String weekDay;
  final Function(int) onTap;
  final Color color;
  final BuildContext context;

  const CalendarTile({
    required this.context,
    required this.color,
    required this.onTap,
    required this.index,
    required this.weekDay,
    required this.day,
    super.key
  });

  // bool getIsToday() {
  //   DateTime date = DateTime.now();

  //   if(weekDay == DateFormat('EEEE').format(date)) {
  //     return true;
  //   }

  //   return false;
  // }
  Color getTextColor() {
    if(color == const Color(0xffFF5C58)) {
      return Colors.white;
    }

    return const Color(0xff121623);
  }

  bool getVisibility() {
    if(color == const Color(0xffFF5C58)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // DateTime date = DateTime.now();
    // String dayName = DateFormat('EEEE').format(date);
    Date value = Date(fullDate: weekDay);
    double width = MediaQuery.of(context).size.width;

    List<int> size = getSize(width);

    return InkWell(
    splashColor: Colors.transparent,  
    highlightColor: Colors.transparent,
    onTap: () {onTap(index);},
    child: Container(
      width: size[0].toDouble(),
      height: size[1].toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color
      ),
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      // alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Container(
            child: Text(
              value(),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: size[2].toDouble(),
                color: getTextColor()
              ),
            ),
          ),
  
          Container(
            child: Text(
              day.toString(),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: size[3].toDouble(),
                color: getTextColor()
              ),
            ),
          ),

          Visibility(
            visible: getVisibility(),
            child: Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle
              ),
            ),
          )
        ],
      ),
    ),
  );
  }

}

List<int> getSize(double width) {
  if(width > 400) {
    return [60, 83, 18, 20];
  }

  return [40, 63, 14, 18];
}