import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/graph_data.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/dashboard/graph.dart';
import 'package:sis_progress/widgets/dashboard/pie_chart.dart';
import 'package:sis_progress/widgets/dashboard/pie_chart_with_progress.dart';
import 'package:sis_progress/widgets/tile.dart';
import '../../widgets/dashboard/little_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final int index = 0;

  List<Color> colors = [const Color(0xffFCD2D1),const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1)];
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
  List<int> weekDays = getDays();

  Client httpClient = Client();
  String fullName = "";

  @override
  void initState() {
    DateTime date = DateTime.now();
    setUsername();
    int index = days.indexOf(DateFormat('EEEE').format(date));
    colors[index] = const Color(0xffFF5C58);
    super.initState();
  }

  void setUsername() async {
    var value = await httpClient.getUserData();
    setState(() {

      fullName = value["fullName"];
    });
  }


  void onTaps(int index) {
    colors = [const Color(0xffFCD2D1),const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1)];

    setState(() {
      colors[index] = const Color(0xffFF5C58);
    });
  }


  void leftSlide() {
    print("Hello World");
    setState(() {
      List<int> swap = weekDays;
      DateTime now = DateTime.now();
      var monthDaysCount = getDaysInMonth(now.year, now.month);
      
      for(int i = 0; i < swap.length; i++) {
        if(swap[i] - 7 < 1) {
          var temp = 7 - swap[i];
          swap[i] = monthDaysCount;
          swap[i] -= temp;

        } else {
          swap[i] -= 7;
        }
      }

      weekDays = swap;
    });
  }

  void rightSlide() {
    print("Hello World");
    setState(() {
      List<int> swap = weekDays;
      DateTime now = DateTime.now();
      var monthDaysCount = getDaysInMonth(now.year, now.month);

      for(int i = 0; i < swap.length; i++) {
        if(swap[i] + 7 > monthDaysCount) {
          var temp = swap[i] + 7;
          swap[i] = temp - monthDaysCount;
        } else{
          swap[i] += 7;
        }
      }

      weekDays = swap;
    });
  }

  final GlobalKey<LittleCalendarWidget> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {

    List<int> fonts = getFontSize(MediaQuery.of(context).size.width);
    final List<GraphData> chartData = [
      GraphData(0, 37),
      GraphData(5, 33),
      GraphData(10, 30),
      GraphData(15, 27),
      GraphData(20, 26),
      GraphData(25, 23)
    ];

    final List<GraphData> chartLine = [
      GraphData(0, 35),
      GraphData(5, 30),
      GraphData(10, 25),
      GraphData(15, 20),
      GraphData(20, 15),
      GraphData(25, 10)
    ];

    return Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              buildTitle([fonts[0].toDouble(), fonts[1].toDouble()], fullName),
              buildTileRow([const Color(0xffD2DAFF), const Color(0xffAAC4FF)], [const Icon(Icons.rocket, size: 24,), const Icon(Icons.calculate, size: 24,)], ["Description", "Description"], [10, 32]),
              buildTileRow([const Color(0xffFCD2D1), const Color(0xffFE8F8F)], [const Icon(Icons.book, size: 24,), const Icon(Icons.bar_chart, size: 24,)], ["Description", "Description"], [10, 145]),
              LittleCalendar(date: "December, 2022", colors: colors, onTaps: onTaps, days: days, dayNumber: weekDays, slideFunctions: [leftSlide, rightSlide], key: _key,),
              Graph(data: chartData, lineData: chartLine,),
              PieChart(context: context, title: "Overall Progress", metadata: const {"points": "1400 / 1600 pt"},),
              const PieChartWithProgressBar(values: <int>[45, 65, 2, 3, 1]),
            ],
          ),
        ),
      );
  }
}

Image buildLogoIcon() {
  return Image.asset(
    "assets/logo.png",
  );
}

Container buildTitle(List<double> fontSizes, String fullName) {
  return Container(
    height: 66,
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.fromLTRB(15, 0, 0, 2),
    // alignment: Alignment.center,
    child: AspectRatio(
      aspectRatio: 16 / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "Good morning, $fullName !",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                fontSize: fontSizes[0],
                color: Colors.white
              ),
            ),
          ),
                
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "You are doing great",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: fontSizes[1],
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Container buildTileRow(List<Color> colors, List<Icon> icons, List<String> descriptions, List<int> points) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        Expanded(flex: 1, child: Container(margin: const EdgeInsets.fromLTRB(0, 0, 10, 0), child: Tile(color: colors.first, description: descriptions.first, point: points.first, icon: icons.first,))),
        Expanded(flex: 1, child: Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0), child: Tile(color: colors.last, description: descriptions.last, point: points.last, icon: icons.last,)))
      ],
    ),
  );
}

List<int> getFontSize(double height) {
  if(height > 400) {
    return [25, 17];
  }

  return [20, 13];
}

List<int> getDays() {
  DateTime today = DateTime.now();

  DateTime firstDayOfTheweek =
        today.subtract(Duration(days: today.weekday - 1));

  var monday = 26;
  var monthDays = getDaysInMonth(firstDayOfTheweek.year, firstDayOfTheweek.month);

  List<int> days = [];

  for(int i = 0; i < 7; i++) {
    days.add(monday);
    if(monday + 1 > monthDays) {
      monday = 0;
    }

    monday += 1;
  }

  return days;
}

int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return daysInMonth[month - 1];
}