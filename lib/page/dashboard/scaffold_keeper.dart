import 'package:flutter/material.dart';
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