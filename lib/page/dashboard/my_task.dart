import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/dashboard/my_task_tile.dart';

import '../../data class/event_process.dart';

class MyTask extends StatefulWidget {
  final DateTime choosenDate;
  const MyTask({
    required this.choosenDate,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _MyTask();

}

class _MyTask extends State<MyTask> {
  List<String> status = ["All", "Completed", "In Progress", "Late Done", "Planned", "Overdue"];

  String statusText = "Task Status";

  var httpClient = Client();
  var tasks = [];

  @override
  void initState() {
    printAllTasks();
    super.initState();
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
    switch(name) {
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

  GlobalKey _menuKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Hello");

        return Future.value(false);
      },
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              buildTitle(),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  dynamic state = _menuKey.currentState;
                  state.showButtonMenu();
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: const Color(0xff355CCA))
                  ),
                  width: 176,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        child: Text(
                          statusText,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xff355CCA)
                          ),
                        ),
                      ),
              
                      Theme(
                        data: Theme.of(context).copyWith(
                          highlightColor: const Color(0xffAAC4FF),
                          splashColor: Colors.transparent,
                        ),
                        child: PopupMenuButton(
                          key: _menuKey,
                          icon: const ImageIcon(
                            AssetImage("assets/Vectorchevorn.png"),
                            size: 14,
                            color: Colors.grey,
                          ),
                          
                        onSelected: (val) async {
                          await printAllTasks();
                                  
                          setState(() {
                            statusText = val;
                            if(statusText != "All") {
                              tasks = tasks.where((element) => element["status"] == val).toList();
                            }
                          });
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                                  
                        offset: const Offset(-120, 50),
                                        // color: const Color(0xff3A3D4C),
                        color: const Color(0xffD2DAFF),
                        itemBuilder: (BuildContext context) {
                          return status.map<PopupMenuItem<String>>((String value) {
                            return PopupMenuItem(value: value.toString(), child: Text(value.toString(), style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: const Color(0xff3A3D4C)
                            ),));
                          }
                        ).toList();
                                        },
                                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 32, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                      child: Text(
                        "My Points",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: const Color(0xffBFBFBF)
                        ),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        "Status",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: const Color(0xffBFBFBF)
                        ),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                      child: Text(
                        "Due date for max points",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: const Color(0xffBFBFBF)
                        ),
                      )
                    )
                  ],
                ),
              ),
    
              Column(
                children: tasks.map((e) {
                  String monthName = DateFormat.MMMM().format(DateTime.parse(e["deadline"])).substring(0, 3);
                  print(monthName);
    
                  List<List<dynamic>> swap = []; 
                  List<String> temp = [];
                  List<bool> temp2 = [];
                  List<int> temp3 = [];
                  
                  e["SubTasks"].forEach((p0) {
                    swap.add([p0["name"], p0["id"], p0["description"], p0["status"]]);
                    if(p0["status"] == true) {
                      temp2.add(true);
                    }
                    temp.add("${p0["points"]} Points");
                    temp3.add(p0["points"]);
                  });  
    
                  print(e);
      
                  String substringValue = "${temp2.length}/${swap.length}";
                  return MyTaskTile(proccess: getProccess(e["status"]), title: e["positionName"], description: "", subtasks: swap, points: temp, eventDate: "${DateTime.parse(e["deadline"]).day}/${DateTime.parse(e["deadline"]).month}/${DateTime.parse(e["deadline"]).year}", substringValue: substringValue, updateState: printAllTasks, position: e["companyName"], status: e["status"], facultyName: e["facultName"], companyName: e["companyName"], choosenDate: DateTime.parse(e["startDate"]), point: "${e["point"]} Points", taskId: e["id"], feedbacks: getAllFeedbacks(e["id"]),);
    
                }).toList(),
              )
    
              // buildTile("Company", "In Progress", "Position Name", "7th of Dec, 2023", const Color(0xff94B49F)),
              // buildTile("Company", "Overdue", "Position Name", "7th of Dec, 2023", const Color(0xffFFC900)),
              // buildTile("Company", "Late Done", "Position Name", "7th of Dec, 2023", const Color(0xffE31F1F))
            ],
          ),
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
        "My Tasks",
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


Container buildTile(String title, String status, String position, String date, Color statusColor) {
  return Container(
              margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
              width: double.infinity,
              height: 75,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(width: 2.5, color: Color(0xffB1B2FF))
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                              color: const Color(0xffB1B2FF)
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            position,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: const Color(0xffB1B2FF)
                            ),
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
                              color: statusColor
                            ),
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
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            );
}