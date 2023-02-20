import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/input_box.dart';

typedef University = List<String>;

class UniversityTile extends StatefulWidget {
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final bool mode;
  final University university;
  final List<List<dynamic>> points;
  final String targetPoint;
  final String dreamPoint;
  final String safetyPoint;
  final String selectedUniversity;
  final String academicProgram;
  final String study;

  const UniversityTile(
      {required this.points,
      required this.university,
      required this.onSave,
      required this.onEdit,
      required this.mode,
      required this.selectedUniversity,
      required this.academicProgram,
      required this.study,
      required this.dreamPoint,
      required this.safetyPoint,
      required this.targetPoint,
      super.key});

  @override
  State<StatefulWidget> createState() => _UniversityTile();
}

class _UniversityTile extends State<UniversityTile> {
  late TextEditingController _controller1 = TextEditingController(text: widget.selectedUniversity);
  late TextEditingController _controller2 = TextEditingController(text: widget.academicProgram);
  late TextEditingController _controller3 = TextEditingController(text: widget.study);
  late TextEditingController dreamPointCont = TextEditingController(text: '${widget.points[0][widget.university.indexOf(widget.selectedUniversity)]} Dream Point'); 
  late TextEditingController targetPointCont = TextEditingController(text: '${widget.points[1][widget.university.indexOf(widget.selectedUniversity)]} Target Point');
  late TextEditingController safetyPointCont = TextEditingController(text: '${widget.points[1][widget.university.indexOf(widget.selectedUniversity)]} Target Point');

  var httpClient = Client();
  // List<String> items = ['Harvard University', 'MIT', 'Standford'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if(widget.mode == true) {
          _controller1 = TextEditingController(text: widget.selectedUniversity);
          _controller2 = TextEditingController(text: widget.academicProgram);
          _controller3 = TextEditingController(text: widget.study);
          widget.onSave();

          
        }
      },
      child: Container(
        // width: double.infinity,
        // height: widget.mode ? 300: 112,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
            ],
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xff272935),
                  Color(0xff121623),
                ])),
    
        child: Wrap(
          children: [
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 13, 0, 0),
                      child: Text(
                        "University choice",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                    widget.mode
                        ? Container()
                        : InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: widget.onEdit,
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(0, 13, 15, 0),
                              child: Text(
                                "Edit",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                            ),
                          )
                  ],
                ),
                widget.mode
                    ? buildMode(
                        _controller1,
                        widget.university,
                        dreamPointCont,
                        targetPointCont,
                        safetyPointCont,
                        widget.points,
                        widget.selectedUniversity, widget.dreamPoint, widget.targetPoint, widget.safetyPoint)
                    : Container(
                        margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                              child: Text(
                                "University",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                              child: Text(
                                widget.selectedUniversity,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                widget.mode
                    ? buildMode2(_controller2, Universities().academics, dreamPointCont,
                        targetPointCont, safetyPointCont, widget.points, widget.academicProgram, null, null, null)
                    : Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                              child: Text(
                                "Academic Programm",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                              child: Text(
                                widget.academicProgram,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      widget.mode
                    ? buildMode2(_controller3, Universities().subjects, dreamPointCont,
                        targetPointCont, safetyPointCont, widget.points, widget.study, null, null, null)
                    : Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 30, 15),
                              child: Text(
                                "Study",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 18, 15),
                              child: Text(
                                widget.study,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                      
                widget.mode
                    ? InputBox(
                        textInputType: TextInputType.number,
                        onChanged: (val) {},
                        context: context,
                        controller: dreamPointCont,
                        isPassword: false,
                        enabled: true,
                      )
                    : Container(),
                widget.mode                     
                    ? InputBox(
                        textInputType: TextInputType.number,
                        onChanged: (val) {},
                        context: context,
                        controller: targetPointCont,
                        isPassword: false,
                        enabled: true,
                      )
                    : Container(),
                widget.mode
                    ? InputBox(
                        textInputType: TextInputType.number,
                        onChanged: (val) {},
                        context: context,
                        controller: safetyPointCont,
                        isPassword: false,
                        enabled: true,
                      )
                    : Container(),
                widget.mode
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Button(
                              text: "Change ",
                              onPressed: () async {
                                // _dialogBuilder(context, widget.onSave, {
                                //   "uni": _controller1.text,
                                //   "target": targetPointCont.text,
                                //   "dream": dreamPointCont.text,
                                //   "safety": safetyPointCont.text
                                // });
    
                                var body = {
                                  "university": _controller1.text,
                                  "academicProgram": _controller2.text,
                                  "study": _controller3.text
                                };
    
                                await httpClient.updateUniversityAndAcademic(body).then((value) {
                                  widget.onSave();
                                });
                                
                                widget.onSave();
                              },
                              height: 38,
                              width: 128
                            ),
                        ],
                      )
                    : Container()
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, VoidCallback onSave,
      Map<String, dynamic> metadata) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff121623),
          title: Text(
            'Are you sure to change your university?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
          ),
          content: Text(
            'After you make a change, the tasks that have been already completed or in progress will not be deleted. ',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white),
          ),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Button(text: "Ok",
                  // onPressed: () {
                  //     onSave();
                  //     Navigator.pop(context);
                  //   }, height: 36, width: 104
                  // ),

                  SizedBox(
                    width: 104,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff355CCA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        prefs.setString(
                            "university", metadata["uni"].toString());
                        onSave();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 104,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                  color: Color(0xffD2DAFF), width: 2))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                  )

                  //
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     width: 104,
                  //     height: 36,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       border: Border.all(
                  //         width: 2.0,
                  //         color: const Color(0xffD2DAFF),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       "Cancel",
                  //       style: GoogleFonts.poppins(
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 15,
                  //         color: const Color(0xffD2DAFF)
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              // alignment: Alignment.center,
              // child: ButtonBar(
              //   alignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //      TextButton(
              // style: TextButton.styleFrom(
              //   textStyle: Theme.of(context).textTheme.labelLarge,
              // ),
              // child: const Text('Disable'),
              // onPressed: () {
              //   Navigator.of(context).pop();
              // },
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //     b
            //   ),
            //    child: const Text('Enable'),
            //   onPressed: () {

            //     onSave();
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        );
      },
    );
  }
}

