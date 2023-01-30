import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/graph_data.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/dashboard/graph.dart';
import 'package:sis_progress/widgets/dashboard/pie_chart.dart';
import 'package:sis_progress/widgets/dashboard/pie_chart_with_progress.dart';
import 'package:sis_progress/widgets/tile.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../widgets/dashboard/little_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  int traingDays = 1;
  int totalPoints = 1;
  int completedTasks = 1; 

  @override
  void initState() {
    DateTime date = DateTime.now();
    setUsername();
    printValue();
    int index = days.indexOf(DateFormat('EEEE').format(date));
    colors[index] = const Color(0xffFF5C58);

    super.initState();
  }

  void setUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await httpClient.getUserData();
    setState(() {

      fullName = value["fullName"];
      prefs.setString("country", value["country"]);    
    });
  }

  void printValue() async {
    var value = await httpClient.getDashboardData();

    setState(() {
      traingDays = value["TrainingDays"];
      totalPoints = value["totalPoints"];
      completedTasks = value["complitedTask"];
    });
  }


  void onTaps(int index) {
    colors = [const Color(0xffFCD2D1),const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1)];

    setState(() {
      colors[index] = const Color(0xffFF5C58);
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

    var choosenDate = DateTime.now();

    return Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              buildTitle([fonts[0].toDouble(), fonts[1].toDouble()], fullName),
              buildTileRow([const Color(0xffD2DAFF), const Color(0xffAAC4FF), const Color(0xffFCD2D1)], [SvgPicture.asset("assets/Calendar.svg", width: 25, height: 25,), const Icon(Icons.calculate, size: 24,), ImageIcon(
                          AssetImage("assets/yyy.png"),
                          size: 20,
                          color: Colors.black,
                        )], ["Days in\ntraining", "Total\nPoints", "Completed\nTask"], [traingDays, totalPoints, completedTasks]),
              // buildTileRow([const Color(0xffFCD2D1), const Color(0xffFE8F8F)], [const Icon(Icons.book, size: 24,), const Icon(Icons.bar_chart, size: 24,)], ["Description", "Description"], [10, 145]),
              // LittleCalendar(date: "December, 2022", colors: colors, onTaps: onTaps, days: days, dayNumber: weekDays, slideFunctions: [leftSlide, rightSlide], key: _key,),
              // ElevatedButton(onPressed: () {
              //   print(choosenDate);
              // }, child: Text("click")),
              StatefulBuilder(
                builder: (context, setState) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TableCalendar(
                      
                      focusedDay:choosenDate, 
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      calendarFormat: CalendarFormat.week,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        leftChevronIcon: const Icon(
                          Icons.chevron_left_outlined,
                          size: 25,
                          color: Colors.white,
                        ),

                        rightChevronIcon: const Icon(
                          Icons.chevron_right_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        titleTextStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16
                        )
                      ),
                      selectedDayPredicate: (day) => isSameDay(choosenDate, day),
                      onDaySelected: (selectedDay, focusedDay) async {
                        var value = await httpClient.getAllTaskAndFilter();
                        List<List<dynamic>> subtasks = [];
                        List<List<String>> points = [];

                        List<dynamic> tasks = [];
                        setState(() {
                          choosenDate = selectedDay;


                          _dialogBuilder(context, value, points, tasks, httpClient, choosenDate, () {});
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        
                        todayBuilder: ((context, day, focusedDay) {
                          String monthName = DateFormat.E().format(day).substring(0, 3);
                                    
                          return Container(
                            height: 73,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCD2D1),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style:  GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        defaultBuilder: ((context, day, focusedDay) {
                          String monthName = DateFormat.E().format(day).substring(0, 3);
                                    
                          return Container(
                            height: 63,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCD2D1),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style:  GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                                
                        outsideBuilder: (context, day, focusedDay) {
                          String monthName = DateFormat.E().format(day).substring(0, 3);
                                    
                          return Container(
                            height: 63,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xffFCD2D1),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style:  GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        selectedBuilder: (context, day, focusedDay) {
                          // return Container(
                          //   height: 38,
                          //   width: 38,
                          //   alignment: Alignment.center,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.transparent,
                          //     border: Border.all(color: Colors.white, width: 1)
                          //   ),
                          //   child: Text(
                          //     "${day.day}",
                          //     style:  GoogleFonts.poppins(
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: 20,
                          //       color: Colors.white
                          //     ),
                          //   ),
                          // );
                                    
                          String monthName = DateFormat.E().format(day).substring(0, 3);
                          return Container(
                            // margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            height: 63,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style:  GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      daysOfWeekVisible: false,
                      calendarStyle: CalendarStyle(
                        withinRangeTextStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        
                        
                                
                        defaultTextStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        holidayTextStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        weekendTextStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              ),
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

Container buildTileRow(List<Color> colors, List<Widget> icons, List<String> descriptions, List<int> points) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        Expanded(flex: 1, child: Container(margin: const EdgeInsets.fromLTRB(0, 0, 5, 0), child: Tile(color: colors.first, description: descriptions.first, point: points.first, icon: icons.first,))),
        Expanded(flex: 1, child: Container(margin: const EdgeInsets.fromLTRB(2, 0, 2, 0), child: Tile(color: colors[1], description: descriptions[1], point: points[1], icon: icons[1],))),
        Expanded(flex: 1, child: Container(margin: const EdgeInsets.fromLTRB(5, 0, 0, 0), child: Tile(color: colors.last, description: descriptions.last, point: points.last, icon: icons.last,))),
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

Future<void> _dialogBuilder(
    BuildContext context,
    List<dynamic> tasks,
    List<List<String>> points,
    List<dynamic> addedTasks,
    Client httpClient,
    DateTime date,
    VoidCallback reload) {
  List<Widget> taskContent = [];
  // bool isVisible = false;

  List<bool> boolan = [];
  List<List<Widget>> subtaskNames = [];


  for (int i = 0; i < tasks.length; i++) {
    boolan.add(false);
    
    // print(tasks[i]);
    taskContent.add(
      Container(
        margin: const EdgeInsets.fromLTRB(5, 5, 0, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      tasks[i]["positionName"].length > 15
                          ? "${tasks[i]["positionName"].substring(0, 14)}..."
                          : tasks[i]["positionName"],
                      // "Hello",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: const Color(0xff2E2323)),
                    ),
                    StatefulBuilder(builder: ((context, setState) {
                      return Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.all(0),
                        child: Checkbox(
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: (tasks[i]["isFree"] == false)
                                ? true
                                : boolan[i],
                            onChanged: (tasks[i]["isFree"] == false)
                                ? null
                                : ((value) {
                                    setState(() {
                                      boolan[i] = value!;
                                      value
                                          ? addedTasks.add(tasks[i])
                                          : addedTasks.remove(tasks[i]);
                                      print(addedTasks);
                                    });
                                  })),
                      );
                    }))
                  ],
                ),
                children: List<Widget>.from(tasks[i]["SubTasks"]
                        .map((e) =>
                              Container(
                                margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      e["name"].length > 15
                                          ? e["name"].substring(0, 15)
                                          : e["name"],
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: const Color(0xff646464)),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 15, 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                8, 0, 5, 0),
                                            child: Text(
                                              "${e["points"]} Points",
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff646464)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            )
                        .toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  taskContent.add(Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(),
      Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
        width: 86,
        height: 34,
        child: ElevatedButton(
            onPressed: () {
              var outputFormat = "yyyy-mm-dd hh:mm:ss";
              DateFormat outputFormatter = DateFormat(outputFormat);
              var output = DateTime.parse(outputFormatter.format(date));
              httpClient.addTask(addedTasks[0]["id"], output.toString());

              Navigator.pop(context);
              reload();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff355CCA),
                textStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white)),
            child: const Text("Add")),
      )
    ],
  ));

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          // contentPadding: const EdgeInsets.fromLTRB(5, 30, 5, 30),
          backgroundColor: Colors.white,
          title: Text(
            'Tasks',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: const Color(0xff2E2323)),
          ),
          actions: <Widget>[
            Container(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: taskContent),
              ),
            )
          ]);
    },
  );
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
    MaterialState.disabled
  };

  if (states.any(interactiveStates.contains)) {
    return Colors.grey;
  }
  return Colors.blue;
}