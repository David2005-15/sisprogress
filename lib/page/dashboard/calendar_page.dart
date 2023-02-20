import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/event_process.dart';
import 'package:sis_progress/data%20class/popup_menu_status.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/dashboard/even_tile.dart';
import 'package:sis_progress/widgets/dashboard/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({
    super.key
  });

  @override
  State<StatefulWidget> createState() => _CalendarPage();

  var date = DateTime.now();
  var chosenDate = DateTime.now();

  DateTime getChosenDate() {
    return chosenDate;
  }

}

class _CalendarPage extends State<CalendarPage> {
  List<int> years = [2023, 2024, 2025, 2026, 2027];
  late String year;


  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  String month = "February";

  List<Color> colors = [const Color(0xffB1B2FF), Colors.white, Colors.white];

  Client httpClient = Client();

  var event = [];


  List<List<dynamic>> feedbacks = [];

  void updateEvent() async {
    var temp = await httpClient.getCalendarEvents();
    stderr.writeln(temp);
    
    setState(() {
      event.clear();

      temp.forEach((element) {
        DateTime date = DateTime.parse(element["startDate"]);

        if ((date.day == widget.chosenDate.day) &&
            (date.month == widget.chosenDate.month)) {
          event.add(element);
        }
      });
    });
  }


  List<DateTime> getCurrentWeekDays(DateTime currentDay) {
    DateTime now = DateTime.now();
    int weekday = now.weekday;
    DateTime monday = now.subtract(Duration(days: weekday - 1));
    monday.add(const Duration(days: 6));

    List<DateTime> dates = List.generate(
        7, (int index) => monday.add(Duration(days: index)));

    return dates;
  }

  @override
  void initState() {
    updateEvent();

    year = years[0].toString();
    super.initState();
  }

  EventProccess getProccess(String name) {
    switch (name) {
      case "In Progress":
        return EventProccess.progress;
      case "Planned":
        return EventProccess.planned;
      case "Overdue":
        return EventProccess.overdue;
      case "Late Done":
        return EventProccess.later;
      default:
        return EventProccess.completed;
    }
  }

  var calendarType = "Year";

  PopupMenuStatus status = PopupMenuStatus.closed;

  bool isDescriptionVisible = false;
  bool isFloatingButtonVisisble = true;

  void changeFloatingButtonState() {
    setState(() {
      var diff = widget.chosenDate.compareTo(DateTime.now());
      if (calendarType != "Week") {
        if (isSameDay(widget.chosenDate, DateTime.now())) {
          isFloatingButtonVisisble = true;
        }
        else if ((diff < 0)) {
          isFloatingButtonVisisble = false;
        } else {
          isFloatingButtonVisisble = true;
        }
      } else {
        isFloatingButtonVisisble = true;
      }
    });
  }

  List<DateTime> getCurrentWeek(DateTime selectedDate) {
    int weekday = selectedDate.weekday;
    DateTime monday = selectedDate.subtract(Duration(days: weekday - 1));
    monday.add(const Duration(days: 6));

    List<DateTime> dates = List.generate(
        7, (int index) => monday.add(Duration(days: index)));
    return dates;
  }


