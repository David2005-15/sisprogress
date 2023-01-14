import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/notification_data.dart';
import 'package:sis_progress/page/dashboard/dashboard.dart';
import 'package:sis_progress/page/dashboard/explore_more_goals.dart';
import 'package:sis_progress/page/dashboard/notification_page.dart';
import 'package:sis_progress/page/dashboard/profile.dart';
import 'package:sis_progress/widgets/bottom_nav_bar.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';

import 'calendar_page.dart';
import 'lectures.dart';

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

  bool isVisible = false;

  _ScaffoldHome() {
    page = CalendarPage();
    pages = [const Dashboard(fullName: "Montana",), page, const ExploreMoreGoals(), const Lectures(), const Profile()]; 
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

  void onCheckboxChange() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void initState() {
    body = pages[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: SizedBox(
          width: 45,
          height: 45,  
          child: _selected == 1 ? FloatingActionButton(
            onPressed: () {
              print(page.getChoosenDate());
              print(todayDate);
              _dialogBuilder(context, () { }, onCheckboxChange, isVisible ? Colors.white : Colors.blue, isVisible ? Colors.blue: Colors.white);
            },
            backgroundColor: const Color(0xff355CCA),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 16,),
          ): null,
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

Future<void> _dialogBuilder(BuildContext context, VoidCallback onSave, Function() onChange, Color iconColor, Color backgroundColor) {
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
        Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text(
                  "Task 1",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xff2E2323)
                  ),
                ),

                Row(
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        "156 point",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: const Color(0xff151515)
                        ),
                      ),
                    ),

                    buildCheckbox(iconColor: iconColor, onChange: () {
                      onChange();
                    }, borderColor: Colors.blue, backgroundColor: backgroundColor)
                  ],
                )
              ],
            ),
          )
        ],
      )
      ]
      );
    },
  );
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
      onTap: () {onChange();},
      child: Icon(Icons.check, color: iconColor, size: 11,),
    ),
  );
}