Container buildMode(
    TextEditingController controller,
    List<String> items,
    TextEditingController dreamPoint,
    TextEditingController targetPoint,
    TextEditingController safetyPoint,
    List<List<dynamic>> points,
    String lableText,
    String? dreamPoints,
    String? targetPoints,
    String? safetyPoints) {

    print(points);

  // targetPoint.text =
  //                 '${points[1][items.indexOf(controller.text)]} Target Point';
  //             dreamPoint.text =
  //                 '${points[0][items.indexOf(controller.text)]} Dream Point';
  //             safetyPoint.text =
  //                 '${points[2][items.indexOf(controller.text)]} Safety Point';  

  return Container(
    margin: const EdgeInsets.fromLTRB(23, 16, 23, 0),
    child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return TextFormField(
        readOnly: true,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          // hintText: widget.hintText,
          labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              fontStyle: FontStyle.normal,
              color: const Color(0xffD2DAFF)),
          hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              fontStyle: FontStyle.normal,
              color: const Color(0xffD2DAFF)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)),
          focusColor: const Color(0xffD2DAFF),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff36519D))),
          suffixIcon: PopupMenuButton<String>(
            color: const Color(0xffD2DAFF),
            constraints:
                BoxConstraints.expand(height: 150, width: constraints.maxWidth),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xffD2DAFF),
            ),
            onSelected: (String value) {
              controller.text = value;
              targetPoint.text =
                  '${points[1][items.indexOf(controller.text)]} Target Point';
              dreamPoint.text =
                  '${points[0][items.indexOf(controller.text)]} Dream Point';
              safetyPoint.text =
                  '${points[2][items.indexOf(controller.text)]} Safety Point';
            },
            itemBuilder: (BuildContext context) {
              return items.map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: const Color(0xff121623),
                      ),
                    ));
              }).toList();
            },
          ),
        ),
      );
    }),
  );
}

Container buildMode2(
    TextEditingController controller,
    List<String> items,
    TextEditingController dreamPoint,
    TextEditingController targetPoint,
    TextEditingController safetyPoint,
    List<List<dynamic>> points,
    String lableText,
    String? dreamPoints,
    String? targetPoints,
    String? safetyPoints) {

    print(points);

  // targetPoint.text =
  //                 '${points[1][items.indexOf(controller.text)]} Target Point';
  //             dreamPoint.text =
  //                 '${points[0][items.indexOf(controller.text)]} Dream Point';
  //             safetyPoint.text =
  //                 '${points[2][items.indexOf(controller.text)]} Safety Point';  

  return Container(
    margin: const EdgeInsets.fromLTRB(23, 16, 23, 0),
    child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return TextFormField(
        readOnly: true,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          // hintText: widget.hintText,
          labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              fontStyle: FontStyle.normal,
              color: const Color(0xffD2DAFF)),
          hintStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              fontStyle: FontStyle.normal,
              color: const Color(0xffD2DAFF)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)),
          focusColor: const Color(0xffD2DAFF),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff36519D))),
          suffixIcon: PopupMenuButton<String>(
            color: const Color(0xffD2DAFF),
            constraints:
                BoxConstraints.expand(height: 150, width: constraints.maxWidth),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xffD2DAFF),
            ),
            onSelected: (String value) {
              controller.text = value;
              // targetPoint.text =
              //     '${points[1][items.indexOf(controller.text)]} Target Point';
              // dreamPoint.text =
              //     '${points[0][items.indexOf(controller.text)]} Dream Point';
              // safetyPoint.text =
              //     '${points[2][items.indexOf(controller.text)]} Safety Point';
            },
            itemBuilder: (BuildContext context) {
              return items.map<PopupMenuItem<String>>((String value) {
                return PopupMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: const Color(0xff121623),
                      ),
                    ));
              }).toList();
            },
          ),
        ),
      );
    }),
  );
}
