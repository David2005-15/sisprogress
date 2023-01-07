import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/event_process.dart';
import 'package:sis_progress/data%20class/popup_menu_status.dart';
import 'package:sis_progress/page/dashboard/even_tile.dart';
import 'package:sis_progress/widgets/dashboard/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<StatefulWidget> createState() => _CalendarPage();

}

class _CalendarPage extends State<CalendarPage> {
  List<int> years = [2023, 2024, 2025, 2026, 2027];
  late String year;

  List<Color> colors = [const Color(0xffB1B2FF), Colors.white, Colors.white];

  @override
  void initState() {
    year = years[0].toString();
    super.initState();
  }

  var date = DateTime.now();
  var choosenDate = DateTime.now();

  PopupMenuStatus status = PopupMenuStatus.closed;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            buildTitle(),
            Container(
              width: double.infinity,
              height: 35,
              margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color> [
                    Color(0xff272935),
                    Color(0xff121623),
                  ]
                ),

                boxShadow: <BoxShadow> [
                  BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
                ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        colors = [Colors.white, Colors.white, Colors.white];
                        colors[0] = const Color(0xffB1B2FF);
                      });
                    }, 
                    child: Text(
                      "Day",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: colors[0]
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        colors = [Colors.white, Colors.white, Colors.white];
                        colors[1] = const Color(0xffB1B2FF);
                      });
                    }, 
                    child: Text(
                      "Week",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: colors[1]
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        colors = [Colors.white, Colors.white, Colors.white];
                        colors[2] = const Color(0xffB1B2FF);
                      });
                    }, 
                    child: Text(
                      "Year",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: colors[2]
                      ),
                    )
                  )
                ],
              ),
            ),
            CalendarWidget(
              onCanceled: () {
                setState(() {
                  status = PopupMenuStatus.closed;
                });
              },
              onSelected: (val) {
                setState(() {
                  year = val;
                  status = PopupMenuStatus.opened;
                  choosenDate = DateTime(int.parse(year), date.month, date.day);
                  print(choosenDate);
                });
              }, 
              value: year, 
              years: years,
              status: status,
            ),
            Container(
              width: double.infinity,
              height: 500,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TableCalendar(
                availableGestures: AvailableGestures.all,
                daysOfWeekHeight: 50,
                rowHeight: 40,
                selectedDayPredicate: (day) => isSameDay(day, choosenDate),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    choosenDate = selectedDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, day, focusedDay) {
                    return Container(
                      height: 38,
                      width: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1)
                      ),
                      child: Text(
                        "${day.day}",
                        style:  GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    );
                  },
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: const Color(0xffD2DAFF)
                  ),
                  weekendStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: const Color(0xffD2DAFF)
                  ),
                  dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: choosenDate,
                headerVisible: false,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  defaultTextStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  holidayTextStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  weekendTextStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),   
           ),

           EventTile(proccess: EventProccess.later, title: "Leadership"),
           EventTile(proccess: EventProccess.overdue, title: "OOP"),
           EventTile(proccess: EventProccess.completed, title: "OOP"),
           EventTile(proccess: EventProccess.planned, title: "OOP"),
           EventTile(proccess: EventProccess.progress, title: "OOP")              
          ],
        ),
      ),
    );
  }
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Extracurricular Calendar",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.02,
          color: Colors.white
        ),
      ),
    ),
  );
}