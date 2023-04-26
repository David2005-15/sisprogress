import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/notification_data.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/home.dart';
import 'package:sis_progress/widgets/drawers/if_deleted_account.dart';
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
  late List<Widget> pages;

  Color iconColor = Colors.blue;
  Color backgroundColor = Colors.white;

  String fullName = "";
  String image = "http://drive.google.com/uc?export=view&id=1T4h9d1wyGy-apEyrTW_D6C1UvdLSE166";

  Client httpClient = Client();

  _ScaffoldHome() {
    pages = [
      const Dashboard(),
      const CalendarPage(),
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
    setState(() {
      body = NotificationPage(onChange: getNotificationCount,);
    });
  }

  void setImage() async {
    var temp = await httpClient.getImage();

    setState(() {
      image = temp;
    });
  }

  void onAvatar() {
    setState(() {
      body = Profile(updateAppBar: setImage,);
    });
  }

  int notificationCount = 0;

  void getNotificationCount() async {
    var temp = await httpClient.getDashboardData();

    setState(() {
      notificationCount = temp["notificationCount"];
      debugPrint(temp["notificationCount"].toString());
    });
  }

  bool isValid = true;

  void isValidToken() async {
    var result = await isAccountValid(httpClient);

    setState(() {
      isValid = result;
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
          onChange: (int count) async {

            var result = await isAccountValid(httpClient);
            if(!result) {
              getNotificationCount();

              setState(() {
                _selected = count;
                body = pages[_selected];
              });
            } else {
              var result = await SharedPreferences.getInstance();

              result.setBool("auth", false);
              result.remove("token");
              if(!mounted) return;
              Navigator.push(context, MaterialPageRoute(builder: (builder) => const HomePage()));
            }



          }),
      appBar: CustomAppBar(buildLogoIcon(onIcon), <Widget>[
        buildNotification(onTap: onNotification, count: notificationCount),
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
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: Image.network(url).image,
        ),
      ),
    ),
  );
}

InkWell buildNotification({required VoidCallback onTap, required int count}) {
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
        child: Stack(
          children: <Widget> [
            const Align(
              alignment: AlignmentDirectional(0, 0),
              child: Icon(
                Icons.notifications_outlined,
                size: 17,
                color: Color(0xffD2DAFF),
              ),
            ),

            count != 0 ? Align(
              alignment: const AlignmentDirectional(1, -0.7),
              child: Container(
                width: 20,
                height: 15,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffE31F1F),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text(
                  count.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white
                  ),
                ),
              ),
            ): Container()
          ],
        ),
    ),
  );
}
