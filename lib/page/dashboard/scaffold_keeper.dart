import 'dart:async';

import 'package:flutter/material.dart';
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

import 'calendar_page.dart';
import 'lectures.dart';

class ScaffoldHome extends StatefulWidget {

  const ScaffoldHome({
    super.key
  });

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

  String? fullName;

  Client httpClient = Client();

  _ScaffoldHome() {
    page = CalendarPage();
    pages = [const Dashboard(), page, const ExploreMoreGoals(), const Lectures(), const Profile()]; 
  }

  Future<bool> _onBackButtonPressed() {
    setState(() {
      if(_selected != 0) {
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
    var data = NotificationData(title: "Notification Data", description: "It is notification");

    setState(() {
      body = NotificationPage(notifications: <NotificationData> [data],);
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
        if(page.getChoosenDate().day < DateTime.now().day) {
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


  void changeFloatingButtonState() {
    setState(() {
      if(page.getChoosenDate().day < DateTime.now().day) {
        isFloatingButtonVisisble = false;
      } else {
        isFloatingButtonVisisble = true;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    changeFloatingButtonState();

    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: NavBar(selected: _selected, onChange: (int count) {
          setState(() {
            _selected = count;
            body = pages[_selected];
          });
        }),
        appBar: CustomAppBar(buildLogoIcon(onIcon), <Widget> [buildNotification(onTap: onNotification), buildAvatar(onTap: onAvatar)]),
        body: body,
        floatingActionButton: Visibility(
          visible: isFloatingButtonVisisble,
          child: SizedBox(
            width: 45,
            height: 45,  
            child: _selected == 1 ? FloatingActionButton(
              onPressed: () async {
                var prefs = await SharedPreferences.getInstance();
                var id = prefs.getString("user id").toString();

                var value = await httpClient.getAllTaskAndFilter();

                // var freeTasks = value.map((e) => e["compamyName"].toString()).toList();

                List<List<dynamic>> subtasks = [];
                List<List<String>> points = [];

                for (var task in value) {
                  List<dynamic> t = [];
                  List<String> u = [];
                  for (var subtask in task["SubTasks"]) {
                    t.add(subtask);
                    u.add(subtask["points"].toString());
                  }
                  subtasks.add(t);
                  points.add(u);
                }

                print(subtasks);
                print(points);

                List<dynamic> tasks = [];
                print(page.getChoosenDate());
                print(todayDate);
                if(page.getChoosenDate().day >= DateTime.now().day) {
                  _dialogBuilder(context, value, points, tasks, subtasks, httpClient, page.getChoosenDate(), );
                }
              },
              backgroundColor: const Color(0xff355CCA),
              child: const Icon(Icons.add_rounded, color: Colors.white, size: 16,),
            ): null,
          ),
        ),
      ),
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
      )
    ),
  );
}


Container buildAvatar({required VoidCallback onTap}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 0, 16, 0),
    child: InkWell(
      onTap: onTap,
      child: const CircleAvatar(
        backgroundColor: Colors.yellow,
        radius: 18,
      ),
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
          shape: BoxShape.circle,
          color: Color(0xff3A3D4C)
        ),
        child: const Icon(Icons.notifications_outlined, size: 17, color: Color(0xffD2DAFF),)
      ),
    ),
  );
}

Future<void> _dialogBuilder(BuildContext context, List<dynamic> tasks, List<List<String>> points, List<dynamic> addedTasks, List<List<dynamic>> subtaks, Client httpClient, DateTime date) {
  List<Widget> taskContent = [];
  // bool isVisible = false;

  List<Widget> temp = [];
  List<bool> boolan = [];

  for(int i = 0; i < tasks.length; i ++) {
    // bool visibilty = false;
    boolan.add(false);
    for(int j = 0; j < subtaks[i].length; j++) {
      temp.add(
        Visibility(
                  visible: boolan[i],
                  child: Column(
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget> [
                          Text(
                            subtaks[i][j]["name"],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xff646464)
                            ),
                          ),

                          Text(
                            points[i][j],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xff646464)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
      );
    }
  }

  for(int i = 0; i < tasks.length; i++) {
      taskContent.add(
      Container(
            margin: const EdgeInsets.fromLTRB(16, 5, 0, 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Text(
                      tasks[i]["compamyName"].length > 20 ? "${tasks[i]["compamyName"].substring(0, 15)}..." : tasks[i]["compamyName"],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xff2E2323)
                      ),
                    ),

                    StatefulBuilder(builder: ((context, setState) {
                      return Checkbox(
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                         value: boolan[i],
                         onChanged: ((value) {
                           setState(() {
                            boolan[i] = value!;
                            value ? addedTasks.add(tasks[i]): addedTasks.remove(tasks[i]);
                            print(addedTasks);
                           });
                         })
                        );
                    }))
                  ],
                ),   
                temp[i]             
              ],             
            ),
          ),
      );
  }

  taskContent.add(Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget> [
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
            print(output);
            httpClient.addTask(
              addedTasks[0]["id"], 
              output.toString(),
              "in process", 
              "up to 6 weeks"
            );

            Navigator.pop(context);
          }, 
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff355CCA),
            textStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white
            )
          ),
          child: const Text("Add")
        ),
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
            fontSize: 15,
            color: const Color(0xff2E2323)
          ),
        ),
      
      actions: <Widget>[
        Container(
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: taskContent
            // mainAxisAlignment: MainAxisAlignment.start,
            // children: <Widget> [
            //     tasks
          
              // Container(
              //   margin: const EdgeInsets.fromLTRB(16, 5, 0, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget> [
              //       Text(
              //         "Task 1",
              //         style: GoogleFonts.poppins(
              //           fontWeight: FontWeight.w400,
              //           fontSize: 14,
              //           color: const Color(0xff2E2323)
              //         ),
              //       ),
          
              //       Row(
              //         children: <Widget> [
              //           Container(
              //             margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              //             child: Text(
              //               "156 point",
              //               style: GoogleFonts.montserrat(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 11,
              //                 color: const Color(0xff151515)
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
          
              // Container(
              //   margin: const EdgeInsets.fromLTRB(16, 5, 0, 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget> [
              //       Text(
              //         "Task 1",
              //         style: GoogleFonts.poppins(
              //           fontWeight: FontWeight.w400,
              //           fontSize: 14,
              //           color: const Color(0xff2E2323)
              //         ),
              //       ),
          
              //       Row(
              //         children: <Widget> [
              //           Container(
              //             margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              //             child: Text(
              //               "156 point",
              //               style: GoogleFonts.montserrat(
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 11,
              //                 color: const Color(0xff151515)
              //               ),
              //             ),
              //           ),
          
              //         ],
              //       )
              //     ],
              //   ),
              // )
            // ],
                ),
          ),
        )
      ]
      );
    },
  );
}

Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }


Container buildCheckbox({required Color iconColor, required Function() onChange, required Color borderColor, required Color backgroundColor}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: borderColor, width: 1),
      color: Colors.transparent
    ),

    child: InkWell(
      onTap: () {onChange;},
      child: Icon(Icons.check, color: iconColor, size: 11,),
    ),
  );
}