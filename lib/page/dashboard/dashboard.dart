import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/dashboard/pie_chart.dart';
import 'package:sis_progress/widgets/dashboard/pie_chart_with_progress.dart';
import 'package:sis_progress/widgets/tile.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final int index = 0;

  List<Color> colors = [
    const Color(0xffFCD2D1),
    const Color(0xffFCD2D1),
    const Color(0xffFCD2D1),
    const Color(0xffFCD2D1),
    const Color(0xffFCD2D1),
    const Color(0xffFCD2D1),
    const Color(0xffFCD2D1)
  ];
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  Client httpClient = Client();
  String fullName = "";
  String greeting = "";

  double trainingDays = 1;
  double totalPoints = 1;
  double completedTasks = 1;
  double extraculicular = 0;
  String successMessage = "";
  String statusMessage = "";

  @override
  void initState() {
    DateTime date = DateTime.now();
    setUsername();
    printValue();

    int index = days.indexOf(DateFormat('EEEE').format(date));
    colors[index] = const Color(0xffFF5C58);

    super.initState();
  }

  List<dynamic> getSuccessColor(String value) {
    switch (value) {
      case "Excellent":
        return [
          const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF62C483),
              Color(0xFF338B50),
            ],
          ),
          const Color(0xFF62C483),
          Alignment.centerRight,
          Image.asset(
            "assets/Happy.png",
            height: 30,
            width: 30,
          )
        ];
      case "Good":
        return [
          const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xffD2DAFF),
                Color(0xffD2DAFF),
                Color(0xFF1E43AD),
                Color(0xFF355CCA),
              ],
              stops: [
                0,
                0.49,
                0.5,
                1
              ]),
          const Color(0xFF355CCA),
          Alignment.center,
          Image.asset(
            "assets/Good.png",
            height: 30,
            width: 30,
          )
        ];
      default:
        return [
          const LinearGradient(colors: [Color(0xffFCD2D1), Color(0xffFCD2D1)]),
          const Color(0xffFF5C58),
          Alignment.centerLeft,
          Image.asset(
            "assets/Sad.png",
            height: 30,
            width: 30,
          )
        ];
    }
  }

  void setUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await httpClient.getUserData();
    setState(() {
      fullName = value["fullName"];
      prefs.setString("country", value["country"]);
    });
  }

  String halfPercentage = "";
  String percentage = "";
  double overallDone = 0;
  double overallProgress = 0;

  void printValue() async {
    var value = await httpClient.getDashboardData();
    setState(() {
      extraculicular = value["extraculicular"].toDouble();
      trainingDays = value["TrainingDays"].toDouble();
      totalPoints = value["totalPoints"].toDouble();
      completedTasks = value["completed"].toDouble();
      halfPercentage = "${value["myPoints"]} / ${value["totalPoints"]}";
      overallProgress = value["overAllProgressInProgress"].toDouble();
      overallDone = value["overAllProgressDone"].toDouble();
      percentage = "${value["progressWithPercent"] * 10}%";
      greeting = value["RandomGreetingMessages"]["text"];
      statusMessage = value["successMesange"]["status"];
      successMessage = value["successMesange"]["textPart1"];

      debugPrint(overallDone.toString());
    });
  }

  void onTaps(int index) {
    colors = [
      const Color(0xffFCD2D1),
      const Color(0xffFCD2D1),
      const Color(0xffFCD2D1),
      const Color(0xffFCD2D1),
      const Color(0xffFCD2D1),
      const Color(0xffFCD2D1),
      const Color(0xffFCD2D1)
    ];

    setState(() {
      colors[index] = const Color(0xffFF5C58);
    });
  }

  // final GlobalKey<LittleCalendarWidget> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<int> fonts = getFontSize(MediaQuery.of(context).size.width);
    // final List<GraphData> chartData = [
    //   GraphData(0, 37),
    //   GraphData(5, 33),
    //   GraphData(10, 30),
    //   GraphData(15, 27),
    //   GraphData(20, 26),
    //   GraphData(25, 23)
    // ];
    //
    // final List<GraphData> chartLine = [
    //   GraphData(0, 35),
    //   GraphData(5, 30),
    //   GraphData(10, 25),
    //   GraphData(15, 20),
    //   GraphData(20, 15),
    //   GraphData(25, 10)
    // ];

    var chosenDate = DateTime.now();

    Future<void> refreshPage() async {
      setState(() {
        printValue();
      });
    }

    return RefreshIndicator(
      onRefresh: refreshPage,
      child: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildTitle([fonts[0].toDouble(), fonts[1].toDouble()], fullName,
                    greeting),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  // width: 328,
                  // height: MediaQuery.of(context.size.height),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                            blurRadius: 30)
                      ],
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            Color(0xff272935),
                            Color(0xff121623)
                          ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(27, 14, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              statusMessage,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: getSuccessColor(statusMessage)[1]),
                            ),
                            Container(
                              width: 150,
                              height: 30,
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 100,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: getSuccessColor(
                                              statusMessage)[0]),
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        getSuccessColor(statusMessage)[2],
                                    child: getSuccessColor(statusMessage)[3] ??
                                        Container(),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(27, 5, 17, 15),
                          child: Text(
                            successMessage,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
                buildTileRow([
                  const Color(0xffD2DAFF),
                  const Color(0xffAAC4FF),
                  const Color(0xffFCD2D1)
                ], [
                  const ImageIcon(
                    AssetImage("assets/Cal.png"),
                    size: 20,
                    color: Colors.black,
                  ),
                  const ImageIcon(
                    AssetImage("assets/yyy.png"),
                    size: 20,
                    color: Colors.black,
                  ),
                  const ImageIcon(
                    AssetImage("assets/Target.png"),
                    size: 20,
                    color: Colors.black,
                  )
                ], [
                  "Days in\ntraining",
                  "Total\nPoints",
                  "Completed\nTask"
                ], [
                  trainingDays.toInt(),
                  totalPoints.toInt(),
                  completedTasks.toInt()
                ]),
                StatefulBuilder(builder: (context, setState) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: TableCalendar(
                      focusedDay: chosenDate,
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
                              fontSize: 16)),
                      selectedDayPredicate: (day) => isSameDay(chosenDate, day),
                      onDaySelected: (selectedDay, focusedDay) async {
                        var value = await httpClient.getAllTaskAndFilter();
                        List<List<String>> points = [];

                        List<dynamic> tasks = [];
                        setState(() {
                          chosenDate = selectedDay;

                          if (chosenDate.day >= DateTime.now().day) {
                            _dialogBuilder(context, value, points, tasks,
                                httpClient, chosenDate, () {});
                          }
                        });
                      },
                      calendarBuilders: CalendarBuilders(
                        todayBuilder: ((context, day, focusedDay) {
                          String monthName =
                              DateFormat.E().format(day).substring(0, 3);

                          return Container(
                            height: 73,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffFCD2D1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }),
                        defaultBuilder: ((context, day, focusedDay) {
                          String monthName =
                              DateFormat.E().format(day).substring(0, 3);

                          return Container(
                            height: 63,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffFCD2D1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }),
                        outsideBuilder: (context, day, focusedDay) {
                          String monthName =
                              DateFormat.E().format(day).substring(0, 3);

                          return Container(
                            height: 63,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffFCD2D1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        },
                        selectedBuilder: (context, day, focusedDay) {
                          String monthName =
                              DateFormat.E().format(day).substring(0, 3);
                          return Container(
                            // margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            height: 63,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    monthName,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                ),
                                Text(
                                  "${day.day}",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.white),
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
                }),
                // Graph(data: chartData, lineData: chartLine,),
                PieChart(
                  context: context,
                  title: "Overall Progress",
                  halfPerc: "${halfPercentage}pt",
                  redLine:
                      (overallDone / 100) == 0 ? 0.01 : (overallDone / 100),
                  blueLine: (overallProgress / 100) == 0
                      ? 0.01
                      : overallProgress / 100,
                  percentage: percentage,
                ),
                PieChartWithProgressBar(
                    values: [extraculicular.toInt(), 0, 0, 0, 0]),
              ],
            ),
          ),
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

Container buildTitle(List<double> fontSizes, String fullName, String greating) {
  return Container(
    height: 120,
    // padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.fromLTRB(15, 0, 0, 2),
    // alignment: Alignment.center,
    child: AspectRatio(
      aspectRatio: 16 / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "Good morning, $fullName !",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSizes[0],
                  color: Colors.white),
            ),
          ),
          Text(
            greating,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: fontSizes[1],
                color: Colors.white),
          )
        ],
      ),
    ),
  );
}

