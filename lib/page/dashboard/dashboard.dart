import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/date.dart';
import 'package:sis_progress/widgets/bottom_nav_bar.dart';
import 'package:sis_progress/widgets/dashboard/pie_chart.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/tile.dart';

import '../../widgets/dashboard/little_calendar.dart';

class Dashboard extends StatefulWidget {
  final String fullName;

  const Dashboard({
    required this.fullName,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  List<Color> colors = [const Color(0xffFCD2D1),const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1)];
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  @override
  void initState() {
    DateTime date = DateTime.now();
    int index = days.indexOf(DateFormat('EEEE').format(date));
    colors[index] = const Color(0xffFF5C58);
    super.initState();
  }


  void onTaps(int index) {
    colors = [const Color(0xffFCD2D1),const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1), const Color(0xffFCD2D1)];

    setState(() {
      colors[index] = const Color(0xffFF5C58);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> fonts = getFontSize(MediaQuery.of(context).size.width);

    return Scaffold(
      bottomNavigationBar: const NavBar(),
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              buildTitle([fonts[0].toDouble(), fonts[1].toDouble()], widget.fullName),
              buildTileRow([const Color(0xffD2DAFF), const Color(0xffAAC4FF)], [Icon(Icons.rocket, size: 24,), Icon(Icons.calculate, size: 24,)], ["Description", "Description"], [10, 32]),
              buildTileRow([const Color(0xffFCD2D1), const Color(0xffFE8F8F)], [Icon(Icons.book, size: 24,), Icon(Icons.bar_chart, size: 24,)], ["Description", "Description"], [10, 145]),
              LittleCalendar(date: "December, 2022", colors: colors, onTaps: onTaps, days: days,),
              PieChart(context: context, title: "Overall Progress", metadata: const {"points": "1400 / 1600 pt"}),
              ElevatedButton(onPressed: () {print(MediaQuery.of(context).size.width);}, child: Text("Click"))

              // buildLittleCalendar("December, 2022")
              // buildChart()
              // Tile(icon: Icon(Icons.rocket, color:Colors.white), point: 15, description: "Descrption", color: Colors.red)
            ],
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

Container buildTileRow(List<Color> colors, List<Icon> icons, List<String> descriptions, List<int> points) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        Expanded(flex: 1, child: Container(margin: const EdgeInsets.fromLTRB(0, 0, 10, 0), child: Tile(color: colors.first, description: descriptions.first, point: points.first, icon: icons.first,))),
        Expanded(flex: 1, child: Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0), child: Tile(color: colors.last, description: descriptions.last, point: points.last, icon: icons.last,)))
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


