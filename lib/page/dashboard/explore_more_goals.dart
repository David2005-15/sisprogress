import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/dashboard/goal.dart';

class ExploreMoreGoals extends StatefulWidget {
  const ExploreMoreGoals({super.key});

  @override
  State<StatefulWidget> createState() => _ExploreMoreGoals();

}

class _ExploreMoreGoals extends State<ExploreMoreGoals> {
  List<String> titles = ["Extracurricular"];
  late Widget body;

  @override
  void initState() {
    body = Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            buildTitle(),
            buildButton("Extracurricular", getState),
          ],
        ),
      ),
    );

    super.initState();
  }

  void getState(String name) {
    setState(() {
      body = GoalPage(title: name,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: body
    );
  }

}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Explore more goals",
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

Container buildButton(String text, Function(String) callback) {
  return Container(
    decoration: const BoxDecoration(
      boxShadow: <BoxShadow> [
        BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
      ],
      borderRadius: BorderRadius.all(Radius.circular(5)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color> [
          Color(0xff272935),
          Color(0xff121623),
        ]
      )
    ),
    margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
      onPressed: () {
        callback(text);
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: const Color(0xffFCD2D1)
        ),
      ),
    ),
  );
}