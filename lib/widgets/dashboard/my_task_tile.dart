import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/event_process.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/custom_button.dart';

class MyTaskTile extends StatefulWidget {
  final String title;
  final String position;
  final String status;
  final EventProccess proccess;
  final String eventDate;
  final String description;
  final List<List<dynamic>> subtasks;
  final List<String> points;
  final String substringValue;
  final VoidCallback updateState;
  final String companyName;
  final String facultyName;
  final DateTime choosenDate;
  final String point;


  // final List<bool> passed;

  MyTaskTile(
      {required this.eventDate,
      required this.position,
      required this.status,    
      required this.points,
      required this.subtasks,
      required this.description,
      required this.proccess,
      required this.title,
      required this.substringValue,
      required this.updateState,
      required this.companyName,
      required this.facultyName,
      required this.choosenDate,
      required this.point,
      // required this.passed,
      super.key});

  @override
  State<StatefulWidget> createState() => _MyTaskTile();
}

class _MyTaskTile extends State<MyTaskTile> {
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
        if(DateTime.now().day >= widget.choosenDate.day) {
          _dialogBuiler(context, widget.title);
        } else {
          _youCanStart(widget.title);
        }
      },
      highlightColor:  Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
              margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
              width: double.infinity,
              height: 75,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(width: 2.5, color: Color(0xffB1B2FF))
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.title,
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
                            widget.position,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: const Color(0xffB1B2FF)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                          child: Text(
                            widget.point,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              widget.status,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                color: widget.proccess.eventColor
                              ),
                            ),
                          ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 45, 0),
                          child: Text(
                            "${widget.eventDate}, ${widget.choosenDate.year}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
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
                          widget.companyName.length > 15 ? widget.companyName.substring(0, 10) : widget.companyName,
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
                          title.length > 15
                              ? "${title.substring(0, 10)}..."
                              : title,
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

  Future<void> _showEssay(BuildContext context, String subtaskTitle,
      String taskName, int taskId, String? description) {
    var essayController = TextEditingController();

    print(description);

    if (description != null) {
      essayController.text = description;
    }

    return showDialog<void>(
      // barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Container(
            child: Column(
              children: [
                _getCloseButton(context),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                      text: taskName,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: const Color(0xff2E2323)),
                      children: [
                        TextSpan(
                          text: "\n$subtaskTitle",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: const Color(0xff2E2323)),
                        )
                      ]),
                ),
              ],
            ),
          ),
          actions: [
            Column(
              children: [
                StatefulBuilder(builder: ((context, setState) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    height: 160,
                    child: TextFormField(
                      onChanged: ((value) {
                        setState(() {
                          description = essayController.text;
                        });
                      }),
                      controller: essayController,
                      expands: false,
                      maxLines: 8,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: const Color(0xff646464)),
                      // initialValue: "Type about your activites or work experiance",
                      decoration: InputDecoration(
                        hintText:
                            "Type about your activites or work experiance",
                        hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontStyle: FontStyle.normal,
                            color: const Color(0xff646464)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffD2DAFF), width: 1)),
                        border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffD2DAFF), width: 1)),
                        focusColor: const Color(0xffD2DAFF),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffD2DAFF))),
                      ),
                    ),
                  );
                })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Button(
                    //   text: "Cancel",
                    //   onPressed: () async {
                    //     // await httpClient.sendEssay(essayController.text, taskId);
                    //     Navigator.pop(context);
                    //   },
                    //   height: 34,
                    //   width: 101
                    // ),
                    Container(
                      height: 34,
                      width: 101,
                      margin: const EdgeInsets.fromLTRB(18, 10, 0, 0),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: const Color(0xff355CCA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          side: const BorderSide(
                              color: Color(0xff355CCA), width: 1),
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
                    Button(
                        text: "Add",
                        onPressed: () async {
                          await httpClient.sendEssay(
                              essayController.text, taskId);
                          widget.updateState();
                          Navigator.pop(context);
                        },
                        height: 34,
                        width: 86),
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> _dialogBuiler(BuildContext context, String title) {
    List<int> subTaskId = [];
    List<dynamic> enabledValues = [];
    List<bool> canyYouSee = [];
    List<Widget> taskContent = [];

    for (int i = 0; i < widget.subtasks.length; i++) {
      enabledValues.add(widget.subtasks[i][3]);
      canyYouSee.add(widget.subtasks[i][3]);

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
                    widget.subtasks[i][0].length > 15 ? "${widget.subtasks[i][0].substring(0, 15)}..." : widget.subtasks[i][0],
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xff2E2323)),
                  ),
                  Text(
                    widget.points[i],
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: const Color(0xff2E2323)),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                  padding: const EdgeInsets.all(0),
                  height: 24,
                  width: 24,
                  child: StatefulBuilder(
                    builder: (context, state) {
                      return Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: enabledValues[i],
                            onChanged: ((val) async {
                              state(
                                () {
                                  if(canyYouSee[i] == false) {
                                    enabledValues[i] = val!;
                                  }
                      
                                  widget.subtasks[i][3] = enabledValues[i];
                                  
                                  // print(val!);
                                  // p0[3] = val!;
                                  // print(p0[3]);
                                  
                                  if (enabledValues[i]) {
                                    subTaskId.add(widget.subtasks[i][1]);
                                  } else {
                                    subTaskId.remove(widget.subtasks[i][1]);
                                  }
                      
                                  print(subTaskId);
                      
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
                  Row(
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
                  Row(
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
                        widget.companyName.length > 15 ? widget.companyName.substring(0, 10) : widget.companyName,
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
                  Row(
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
                        title.length > 15
                            ? "${title.substring(0, 10)}..."
                            : title,
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
                                            subTaskId.forEach((element) async {
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