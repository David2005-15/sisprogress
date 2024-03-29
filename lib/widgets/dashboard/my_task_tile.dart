import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/event_process.dart';
import 'package:sis_progress/http%20client/http_client.dart';

class MyTaskTile extends StatefulWidget {
  final String title;
  final String position;
  final String status;
  final EventProccess process;
  final String eventDate;
  final String description;
  final List<List<dynamic>> subtasks;
  final List<String> points;
  final String substringValue;
  final VoidCallback updateState;
  final String companyName;
  final String facultyName;
  final DateTime chosenDate;
  final String point;
  final int taskId;
  final Future<List<dynamic>> feedbacks;

  const MyTaskTile(
      {required this.eventDate,
      required this.position,
      required this.status,
      required this.points,
      required this.subtasks,
      required this.description,
      required this.process,
      required this.title,
      required this.substringValue,
      required this.updateState,
      required this.companyName,
      required this.facultyName,
      required this.chosenDate,
      required this.point,
      required this.taskId,
      required this.feedbacks,
      // required this.passed,
      super.key});

  @override
  State<StatefulWidget> createState() => _MyTaskTile();
}

class _MyTaskTile extends State<MyTaskTile> {
  Client httpClient = Client();

  var tasks = [];
  var feedback = [];

  var points = [];
  var currentDay = 0;
  double currentPoint = 0;

  void getAllTasks() async {
    var temp = await httpClient.getTimePoints(widget.taskId);

    setState(() {
      points = temp["taskDesc"];
      currentDay = temp["currentDay"];
      currentPoint = double.parse(temp["currentPoint"].toString());
    });
  }

