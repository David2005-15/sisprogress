import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/event_process.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/dashboard/show_subtask.dart';

class EventTile extends StatefulWidget {
  final String title;
  final EventProccess proccess;
  final String facultyName;
  final String companyName;
  final String eventDate;
  final String description;
  final List<List<dynamic>> subtasks;
  final List<String> points;
  final String substringValue;
  final VoidCallback updateState;
  final DateTime choosenDate;

  // final List<bool> passed;

  EventTile(
      {required this.eventDate,
      required this.points,
      required this.subtasks,
      required this.description,
      required this.proccess,
      required this.title,
      required this.substringValue,
      required this.updateState,
      required this.facultyName,
      required this.companyName,
      required this.choosenDate,
      // required this.passed,
      super.key});

  @override
  State<StatefulWidget> createState() => _EventTile();
}

class _EventTile extends State<EventTile> {
  Client httpClient = Client();

  var tasks = [];

  @override
  void initState() {
    super.initState();
    updateTasks();

    // print(tasks);
  }

  void updateTasks() async {
    var temp = await httpClient.getCalendarEvents();
    setState(() {
      tasks = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    // widget.subtasks.forEach((element) => print(element),);
    // print(tasks.where((element) => element["positionName"] == widget.title));

    return InkWell(
      onTap: () {
        if(widget.choosenDate.day <= DateTime.now().day) {
          _dialogBuiler(context, widget.title);
        } else {
          _youCanStart(widget.title);
        }
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
          width: double.infinity,
          height: 75,
          margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
          decoration: BoxDecoration(
              color: widget.proccess.eventColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                    width: 4,
                    height: 63,
                    decoration: BoxDecoration(
                        color: widget.proccess.leftColor,
                        borderRadius: BorderRadius.circular(7)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(17, 8, 0, 0),
                        child: Text(
                          widget.title,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: const Color(0xff2E2323)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(17, 0, 5, 8),
                                  child: widget.proccess.icon),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Text(
                                  widget.proccess.eventName,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: const Color(0xff2E2323)),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(100, 0, 0, 10),
                            child: Text(
                              widget.substringValue,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                            child: Text(
                              widget.eventDate,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }


  Future<void> _youCanStart(String title) {
    return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                         Row(
                          children: <Widget> [
                            Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: SvgPicture.asset(
                            "assets/Vector.svg",
                            height: 25,
                            width: 25,
                            // color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.facultyName.length > 15 ? widget.facultyName.substring(0, 15) : widget.facultyName,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: const Color(0xff2E2323)),
                        ),
                          ],
                        ),
                         Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: _getUpdateCloseButton(context, widget.updateState),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      children: <Widget> [
                         Row(
                          children: <Widget> [
                            Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: SvgPicture.asset(
                            "assets/Vector.svg",
                            height: 25,
                            width: 25,
                            // color: Colors.black,
                          ),
                        ),
                        Text(
                          widget.companyName,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: const Color(0xff2E2323)),
                        ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget> [
                            Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: SvgPicture.asset(
                            "assets/Vector.svg",
                            height: 25,
                            width: 25,
                            // color: Colors.black,
                          ),
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: const Color(0xff2E2323)),
                        ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(40, 20, 18, 30),
                    child: Text(
                      "You can start this task from ${DateFormat.MMMM().format(DateTime.parse(widget.choosenDate.toIso8601String()))} ${widget.choosenDate.day}th ",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: const Color(0xff3A3D4C)
                      ),
                    ),
                  )
                ],
              ),
        );
      }
    );
  }

  Future<void> _dialogBuiler(BuildContext context, String title) {
    // List<int> subTaskId = [];
    List<int> subtaskId = [];
    List<dynamic> enabledValues = [];
    List<bool> cantYouSee = [];
    List<Widget> taskContent = [];

    var swap = [];

    for (int i = 0; i < widget.subtasks.length; i++) {
      enabledValues.add(widget.subtasks[i][3]);
      cantYouSee.add(widget.subtasks[i][3]);

      taskContent.add(Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 185,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.subtasks[i][0].length > 20 ? "${widget.subtasks[i][0].substring(0, 20)}..." : widget.subtasks[i][0],
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xff2E2323)),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                    widget.points[i],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: const Color(0xff2E2323)),
                  ),
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                  padding: const EdgeInsets.all(0),
                  height: 24,
                  width: 24,
                  child: StatefulBuilder(
                    builder: (context, state) {
                      return Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            // checkColor: Colors.blue,
                            value: enabledValues[i],
                            onChanged: ((val) async {
                              state(
                                () {
                                  // if(enabledValues[i] == false) {
                                    if(cantYouSee[i] == false) {
                                      enabledValues[i] = val!;
                                    }
                                  // }
                      
                                  widget.subtasks[i][3] = enabledValues[i];
                                  
                                  // print(val!);
                                  // p0[3] = val!;
                                  // print(p0[3]);
                                  
                                  if (enabledValues[i]) {
                                    subtaskId.add(widget.subtasks[i][1]);
                                  } else {
                                    subtaskId.remove(widget.subtasks[i][1]);
                                  }
                      
                                  print(subtaskId);
                      
                                  // _showEssay(context, p0[0], title, p0[1], p0[2]);
                                },
                              );
                              // await httpClient.doneSubtask(p0[1], p0[3]);
                      
                              widget.updateState();
                            })),
                      );
                    }
                  ),
                ),
              ],
            )
            // buildCheckbox(iconColor: Colors.blue, onChange: onChange, borderColor: borderColor, backgroundColor: backgroundColor)
          ],
        ),
      ));
    }

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              widget.updateState();
            },
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                         Row(
                          children: <Widget> [
                            Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: SvgPicture.asset(
                            "assets/Vector.svg",
                            height: 25,
                            width: 25,
                            // color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 150,
                          child: Text(
                            widget.facultyName,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: const Color(0xff2E2323)),
                          ),
                        ),
                          ],
                        ),
                         Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: _getUpdateCloseButton(context, widget.updateState),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      children: <Widget> [
                         Row(
                          children: <Widget> [
                            Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: SvgPicture.asset(
                            "assets/Vector.svg",
                            height: 25,
                            width: 25,
                            // color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            widget.companyName,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: const Color(0xff2E2323)),
                          ),
                        ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget> [
                            Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: SvgPicture.asset(
                            "assets/Vector.svg",
                            height: 25,
                            width: 25,
                            // color: Colors.black,
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: const Color(0xff2E2323)),
                          ),
                        ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                StatefulBuilder(builder: (context, state) {
                  return Container(
                    // height: 400,
                    width: 350,

                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: ImageIcon(
                                        AssetImage("assets/MyPoints.png"),
                                        color: const Color(0xff3A3D4C),
                                        size: 15,
                                    ),
                                  ),
                                  Text(
                                    'My Points',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: const Color(0xff3A3D4C)),
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              16, 0, 5, 0),
                                          child: const Icon(
                                            Icons.rocket_outlined,
                                            color: Color(0xff3A3D4C),
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          "Time Points",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: const Color(0xff3A3D4C)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                // margin: const EdgeInsets.fromLTRB(0, 5, 30, 0),
                                                child: Text(
                                                  "Duration",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: const Color(
                                                          0xff3A3D4C)),
                                                ),
                                              ),
                                              Container(
                                                // margin: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                                                child: Text(
                                                  "Points",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                      color: const Color(
                                                          0xff3A3D4C)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "up to 6 weeks",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              ),
                                              Text(
                                                "3 points",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "8 - 10 weeks",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              ),
                                              Text(
                                                "2 points",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "10 - 12 weeks",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              ),
                                              Text(
                                                "1 points",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "12 & more weeks",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              ),
                                              Text(
                                                "0.5 points",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(0xff3A3D4C)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                    Container(
                                      margin: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: <Widget> [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   color: Color(0xffCEE5D0),
                                                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))
                                                  // ),
                                                  child: Text(
                                                    "Up to 6 weeks",
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 8,
                                                      color: const Color(0xff121623)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   color: Color(0xffFFF89A)
                                                  // ),
                                                  child: Text(
                                                    "8 - 10 weeks",
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 8,
                                                      color: const Color(0xff121623)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   color: Color(0xffFEBE8F)
                                                  // ),
                                                  child: Text(
                                                    "10 - 12 weeks",
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 8,
                                                      color: const Color(0xff121623)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  alignment: Alignment.center,
                                                  // decoration: BoxDecoration(
                                                  //   color: Color(0xffFE8F8F),
                                                  //   borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                                                  // ),
                                                  child: Text(
                                                    "12 & more weeks",
                                                    style: GoogleFonts.montserrat(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 8,
                                                      color: const Color(0xff121623)
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget> [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffCEE5D0),
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFFF89A)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFEBE8F)
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xffFE8F8F),
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: ImageIcon(
                                        AssetImage("assets/Subtask.png"),
                                        color: const Color(0xff3A3D4C),
                                        size: 20,
                                    ),
                                  ),
                                  Text(
                                    'Subtasks',
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: const Color(0xff3A3D4C)),
                                  ),
                                ],
                              ),
                              children: <Widget>[
                                Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                        const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: taskContent,
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 104,
                                        height: 36,
                                        child: OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            foregroundColor:
                                                const Color(0xff355CCA),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            side: const BorderSide(
                                                color: Color(0xff355CCA),
                                                width: 1),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: const Color(0xff355CCA)),
                                          ),
                                        ),
                                      ),
                                      Container(
                                            width: 104,
                                            height: 36,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff355CCA),
                                                shadowColor: Colors.transparent,
                                                foregroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                print(subtaskId);

                                                subtaskId.forEach((element) async {
                                                  await httpClient.doneSubtask(
                                                      element, true);
                                                      widget.updateState();
                                                });
                                                widget.updateState();
                                                // widget.updateState();

                                                Navigator.pop(context);
                                                
                                              },
                                              child: Text(
                                                "Submit",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ),                   
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }).then((value) {
      widget.updateState();
    });
  }
}

_getCloseButton(context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: GestureDetector(
      child: Container(
        alignment: FractionalOffset.topRight,
        child: GestureDetector(
          child: const Icon(
            Icons.clear,
            color: Colors.grey,
            size: 12.5,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}

_getUpdateCloseButton(context, VoidCallback updateState) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: GestureDetector(
      child: Container(
        alignment: FractionalOffset.topRight,
        child: GestureDetector(
          child: const Icon(
            Icons.clear,
            color: Colors.grey,
            size: 12.5,
          ),
          onTap: () {
            Navigator.pop(context);
            updateState();
          },
        ),
      ),
    ),
  );
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
    MaterialState.selected
  };
  if (!states.any(interactiveStates.contains)) {
    return const Color(0xffAAC4FF);
  }
  return const Color(0xff355CCA);
}