Container buildTileRow(List<Color> colors, List<Widget> icons,
    List<String> descriptions, List<int> points) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Tile(
                  color: colors.first,
                  description: descriptions.first,
                  point: points.first,
                  icon: icons.first,
                ))),
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Tile(
                  color: colors[1],
                  description: descriptions[1],
                  point: points[1],
                  icon: icons[1],
                ))),
        Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Tile(
                  color: colors.last,
                  description: descriptions.last,
                  point: points.last,
                  icon: icons.last,
                ))),
      ],
    ),
  );
}

List<int> getFontSize(double height) {
  if (height > 400) {
    return [25, 17];
  }

  return [20, 13];
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

  List<bool> boolean = [];
  List<bool> cantYouSee = [];

  for (int i = 0; i < tasks.length; i++) {
    boolean.add(false);
    cantYouSee.add(tasks[i]["isFree"]);

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
                    StatefulBuilder(builder: ((context, state) {
                      return InkWell(
                        onTap: () {
                          state(() {
                            if (tasks[i]["isFree"] == true) {
                              boolean[i] = !boolean[i];
                              boolean[i]
                                  ? addedTasks.add(tasks[i])
                                  : addedTasks.remove(tasks[i]);
                            }
                          });
                        },
                        child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                color: tasks[i]["isFree"] == false
                                    ? Colors.transparent
                                    : boolean[i]
                                        ? const Color(0xff355CCA)
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: tasks[i]["isFree"] == false
                                        ? const Color(0xffAAC4FF)
                                        : const Color(0xffAAC4FF))),
                            child: Icon(
                              Icons.check,
                              size: 18,
                              color: tasks[i]["isFree"] == false
                                  ? const Color(0xffAAC4FF)
                                  : boolean[i]
                                      ? Colors.white
                                      : Colors.transparent,
                            )),
                      );
                    }))
                  ],
                ),
                children: List<Widget>.from(tasks[i]["SubTasks"]
                    .map((e) => StatefulBuilder(builder: (context, state) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 0, 15, 0),
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
                                              color: const Color(0xff646464)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }))
                    .toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: taskContent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 15, 10),
                  width: 86,
                  height: 34,
                  child: ElevatedButton(
                      onPressed:
                          !cantYouSee.every((element) => element == false)
                              ? () async {
                                  for (var element in addedTasks) {
                                    await httpClient.addTask(
                                        element["id"], date.toIso8601String());
                                    reload();
                                  }

                                  Navigator.pop(context);
                                  reload();
                                }
                              : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff355CCA),
                          disabledBackgroundColor: const Color(0xffBFBFBF),
                          disabledForegroundColor: Colors.white,
                          textStyle: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white)),
                      child: const Text("Add")),
                )
              ],
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
