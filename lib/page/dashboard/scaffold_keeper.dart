import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/notification_data.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/dashboard/dashboard.dart';
import 'package:sis_progress/page/dashboard/explore_more_goals.dart';
import 'package:sis_progress/page/dashboard/notification_page.dart';
import 'package:sis_progress/page/dashboard/profile.dart';
import 'package:sis_progress/widgets/bottom_nav_bar.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_page.dart';
import 'my_task.dart';

class ScaffoldHome extends StatefulWidget {
  const ScaffoldHome({super.key});

  @override
  State<StatefulWidget> createState() => _ScaffoldHome();
}

class _ScaffoldHome extends State<ScaffoldHome> {
  int _selected = 0;
  late Widget body;

  DateTime todayDate = DateTime.now();
  DateTime choosenDate = DateTime.now();

  late CalendarPage page;
  late List<Widget> pages;

  Color iconColor = Colors.blue;
  Color backgroundColor = Colors.white;

  String fullName = "";

  Client httpClient = Client();

  _ScaffoldHome() {
    page = CalendarPage();
    pages = [
      const Dashboard(),
      page,
      const ExploreMoreGoals(),
      MyTask(choosenDate: page.chosenDate),
      const Profile()
    ];
  }

  Future<bool> _onBackButtonPressed() {
    setState(() {
      if (_selected != 0) {
        _selected = 0;
        body = pages[_selected];
      }
    });

    return Future.value(false);
  }

  void onIcon() {
    setState(() {
      _selected = 0;
      body = pages[_selected];
    });
  }

  void onNotification() {
    var data = NotificationData(
        title: "Notification Data", description: "It is notification");

    setState(() {
      body = NotificationPage(
        notifications: <NotificationData>[data],
      );
    });
  }

  void onAvatar() {
    setState(() {
      body = const Profile();
    });
  }

  @override
  void initState() {
    body = pages[0];
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        if (page.getChosenDate().day < DateTime.now().day) {
          isFloatingButtonVisisble = false;
        } else {
          isFloatingButtonVisisble = true;
        }
      });
    });

    super.initState();
  }

  void onCheckboxChange() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  bool isVisible = false;
  bool isFloatingButtonVisisble = true;

  var format = DateFormat("yyyy-MM-dd");

  void changeFloatingButtonState() {
    setState(() {
      var diff = page.getChosenDate().compareTo(DateTime.now());
      // print(DateTime.now());
      // print(diff);
      if(isSameDay(page.getChosenDate(), DateTime.now())) {
        isFloatingButtonVisisble = true;
      }
      else if((diff < 0)) {
        isFloatingButtonVisisble = false;
      } else {
        isFloatingButtonVisisble = true;
      }
      // if (page.getChoosenDate().day >= DateTime.now().day) {
      //   if(page.getChoosenDate().month >= DateTime.now().month){
      //     isFloatingButtonVisisble = true;
      //   }
      // } else {
      //   print(page)
      //   isFloatingButtonVisisble = false;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeFloatingButtonState();

    return Scaffold(
      bottomNavigationBar: NavBar(
          selected: _selected,
          onChange: (int count) {
            setState(() {
              _selected = count;
              body = pages[_selected];
            });
          }),
      appBar: CustomAppBar(buildLogoIcon(onIcon), <Widget>[
        buildNotification(onTap: onNotification),
        buildAvatar(onTap: onAvatar)
      ]),
      body: body,
    );
  }
}

Container buildLogoIcon(VoidCallback onTap) {
  return Container(
    width: 62,
    height: 39,
    child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onTap,
        icon: Image.asset(
          "assets/logo.png",
        )),
  );
}

Container buildAvatar({required VoidCallback onTap}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 0, 16, 0),
    child: InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Image.asset(
        "assets/AvatarAvatar.png",
        width: 35,
        height: 35,
      )
    ),
  );
}

Container buildNotification({required VoidCallback onTap}) {
  return Container(
    child: InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent, // Splash color
      onTap: onTap,
      child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xff3A3D4C)),
          child: const Icon(
            Icons.notifications_outlined,
            size: 17,
            color: Color(0xffD2DAFF),
          )),
    ),
  );
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

Container buildCheckbox(
    {required Color iconColor,
    required Function() onChange,
    required Color borderColor,
    required Color backgroundColor}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: borderColor, width: 1),
        color: Colors.transparent),
    child: InkWell(
      onTap: () {
        onChange;
      },
      child: Icon(
        Icons.check,
        color: iconColor,
        size: 11,
      ),
    ),
  );
}
