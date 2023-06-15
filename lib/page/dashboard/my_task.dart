import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/dashboard/my_task_tile.dart';
import 'package:sis_progress/widgets/filter_drop_down.dart';

import '../../data class/event_process.dart';

class MyTask extends StatefulWidget {
  const MyTask({super.key});

  @override
  State<StatefulWidget> createState() => _MyTask();
}

class _MyTask extends State<MyTask> {
  List<String> status = [
    "All",
    "Completed",
    "In Progress",
    "Late Done",
    "Planned",
    "Overdue"
  ];

  String statusText = "Task Status";

  var httpClient = Client();
  var tasks = [];

  @override
  void initState() {
    printAllTasks();
    super.initState();
  }

  void filter(String value) {
    if (value != "All" && value != "Task Status") {
      tasks = tasks.where((element) => element["status"] == value).toList();
    }
  }

  Future<List<dynamic>> getAllFeedbacks(taskId) {
    var temp = httpClient.getAllFeedbacks(taskId).then((value) {
      return value;
    });

    return temp;
  }

  Future printAllTasks() async {
    var temp = await httpClient.getCalendarEvents();
    setState(() {
      tasks = temp;
    });
  }

  EventProccess getProccess(String name) {
    switch (name) {
      case "In Progress":
        return EventProccess.progress;
      case "Planned":
        return EventProccess.planned;
      case "Overdue":
        return EventProccess.overdue;
      case "Late Done":
        return EventProccess.later;
      default:
        return EventProccess.completed;
    }
  }

  final GlobalKey _menuKey = GlobalKey();

  var filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    filter(statusText);

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: Stack(
                  children: <Widget> [
                    Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Container(
                        height: 30,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextField(
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            fontSize: 11,
                            color: Colors.white
                          ),
                          controller: filterController,
                          onChanged: (val) async {
                            await printAllTasks();
                            setState(() {
                              tasks = tasks.where((element) => element["positionName"].toString().contains(val)).toList();
                            });
                          },
                          decoration: InputDecoration(
                              // focusColor: Colors.transparent,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(color: Colors.transparent)
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              filled: true,
                              hintStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 11),
                              hintText: "Search task",
                              fillColor: const Color(0xff3A3D4C)),
                        ),
                      ),
                    ),

                    Align(
                      alignment: const AlignmentDirectional(1, 0),
                      child: Container(
                        width: 50,
                        height: 30,
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        decoration: BoxDecoration(
                          color: const Color(0xff121623),
                          borderRadius: BorderRadius.circular(40)
                        ),
                      ),
                    ),

                    Align(
                      alignment: const AlignmentDirectional(1, 1),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xff3A3D4C)
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Color(0xffB1B2FF),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              FilterDropDown(
                statuses: status,
                status: statusText,
                onChange: (val) async {
                  await printAllTasks();

                  setState(() {
                    statusText = val;
                    if (statusText != "All") {
                      tasks = tasks.where((element) =>
                      element["status"] == val).toList();
                    }
                  });
                },
              ),
              pointStatusRow(),
              Column(
                children: tasks.map((e) {
                  List<List<dynamic>> swap = [];
                  List<String> temp = [];
                  List<bool> temp2 = [];
                  List<double> temp3 = [];

                  e["SubTasks"].forEach((p0) {
                    swap.add([
                      p0["name"],
                      p0["id"],
                      p0["description"],
                      p0["status"]
                    ]);
                    if (p0["status"] == true) {
                      temp2.add(true);
                    }
                    temp.add("${p0["points"]} Points");
                    temp3.add(double.parse(p0["points"].toString()));
                  });

                  String substringValue = "${temp2.length}/${swap.length}";

                  return MyTaskTile(
                    process: getProccess(e["status"]),
                    title: e["positionName"],
                    description: "",
                    subtasks: swap,
                    points: temp,
                    eventDate:
                        "${DateTime.parse(e["deadline"]).day}/${DateTime.parse(e["deadline"]).month}/${DateTime.parse(e["deadline"]).year}",
                    substringValue: substringValue,
                    updateState: () {
                      printAllTasks();
                      filter(statusText);
                      debugPrint(statusText);
                    },
                    position: e["companyName"],
                    status: e["status"],
                    facultyName: e["facultyName"],
                    companyName: e["companyName"],
                    chosenDate: DateTime.parse(e["startDate"]),
                    point: "${e["point"]} Points",
                    taskId: e["id"],
                    feedbacks: getAllFeedbacks(e["id"]),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}


Container pointStatusRow() {
  return Container(
    margin: const EdgeInsets.fromLTRB(5, 32, 5, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
              margin: const EdgeInsets.fromLTRB(32, 0, 0, 0),
              child: Text(
                "My Points",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xffBFBFBF)),
              )),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "Status",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xffBFBFBF)),
              )),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 32, 0),
              child: Text(
                "Due date for max points",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xffBFBFBF)),
              )),
        )
      ],
    ),
  );
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "My Tasks",
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.02,
            color: Colors.white),
      ),
    ),
  );
}

Container buildTile(String title, String status, String position, String date,
    Color statusColor) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
    width: double.infinity,
    height: 75,
    decoration: const BoxDecoration(
        color: Colors.transparent,
        border:
            Border(bottom: BorderSide(width: 2.5, color: Color(0xffB1B2FF)))),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color(0xffB1B2FF)),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  position,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color(0xffB1B2FF)),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      color: statusColor),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 45, 10),
          child: Text(
            date,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400, fontSize: 13, color: Colors.white),
          ),
        )
      ],
    ),
  );
}