  @override
  Widget build(BuildContext context) {
    changeFloatingButtonState();


    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        floatingActionButton: Visibility(
          visible: isFloatingButtonVisisble,
          child: SizedBox(
              width: 45,
              height: 45,
              child: Visibility(
                visible: isFloatingButtonVisisble,
                child: FloatingActionButton(
                  onPressed: () async {
    
                    var value = await httpClient.getAllTaskAndFilter();
    
                    List<List<String>> points = [];
    
                    List<dynamic> tasks = [];
    
                    _dialogBuilder(
                        context,
                        value,
                        points,
                        tasks,
                        httpClient,
                        widget.chosenDate, () {
                      updateEvent();
                    });
                  },
                  backgroundColor: const Color(0xff355CCA),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              )
    
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),

              CalendarWidget(
                month: month,
                months: months,
                calendarType: calendarType,
                onCanceled: () {
                  setState(() {
                    status = PopupMenuStatus.closed;
                  });
                },
                onSelected: (val) {
                  setState(() {
                    year = val;
                    status = PopupMenuStatus.opened;
                    DateFormat monthFormat = DateFormat.MMMM();
                    DateTime monthr = monthFormat.parse(month);
                    int monthIndex = monthr.month;
                    widget.chosenDate = DateTime(
                        int.parse(year), monthIndex, widget.date.day);
                  });
                },

                onMonthSelect: (val) {
                  setState(() {
                    month = val;
                    DateFormat monthFormat = DateFormat.MMMM();
                    DateTime monthr = monthFormat.parse(month);
                    int monthIndex = monthr.month;
                    widget.chosenDate =
                        DateTime(widget.date.year, monthIndex, widget.date.day);
                  });
                },
                value: year,
                years: years,
                status: status,
              ),
              Container(
                width: double.infinity,
                height: 290,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TableCalendar(
                  availableGestures: AvailableGestures.all,
                  daysOfWeekHeight: 50,
                  rowHeight: 40,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, widget.chosenDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      widget.chosenDate = selectedDay;
                      updateEvent();
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
                          style: GoogleFonts.poppins(
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
                    dowTextFormatter: (date, locale) =>
                    DateFormat.E(locale)
                        .format(date)[0],
                  ),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: widget.chosenDate,
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

              Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 0, 10),
                child: Text(
                  "${DateFormat('EEEE').format(widget.chosenDate)} ${widget.chosenDate.day}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white
                  ),
                ),
              ),

              Column(
                children: event.map((e) {

                  List<List<dynamic>> swap = [];
                  List<String> temp = [];
                  List<bool> temp2 = [];


                  // print(feedbacks);


                  e["SubTasks"].forEach((p0) {
                    swap.add([
                      p0["name"],
                      p0["id"],
                      "Hello",
                      p0["status"]
                    ]);
                    if (p0["status"] == true) {
                      temp2.add(true);
                    }
                    temp.add("${p0["points"]} Points");
                  });

                  String substringValue = "${temp2.length}/${swap.length}";

                  return EventTile(
                    proccess: getProccess(e["status"]),
                    title: e["positionName"],
                    description: "Hello World",
                    subtasks: swap,
                    points: temp,
                    eventDate: "Hello World",
                    substringValue: substringValue,
                    updateState: updateEvent,
                    facultyName: e["facultyName"],
                    companyName: e["companyName"],
                    taskId: e["id"],
                    choosenDate: widget.chosenDate,);
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context,
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
    List<bool> cantYouSee = [];


    for (int i = 0; i < tasks.length; i++) {
      boolan.add(false);
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
                                boolan[i] = !boolan[i];
                                boolan[i]
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
                                      : boolan[i]
                                    ? const Color(0xff355CCA)
                                    : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1,
                                      color: tasks[i]["isFree"] == false
                                          ? const Color(0xffAAC4FF)
                                          : const Color(0xffAAC4FF))
                              ),
                              child: Icon(
                                Icons.check,
                                size: 18,
                                color: tasks[i]["isFree"] == false ? const Color(0xffAAC4FF) : boolan[i]
                                    ? Colors.white
                                    : Colors.transparent,
                              )
                          ),
                        );

                        //   child: Checkbox(
                        //       fillColor:
                        //           MaterialStateProperty.resolveWith(getColor),
                        //       value: (tasks[i]["isFree"] == false)
                        //           ? true
                        //           : boolan[i],
                        //       onChanged: (tasks[i]["isFree"] == false)
                        //           ? null
                        //           : ((value) {
                        //               setState(() {
                        //                 boolan[i] = value!;
                        //                 value
                        //                     ? addedTasks.add(tasks[i])
                        //                     : addedTasks.remove(tasks[i]);
                        //                 print(addedTasks);
                        //               });
                        //             })),
                        // );
                      }))
                    ],
                  ),
                  children: List<Widget>.from(tasks[i]["SubTasks"]
                      .map((e) =>
                      StatefulBuilder(
                        builder: (context, state) {
                          return Container(
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
                          );
                        }
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

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, state) {
            return AlertDialog(
                scrollable: true,
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
                          children: taskContent
                      ),
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
                            onPressed: !cantYouSee.every((element) =>
                              element == false) ? () {
                                state(() {

                                });
                              // httpClient.addTask(addedTasks[0]["id"], date.toIso8601String());
                              addedTasks.forEach((element) async {
                                await httpClient.addTask(
                                    element["id"], date.toIso8601String());
                                reload();
                              });

                              Navigator.pop(context);
                              reload();
                            } : null,
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
          }
        );
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


Widget buildDayCalendar(var choosenDate,
    Function(DateTime, DateTime) onDaySelect) {
  return Container(
    width: double.infinity,
    height: 275,
    margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: TableCalendar(
      availableGestures: AvailableGestures.all,
      daysOfWeekHeight: 50,
      rowHeight: 40,
      selectedDayPredicate: (day) => isSameDay(day, choosenDate),
      onDaySelected: onDaySelect,
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
              style: GoogleFonts.poppins(
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
        dowTextFormatter: (date, locale) =>
        DateFormat.E(locale).format(date)[0],
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
      calendarStyle: buildCalendarStyle(),
    ),
  );
}

CalendarStyle buildCalendarStyle() {
  return CalendarStyle(
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
  );
}