  @override
  void initState() {
    super.initState();
    updateTasks();
    getAllTasks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateTasks() async {
    var temp = await httpClient.getCalendarEvents();
    setState(() {
      tasks = temp;
    });
  }

  List<dynamic> feedbacks = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (widget.chosenDate.day <= DateTime.now().day) {
            _dialogBuilder(context, widget.title, feedback);
          } else {
            _youCanStart(widget.title, feedback);
          }
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                  bottom: BorderSide(width: 2.5, color: Color(0xffB1B2FF)))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
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
                            color: const Color(0xffB1B2FF)),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        widget.position,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: const Color(0xffB1B2FF)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                          child: Text(
                            widget.point,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.white),
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
                                color: widget.process.eventColor),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 60, 0),
                      child: Text(
                        widget.eventDate,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<void> _youCanStart(String title, List<dynamic> feedback) {
    List<int> subtaskId = [];
    List<dynamic> enabledValues = [];
    List<bool> cantYouSee = [];

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            List<Widget> taskContent = [];

            for (int i = 0; i < widget.subtasks.length; i++) {
              enabledValues.add(widget.subtasks[i][3]);
              cantYouSee.add(widget.subtasks[i][3]);

              taskContent.add(Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xffD4D4D4)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width < 370 ?100: 185,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width < 370 ? 100 :130,
                            child: Text(
                              widget.subtasks[i][0],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width < 370 ?  10: 14,
                                  color: const Color(0xff2E2323)),
                            ),
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
                          child: StatefulBuilder(builder: (context, state) {
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: !cantYouSee[i] == false
                                          ? Colors.transparent
                                          : enabledValues[i]
                                          ? const Color(0xff355CCA)
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: !cantYouSee[i] == false
                                              ? const Color(0xffAAC4FF)
                                              : const Color(0xffAAC4FF))),
                                  child: Icon(
                                    Icons.check,
                                    size: 18,
                                    color: !cantYouSee[i] == false
                                        ? const Color(0xffAAC4FF)
                                        : enabledValues[i]
                                        ? Colors.white
                                        : Colors.transparent,
                                  )),
                            );
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ));
            }
            return AlertDialog(
              scrollable: true,
              backgroundColor: Colors.white,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: SvgPicture.asset(
                                "assets/Vector.svg",
                                height: 25,
                                width: 25,
                                // color: Colors.black,
                              ),
                            ),
                            SizedBox(
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
                          child: _getUpdateCloseButton(
                              context, () {}),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/Rectangle.svg",
                                height: 12,
                                width: 12,
                                // color: Colors.black,
                              ),
                            ),
                            SizedBox(
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
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                              child: SvgPicture.asset(
                                "assets/Circle.svg",
                                height: 12,
                                width: 12,
                                // color: Colors.black,
                              ),
                            ),
                            SizedBox(
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
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const ImageIcon(
                                    AssetImage("assets/MyPoints.png"),
                                    color: Color(0xff3A3D4C),
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
                                Text(
                                  "     ${(currentPoint.toString().split(".")[1] == "0" ? currentPoint.toInt() : currentPoint).toString()} ${MediaQuery.of(context).size.width < 370 ? "":"points"}",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: const Color(0xff3a3d4c)),
                                )
                              ],
                            ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Duration",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color:
                                                const Color(0xff3A3D4C)),
                                          ),
                                          Text(
                                            "Points",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color:
                                                const Color(0xff3A3D4C)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: points.map<Widget>((e) {
                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                e["taskSpentWeek"] ?? "Hello",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              ),
                                              Text(
                                                "${e["point"]} point",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                                    width: double.infinity,
                                    height: 70,
                                    child: Stack(
                                      children: <Widget> [
                                        Align(
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: Container(
                                            height: 10,
                                            width: double.infinity,
                                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  stops: [
                                                    0,
                                                    0.25,
                                                    0.25,
                                                    0.5,
                                                    0.5,
                                                    0.75,
                                                    0.75,
                                                    1
                                                  ],
                                                  colors: [
                                                    Color(0xFFCEE5D0),
                                                    Color(0xFFCEE5D0),
                                                    Color(0xFFFFF89A),
                                                    Color(0xFFFFF89A),
                                                    Color(0xFFFEBE8F),
                                                    Color(0xFFFEBE8F),
                                                    Color(0xFFFE8F8F),
                                                    Color(0xFFFE8F8F),
                                                  ],
                                                )),
                                          ),
                                        ),

                                        Align(
                                          alignment: AlignmentDirectional((currentDay * 2 - 60) / 60, 0),
                                          child: Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                                color: Colors.purple.shade200,
                                                shape: BoxShape.circle),
                                          ),
                                        ),

                                        Align(
                                          alignment: AlignmentDirectional((currentDay * 2 - 60) / 60, 1),
                                          child: Text(
                                            "${currentPoint.toString()} point",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: const Color(0xff3A3D4C)),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional((currentDay * 2 - 60) / 60, 0.5),
                                          child: Text(
                                            "${(currentDay < 0 ? 0: currentDay).toString()} days",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color:
                                                const Color(0xff3A3D4C)),
                                          ),
                                        ),
                                      ],
                                    )
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
                                const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: const ImageIcon(
                                  AssetImage("assets/Subtask.png"),
                                  color: Color(0xff3A3D4C),
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
                                height: 150,
                                alignment: Alignment.centerLeft,
                                margin:
                                const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: taskContent,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _putFeedback(context, widget.taskId,
                                widget.description, feedback);
                          },
                          child: Text(
                            "Leave your feedback",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: const Color(0xff355CCA),
                                decoration: TextDecoration.underline),
                          )),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                        alignment: Alignment.center,
                        child: Text(
                          "You can start this task from ${DateFormat.MMMM().format(DateTime.parse(widget.chosenDate.toIso8601String()))} ${widget.chosenDate.day}th",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 8, 10, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              width: 102,
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // await httpClient.removeTask(widget.taskId);
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  widget.updateState();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: const BorderSide(width: 1.5, color: Color(0xffE31F1F))
                                ),
                                child: Text(
                                  "Cancel",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: const Color(0xffE31F1F)
                                  ),
                                ),

                              ),
                            ),
                            SizedBox(
                              width: 102,
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await httpClient.removeTask(widget.taskId);
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  widget.updateState();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffE31F1F)
                                ),
                                child: Text(
                                  "Delete",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white
                                  ),
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
            );
          });
        });
  }

  Future<void> _dialogBuilder(
      BuildContext context, String title, List<dynamic> feedback) {
    List<int> subtaskId = [];
    List<dynamic> enabledValues = [];
    List<bool> cantYouSee = [];

    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            List<Widget> taskContent = [];

            for (int i = 0; i < widget.subtasks.length; i++) {
              enabledValues.add(widget.subtasks[i][3]);
              cantYouSee.add(widget.subtasks[i][3]);

              taskContent.add(Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Color(0xffD4D4D4)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width < 370 ? 100 :185,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width < 370 ? 80 :130,
                            child: Text(
                              widget.subtasks[i][0],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: MediaQuery.of(context).size.width < 370 ? 10 :14,
                                  color: const Color(0xff2E2323)),
                            ),
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
                          child: StatefulBuilder(builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                state(
                                      () {
                                    if (cantYouSee[i] == false) {
                                      enabledValues[i] = !enabledValues[i];
                                    }

                                    widget.subtasks[i][3] = enabledValues[i];

                                    if (enabledValues[i]) {
                                      setState(() {
                                        subtaskId.add(widget.subtasks[i][1]);
                                      });
                                    } else {
                                      setState(() {
                                        subtaskId.remove(widget.subtasks[i][1]);
                                      });
                                    }
                                  },
                                );
                              },
                              child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: !cantYouSee[i] == false
                                          ? Colors.transparent
                                          : enabledValues[i]
                                          ? const Color(0xff355CCA)
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: !cantYouSee[i] == false
                                              ? const Color(0xffAAC4FF)
                                              : const Color(0xffAAC4FF))),
                                  child: Icon(
                                    Icons.check,
                                    size: 18,
                                    color: !cantYouSee[i] == false
                                        ? const Color(0xffAAC4FF)
                                        : enabledValues[i]
                                        ? Colors.white
                                        : Colors.transparent,
                                  )),
                            );
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ));
            }
            return AlertDialog(
              scrollable: true,
              backgroundColor: Colors.white,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: SvgPicture.asset(
                                "assets/Vector.svg",
                                height: 25,
                                width: 25,
                                // color: Colors.black,
                              ),
                            ),
                            SizedBox(
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
                          child: _getUpdateCloseButton(
                              context, () {}),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                "assets/Rectangle.svg",
                                height: 12,
                                width: 12,
                                // color: Colors.black,
                              ),
                            ),
                            SizedBox(
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
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                              child: SvgPicture.asset(
                                "assets/Circle.svg",
                                height: 12,
                                width: 12,
                                // color: Colors.black,
                              ),
                            ),
                            SizedBox(
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
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: const ImageIcon(
                                    AssetImage("assets/MyPoints.png"),
                                    color: Color(0xff3A3D4C),
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
                                Text(
                                  "     ${(currentPoint.toString().split(".")[1] == "0" ? currentPoint.toInt() : currentPoint).toString()} ${MediaQuery.of(context).size.width < 370 ? "": "points"}",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: const Color(0xff3a3d4c)),
                                )
                              ],
                            ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          30, 10, 30, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Duration",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color:
                                                const Color(0xff3A3D4C)),
                                          ),
                                          Text(
                                            "Points",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color:
                                                const Color(0xff3A3D4C)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: points.map<Widget>((e) {
                                        return Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                e["taskSpentWeek"] ?? "Hello",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              ),
                                              Text(
                                                "${e["point"]} point",
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xff3A3D4C)),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                                    width: double.infinity,
                                    height: 70,
                                    child: Stack(
                                      children: <Widget> [
                                        Align(
                                          alignment: const AlignmentDirectional(0, 0),
                                          child: Container(
                                            height: 10,
                                            width: double.infinity,
                                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                gradient: const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  stops: [
                                                    0,
                                                    0.25,
                                                    0.25,
                                                    0.5,
                                                    0.5,
                                                    0.75,
                                                    0.75,
                                                    1
                                                  ],
                                                  colors: [
                                                    Color(0xFFCEE5D0),
                                                    Color(0xFFCEE5D0),
                                                    Color(0xFFFFF89A),
                                                    Color(0xFFFFF89A),
                                                    Color(0xFFFEBE8F),
                                                    Color(0xFFFEBE8F),
                                                    Color(0xFFFE8F8F),
                                                    Color(0xFFFE8F8F),
                                                  ],
                                                )),
                                          ),
                                        ),

                                        Align(
                                          alignment: AlignmentDirectional((currentDay * 2 - 60) / 60, 0),
                                          child: Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                                color: Colors.purple.shade200,
                                                shape: BoxShape.circle),
                                          ),
                                        ),

                                        Align(
                                          alignment: AlignmentDirectional((currentDay * 2 - 60) / 60, 1),
                                          child: Text(
                                            "${currentPoint.toString()} point",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: const Color(0xff3A3D4C)),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional((currentDay * 2 - 60) / 60, 0.5),
                                          child: Text(
                                            "${currentDay.toString()} days",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color:
                                                const Color(0xff3A3D4C)),
                                          ),
                                        ),
                                      ],
                                    )
                                ),

                                // Align(
                                //   alg
                                //   child: Container(
                                //     width: double.infinity,
                                //     margin:
                                //         const EdgeInsets.fromLTRB(15, 0, 15, 5),
                                //     child: Transform(
                                //       transform: Matrix4.translationValues(
                                //           currentDay.toDouble(), 0, 0.0),
                                //       child: Column(
                                //         children: [
                                //           Text(
                                //             "${currentPoint.toString()} point",
                                //             style: GoogleFonts.montserrat(
                                //                 fontWeight: FontWeight.w500,
                                //                 fontSize: 12,
                                //                 color:
                                //                     const Color(0xff3A3D4C)),
                                //           ),
                                //           Text(
                                //             "${currentDay.toString()} days",
                                //             style: GoogleFonts.montserrat(
                                //                 fontWeight: FontWeight.w500,
                                //                 fontSize: 12,
                                //                 color:
                                //                     const Color(0xff3A3D4C)),
                                //           )
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // )
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
                                const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: const ImageIcon(
                                  AssetImage("assets/Subtask.png"),
                                  color: Color(0xff3A3D4C),
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
                                height: 150,
                                alignment: Alignment.centerLeft,
                                margin:
                                const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: taskContent,
                                  ),
                                )),
                            Container(
                              margin:
                              const EdgeInsets.fromLTRB(16, 10, 16, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
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
                                    margin:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color(0xff355CCA),
                                        shadowColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: !(cantYouSee.every(
                                              (element) => element == true))
                                          ? subtaskId.isNotEmpty
                                          ? () async {
                                        for (var id in subtaskId) {
                                          await httpClient
                                              .doneSubtask(
                                              id, true);
                                        }
                                        getAllTasks();
                                        widget.updateState();

                                        if (!mounted) return;
                                        Navigator.pop(context);
                                      }
                                          : null
                                          : null,
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
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _putFeedback(context, widget.taskId,
                                widget.description, feedback);
                          },
                          child: Text(
                            "Leave your feedback",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: const Color(0xff355CCA),
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                )
              ],
            );
          });
        });
  }

  Future<void> _putFeedback(BuildContext context, int taskId,
      String description, List<dynamic> feedback) {
    List<dynamic> feed = [];

    httpClient.getAllFeedbacks(taskId).then((val) async {
      feed = val;
    });

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController answer = TextEditingController();

          return StatefulBuilder(builder: (context, state) {
            String text = "${answer.text.split(" ").length}/1000";

            httpClient.getAllFeedbacks(taskId).then((val) async {
              state(() {
                feed = val;
              });
            });

            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      "You can leave your feedback here!",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xff2E2323)),
                    ),
                  ),
                  Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: "Submissions may not be altered",
                    child: SvgPicture.asset(
                      "assets/Tooltip.svg",
                      width: 18,
                      height: 18,
                    ),
                  )
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                              title: Text(
                                "My feedback history",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xff646464)),
                              ),
                              children: [
                                SizedBox(
                                    height: 50,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: feed.map<Widget>((e) {
                                          return Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                border: Border.all(
                                                    width: 1.5,
                                                    color: const Color(
                                                        0xff3A3D4C))),
                                            margin: const EdgeInsets.fromLTRB(
                                                13, 2, 13, 2),
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 7, 5, 7),
                                            child: Text(
                                              e["feedback"],
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                  color:
                                                  const Color(0xff3A3D4C)),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ))
                              ]),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                          height: 160,
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                text = "${value.length}/160";
                              });
                            },
                            controller: answer,
                            expands: false,
                            maxLines: 8,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: const Color(0xff646464)),
                            decoration: InputDecoration(
                              hintText:
                              "Type about your activites or work experiance",
                              hintStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  color: const Color(0xff646464)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffD2DAFF), width: 1.5)),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffD2DAFF), width: 1.5)),
                              focusColor: const Color(0xffD2DAFF),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xffD2DAFF))),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 7, 0, 0),
                          alignment: Alignment.centerRight,
                          child: Text(text,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xffAAC4FF))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 104,
                          height: 36,
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

                              widget.updateState();
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
                        SizedBox(
                          width: 104,
                          height: 36,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff355CCA),
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: answer.text.isNotEmpty
                                ? () {
                              var httpClient = Client();

                              httpClient.sendEssay(answer.text, taskId);
                              widget.updateState();


                              Navigator.pop(context);
                              // widget.updateState();
                            }
                                : null,
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
            );
          });
        });
  }
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
            size: 18.5,
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
