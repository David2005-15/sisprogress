import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/notification_data.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'dashboard.dart';
import 'explore_more_goals.dart';
import 'notification_page.dart';
import 'profile.dart';
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
  String image = "http://drive.google.com/uc?export=view&id=1T4h9d1wyGy-apEyrTW_D6C1UvdLSE166";

  Client httpClient = Client();


  _ScaffoldHome() {
    page = const CalendarPage();
    pages = [
      const Dashboard(),
      page,
      const ExploreMoreGoals(),
      const MyTask(),
      Profile(updateAppBar: setImage,)
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

  void setImage() async {
    var temp = await httpClient.getImage();

    setState(() {
      image = temp;
    });

    debugPrint("Hello");
  }

  void onAvatar() {
    setState(() {
      body = Profile(updateAppBar: setImage,);
    });


  }

  @override
  void initState() {
    body = pages[0];
    setImage();

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

            setImage();
          }),
      appBar: CustomAppBar(buildLogoIcon(onIcon), <Widget>[
        buildNotification(onTap: onNotification),
        buildAvatar(onTap: onAvatar, url: image)
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

InkWell buildAvatar({required VoidCallback onTap, required String url}) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.fromLTRB(15, 0, 16, 0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: Image.network(url, fit: BoxFit.scaleDown,).image,
        radius: 55,
      ),
    ),
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
