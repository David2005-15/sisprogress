import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/event_process.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/custom_button.dart';

class EventTile extends StatelessWidget {
  final String title;
  final EventProccess proccess;
  final String eventDate;
  final String description;
  final List<List<dynamic>> subtasks;
  final List<String> points;
  // final List<bool> passed;


  EventTile({
    required this.eventDate,
    required this.points,
    required this.subtasks,
    required this.description,
    required this.proccess,
    required this.title,
    // required this.passed,
    super.key
  });

  Client httpClient = Client();

  @override
  Widget build(BuildContext context) {


    // bool isVisible = false;


    return InkWell(
      onTap: () {
        _dialogBuiler(context, title);
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 75,
        margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
        decoration: BoxDecoration(
          color: proccess.eventColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                  width: 4,
                  height: 63,
                  decoration: BoxDecoration(
                    color: proccess.leftColor,
                    borderRadius: BorderRadius.circular(7)
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(17, 8, 0, 0),
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: const Color(0xff2E2323)
                        ),
                      ),
                    ),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(17, 0, 5, 8),
                              child: proccess.icon
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: Text(
                                proccess.eventName,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: const Color(0xff2E2323)
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(140, 0, 0, 10),
                          child: Text(
                            eventDate,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Colors.black
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

  Future<void> _showEssay(BuildContext context, String subtaskTitle, String taskName, int taskId, String? description) {
    var essayController = TextEditingController();

    print(description);
    
    if(description != null) {
      essayController.text = description;
    }


    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: taskName,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: const Color(0xff2E2323)
              ),
              children: [
                TextSpan(
                  text: "\n$subtaskTitle",
                  style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: const Color(0xff2E2323)
                ),
                )
              ]
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
                      color: const Color(0xff646464)
                    ),
                    // initialValue: "Type about your activites or work experiance",
                    decoration: InputDecoration(
                      
                      hintText: "Type about your activites or work experiance",
                      hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xff646464)
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
                      ),
                      focusColor: const Color(0xffD2DAFF),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD2DAFF))
                      ),
                    ),
                  ),
                );
                })),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Button(
                      text: "Add", 
                      onPressed: () async {
                        await httpClient.sendEssay(essayController.text, taskId);
                        Navigator.pop(context);
                      }, 
                      height: 34, 
                      width: 86
                    ),
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
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
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
                title.length > 15 ? "${title.substring(0, 15)}..." : title, 
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: const Color(0xff2E2323)
                ),
              ),
            ],
          ),

          actions: <Widget> [
            Container(
              // height: 400,
              width: 350,
              
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                        Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: const Icon(
                                    Icons.rocket_outlined,
                                    color: Color(0xff121623),
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Description',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color:const Color(0xff121623)
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget> [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text(
                                  description,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xff121623)
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: const Icon(
                                    Icons.rocket_outlined,
                                    color: Color(0xff121623),
                                    size: 20,
                                  ),
                                ),
                                Text(
                                  'Subtasks',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color:const Color(0xff121623)
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget> [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: subtasks.map((p0) {
                                    var value = 0;
                                    value += 1;
                       
                        
                                    return Container(
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
                                                  p0[0].length > 15 ? "${p0[0].substring(0, 15)}..." : p0[0],
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: const Color(0xff2E2323)
                                                  ),
                                                ),
                                                                  
                                                Text(
                                                  points[value - 1],
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                    color: const Color(0xff2E2323)
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                            Row(
                                              children: [
                                                StatefulBuilder(builder: ((context, setState) {
                                                  return Container(
                                                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                                    padding: const EdgeInsets.all(0),
                                                    height: 24,
                                                    width: 24,
                                                    child: Checkbox(
                                                      fillColor: MaterialStateProperty.resolveWith(getColor),
                                                      value: p0[3],
                                                      onChanged: ((val) async {
                                                        setState(() {
                                                          p0[3] = val!;
                                                          
                                                        },);
                                                        await httpClient.doneSubtask(p0[1], p0[3]);
                                                      })
                                                    ),
                                                  );
                                                })),

                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: const Color(0xff3A3D4C)
                                                  ),
                                                  onPressed: () {
                                                    print(p0[2]);
                                                    Navigator.pop(context);
                                                    _showEssay(context, p0[0], title, p0[1], p0[2]);
                                                    
                                                  }, 
                                                  child: Text(
                                                    "Edit",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 11
                                                    ),
                                                  )
                                                )
                                              ],
                                            )
                                          // buildCheckbox(iconColor: Colors.blue, onChange: onChange, borderColor: borderColor, backgroundColor: backgroundColor)
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                )
                              )
                            ],
                          ),
                        )
                  ],
                ),
              ),
            )
          ],
        );
      }
    );
  }
}

Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }
