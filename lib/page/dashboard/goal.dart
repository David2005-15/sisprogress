import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/dashboard/explore_more_goals_tile.dart';

class GoalPage extends StatefulWidget {
  final String title;

  const GoalPage({
    required this.title,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _GoalPage();
}

class _GoalPage extends State<GoalPage> {
  Client client = Client();

  List<Widget> goals = [];

  @override
  void initState() {
    getAllTasks();

    super.initState();
  }

  List<dynamic> tasks = [

  ];

  void getAllTasks() async {
    var temp = await client.getAllTaskAndFilter();
    print(temp);
    setState(() {
      tasks = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    for(int i = 1; i < tasks.length; i+=2) {
      setState(() {
        goals.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              ExploreTile(title: tasks[i - 1]["positionName"], disabled: !(tasks[i - 1]["isFree"] == "false2"), taskId: tasks[i - 1]["id"], taskCount: "${tasks[i - 1]["SubTasks"].where((p0) => p0['done'] == true).length}/${tasks[i - 1]["SubTasks"].length}",),
              ExploreTile(title: tasks[i]["positionName"], disabled:!(tasks[i]["isFree"] == "false2"), taskId: tasks[i]["id"], taskCount: "${tasks[i]["SubTasks"].where((p0) => p0['done'] == true).length}/${tasks[i]["SubTasks"].length}",)
            ],
        ));
      });
    }

    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            buildTitle(),
            buildButton(widget.title, (p0) {}),
            Column(
              children: goals,
            )
          ],
        ),
      ),
    );
  }
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Extracurricular",
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