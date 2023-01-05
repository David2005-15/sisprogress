import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/widgets/dashboard/calendar_widget.dart';

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
            CalendarWidget(years: years, value: year, onSelected: (val) {
              setState(() {
                year = val;
              });
            },)
          
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