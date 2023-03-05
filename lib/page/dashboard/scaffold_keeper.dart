import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/notification_data.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/dashboard/dashboard.dart';
import 'package:sis_progress/page/dashboard/explore_more_goals.dart';
import 'package:sis_progress/page/dashboard/notification_page.dart';
import 'package:sis_progress/page/dashboard/profile.dart';
import 'package:sis_progress/widgets/bottom_nav_bar.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
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
      const MyTask(),
      const Profile()
    ];
  }

  Future<bool> onBackButtonPressed() {
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

    super.initState();
  }

  void onCheckboxChange() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  bool isVisible = false;

  var format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
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

SizedBox buildLogoIcon(VoidCallback onTap) {
  return SizedBox(
    width: 82,
    height: 62,
    child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onTap,
        icon: SvgPicture.asset(
          "assets/LOGOSIS.svg",
          width: 82,
          height: 62,
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
        )),
  );
}

InkWell buildNotification({required VoidCallback onTap}) {
  return InkWell(
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
