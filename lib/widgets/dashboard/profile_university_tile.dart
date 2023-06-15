import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/registration_data_class.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/acativity_to_map.dart';
import 'package:sis_progress/widgets/drop_down_field.dart';
// import 'package:sis_progress/widgets/input_box.dart';

typedef University = List<String>;
typedef FirstAcademic = String?;
typedef SecondAcademic = String?;
typedef ThirdAcademic = String?;
typedef FourthAcademic = String?;

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
  final FirstAcademic firstAcademic;
  final SecondAcademic secondAcademic;
  final ThirdAcademic thirdAcademic;
  final ThirdAcademic fourthAcademic;

  // List<String> academics = [];
  // var columbiaFaculty;
  // var pensylvaniaFaculty;
  // var pensylvaniaSecond;
  // var pensylvaniaThird;
  // var pensylvaniaFourth;

  const UniversityTile(
      {required this.points,
      required this.university,
      required this.onSave,
      required this.onEdit,
      required this.mode,
      required this.fourthAcademic,
      required this.selectedUniversity,
      required this.firstAcademic,
      required this.secondAcademic,
      required this.thirdAcademic,
      required this.dreamPoint,
      required this.safetyPoint,
      required this.targetPoint,
      super.key});

  @override
  State<StatefulWidget> createState() => _UniversityTile();
}

class _UniversityTile extends State<UniversityTile> {
  late TextEditingController dreamPointCont = TextEditingController(
      text:
          '${widget.points[widget.university.indexOf(widget.selectedUniversity)][0]}');
  late TextEditingController targetPointCont = TextEditingController(
      text:
          '${widget.points[widget.university.indexOf(widget.selectedUniversity)][1]}');
  late TextEditingController safetyPointCont = TextEditingController(
      text:
          '${widget.points[widget.university.indexOf(widget.selectedUniversity)][2]}');

  var httpClient = Client();

  var uniDataClass = RegistrationDataClass();
  dynamic questions = [];

  List<String> academics = [];
  var columbiaFaculty;
  var pensylvaniaFaculty;
  var pensylvaniaSecond;
  var pensylvaniaThird;
  var pensylvaniaFourth;
  var university;
  var showAcademic = true;

  @override
  void initState() {

    super.initState();
  }

  int value = 0;

  bool isChangeButtonDisabled() {
    if(widget.selectedUniversity == university) {
      if(widget.selectedUniversity == "Columbia University") {
        if(widget.secondAcademic == getValueAt(academics, 0) && widget.thirdAcademic == getValueAt(academics, 1) && columbiaFaculty == widget.firstAcademic) {
          return true;
        } else {
          return false;
        }
      }

      if(widget.selectedUniversity != "Columbia University" && widget.selectedUniversity != "University of Pennsylvania") {
        if(widget.firstAcademic == getValueAt(academics, 0)) return true;
        if(widget.secondAcademic == getValueAt(academics, 1)) return true;
        if(widget.thirdAcademic == getValueAt(academics, 0)) return true;

        return false;

      }
    }

    return false;
  }

  bool disabled = true;

  @override
  Widget build(BuildContext context) {
    disabled = isChangeButtonDisabled();
    university = widget.selectedUniversity;

    if(widget.selectedUniversity == "Columbia University") {
      columbiaFaculty = widget.firstAcademic;

      if(widget.secondAcademic != "null") {
        academics.add(widget.secondAcademic!);
      }

      if(widget.thirdAcademic != "null") {
        academics.add(widget.thirdAcademic!);
      }

      if(widget.fourthAcademic != "null") {
        academics.add(widget.fourthAcademic!);
      }
    } else if(widget.selectedUniversity == "University of Pennsylvania") {
      pensylvaniaFaculty = widget.firstAcademic;
      pensylvaniaSecond = widget.secondAcademic;
      pensylvaniaThird = widget.thirdAcademic;
      pensylvaniaFourth = widget.fourthAcademic;
    } else {
      if(widget.firstAcademic != "null") {
        academics.add(widget.firstAcademic!);
      }

      if(widget.secondAcademic != "null") {
        academics.add(widget.secondAcademic!);
      }

      if(widget.thirdAcademic != "null") {
        academics.add(widget.thirdAcademic!);
      }
    }
    // if (widget.selectedUniversity == "Columbia University") {
    //   _controller1.text = widget.selectedUniversity;
    //   if (widget.firstAcademic != "null") {
    //     _controller4.text = widget.firstAcademic!;
    //   }
    //   if (widget.secondAcademic != "null") {
    //     _controller5.text = widget.secondAcademic!;
    //   }
    //   if (widget.thirdAcademic != "null") {
    //     _controller6.text = widget.thirdAcademic!;
    //   }
    //   if(widget.fourthAcademic != "null") {
    //     _controller7.text = widget.fourthAcademic!;
    //   }
    // } else if (widget.selectedUniversity == "University of Pennsylvania") {
    //   _controller1.text = widget.selectedUniversity;
    //   if (widget.firstAcademic != "null") {
    //     _controller5.text = widget.firstAcademic!;
    //   }
    //   if (widget.secondAcademic != "null") {
    //     _controller3.text = widget.secondAcademic!;
    //   }
    //   if (widget.thirdAcademic != "null") {
    //     _controller4.text = widget.thirdAcademic!;
    //   }
    // } else {
    //   _controller1.text = widget.selectedUniversity;
    //
    //   if (widget.firstAcademic != "null") {
    //     _controller4.text = widget.firstAcademic!;
    //   } else {
    //     _controller4.text = "";
    //   }
    //   if (widget.secondAcademic != "null") {
    //     _controller3.text = widget.secondAcademic!;
    //   } else {
    //     _controller3.text = "";
    //   }
    //   if (widget.thirdAcademic != "null") {
    //     _controller5.text = widget.thirdAcademic!;
    //   } else {
    //     _controller5.text = "";
    //   }
    // }
    //
    // questions =
    //     uniDataClass.getQuestionsAndAnswers(widget.selectedUniversity);

    return StatefulBuilder(builder: (context, state) {
      disabled = isChangeButtonDisabled();
      return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (widget.mode == true) {
            widget.onSave();
          }
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
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
                          "Academic profile",
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

                  Container(
                    width: double.infinity,
                    margin: widget.mode
                        ? const EdgeInsets.fromLTRB(23, 10, 0, 3)
                        : const EdgeInsets.fromLTRB(23, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget.mode
                            ? Container(
                          margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                          child: RichText(
                            text: TextSpan(
                              text: dreamPointCont.text,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: const Color(0xffD4D4D4)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' (Dream Points)',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: const Color(0xffD2DAFF))),
                              ],
                            ),
                          ),
                        )
                            : Container(),
                        widget.mode
                            ? Container(
                          margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                          child: RichText(
                            text: TextSpan(
                              text: targetPointCont.text,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: const Color(0xffD4D4D4)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' (Target Points)',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: const Color(0xffD2DAFF))),
                              ],
                            ),
                          ),
                        )
                            : Container(),
                        widget.mode
                            ? Container(
                          margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                          child: RichText(
                            text: TextSpan(
                              text: safetyPointCont.text,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: const Color(0xffD4D4D4)),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' (Safety Points)',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: const Color(0xffD2DAFF))),
                              ],
                            ),
                          ),
                        )
                            : Container()
                      ],
                    ),
                  ),

                  // widget.mode ? buildMode(_controller1, uniDataClass.getAllUniversities(),
                  //     "University", null, "Hello", (val) {
                  //   state(() {
                  //     questions = uniDataClass.getQuestionsAndAnswers(val);
                  //     _controller3.text = "";
                  //     _controller5.text = "";
                  //     _controller4.text = "";
                  //   });
                  // }): Container(),
                  //
                  // widget.mode ? questions.isNotEmpty
                  //     ? Column(
                  //         children: [
                  //           _controller1.text == "University of Pennsylvania" ? buildQuestion(uniDataClass.getPennsylvaniaUniversityQuestion(), true) : buildQuestion(questions[0][0], true),
                  //           _controller1.text == "University of Pennsylvania" ? buildMode(_controller5, uniDataClass.getPennsylvaniaUniversityFaculties(), "Academic", false, "Hello", (p0) {state(() {_controller3.text = "";}); debugPrint(p0);}) : buildMode(_controller4, questions[1][0].keys.toList(), "Academic", false, "Hello", (p0) {state(() { _controller3.text = ""; _controller6.text= "";});}),
                  //           _controller1.text == "Columbia University" || _controller1.text == "University of Pennsylvania" ? Container() : buildQuestion(questions[0][1], false),
                  //           _controller1.text == "Columbia University" || _controller1.text == "University of Pennsylvania" ? Container() : buildMode(_controller3, uniDataClass.removeDuplicates(questions[1][1].keys.toList(), [_controller4.text]), "Academic", false, "Hello", (p0) {state(() {});}),
                  //           _controller4.text != "" && _controller1.text == "Columbia University" ? buildQuestion("First Intended Area of Study", true): Container(),
                  //           _controller4.text != "" && _controller1.text == "Columbia University" ? buildMode(_controller5, uniDataClass.getColumbiaValues(_controller4.text), "Academic", false, "Hello", (p0) {state(() {});}): Container(),
                  //           _controller4.text != "" && _controller1.text == "Columbia University" ? buildQuestion("Second Intended Area of Study", false): Container(),
                  //           _controller4.text != "" && _controller1.text == "Columbia University" ? buildMode(_controller6, uniDataClass.removeDuplicates(uniDataClass.getColumbiaValues(_controller4.text), [_controller5.text]), "Academic", false, "Hello", (p0) {}): Container(),
                  //           _controller4.text != "" && _controller1.text == "Columbia University" ? buildQuestion("Third Intended Area of Study", false): Container(),
                  //           _controller4.text != "" && _controller1.text == "Columbia University" ? buildMode(_controller7, uniDataClass.removeDuplicates(uniDataClass.getColumbiaValues(_controller4.text), [_controller5.text, _controller6.text]), "Academic", false, "Hello", (p0) {}): Container(),
                  //           _controller1.text == "Johns Hopkins University" || _controller1.text == "Princeton University" || _controller1.text == "Columbia University" || _controller1.text == "University of Pennsylvania" ? Container() : buildQuestion(questions[0][2], false),
                  //           _controller1.text == "Johns Hopkins University" || _controller1.text == "Princeton University" || _controller1.text == "Columbia University" || _controller1.text == "University of Pennsylvania" ? Container() : buildMode(_controller5, uniDataClass.removeDuplicates(questions[1][2].keys.toList(), [_controller4.text, _controller3.text]), "Academic", false, "Hello", (p0) {state((){});}),
                  //           _controller1.text == "University of Pennsylvania" && _controller5.text != "" ? buildQuestion("Primary Major of Interest", false): Container(),
                  //           _controller5.text != "" && uniDataClass.getPennsylvaniaUniversitySubfaculties(_controller5.text) != null? buildMode(_controller3, uniDataClass.getPennsylvaniaUniversitySubfaculties(_controller5.text), "Academic", null, "Hello", (p0) {state(() {_controller4.text = "";});}): Container(),
                  //           _controller3.text != "" && uniDataClass.getPennsylvaniaUniversitySubfaculties(_controller3.text) != null? buildQuestion("Secondary School Choice (if not selected for primary program choice)", false): Container(),
                  //           _controller3.text != "" && uniDataClass.getPennsylvaniaUniversitySubfaculties(_controller3.text) != null? buildMode(_controller4, uniDataClass.getPennsylvaniaUniversitySubfaculties(_controller3.text), "Academic", null, "Hello", (p0) {}): Container()
                  //         ],
                  //       )
                  //     : Container(): Container(),

                  if (!widget.mode) Container() else Form(
                      child: Column(
                        children: <Widget> [
                          DropDownField(
                              value: university,
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                }

                                return "Please choose your dream university";
                              },
                              onChange: (value) {
                                state(() {
                                  university = value;
                                  disabled = isChangeButtonDisabled();

                                  showAcademic = true;
                                  academics.clear();
                                  pensylvaniaFaculty = null;
                                  pensylvaniaSecond = null;
                                  pensylvaniaThird = null;
                                  pensylvaniaFourth = null;
                                  columbiaFaculty = null;
                                  // print("******" + RegistrationDataClass().universities["university"].keys);
                                });
                              },
                              context: context,
                              initialValue: "Pick your dream university",
                              items: Universities().universities),

                          university.toString().contains("Columbia") ? Column(
                            children: [
                              DropDownField(
                                  value: columbiaFaculty,
                                  validator: (val) {
                                    if(val == null) {
                                      return "Please choose college";
                                    }

                                    return null;
                                  },
                                  onChange: (val) {
                                    state(() {
                                      columbiaFaculty = val;
                                    });
                                  },
                                  context: context,
                                  initialValue: "Academic Program",
                                  items: const [
                                    "Columbia College",
                                    "Columbia Engineering"
                                  ]),
                              Visibility(
                                visible: columbiaFaculty
                                    .toString()
                                    .isNotNullOrEmpty,
                                child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        23, 0, 23, 5),
                                    child: LayoutBuilder(builder:
                                        (BuildContext context,
                                        BoxConstraints constraints) {
                                      return TextFormField(
                                        readOnly: true,
                                        validator: (val) {
                                          if(academics.isEmpty) {
                                            return "Please choose one academic";
                                          }

                                          return null;
                                        },
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          alignLabelWithHint: true,
                                          labelText: academics.isEmpty ? "Academic program": academics.join(", "),
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
                                          enabledBorder:
                                          const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Color(0xffD2DAFF),
                                                  width: 1)),
                                          border: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xffD2DAFF),
                                                  width: 1)),
                                          focusColor: const Color(0xffD2DAFF),
                                          focusedBorder:
                                          const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                  Color(0xff36519D))),
                                          suffixIcon: PopupMenuButton<String>(
                                            color: const Color(0xffD2DAFF),
                                            constraints:
                                            BoxConstraints.expand(
                                                height: 150,
                                                width:
                                                constraints.maxWidth),
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
                                            ),
                                            onSelected: (String value) {
                                              // controller.text = value;
                                            },
                                            itemBuilder:
                                                (BuildContext context) {
                                              return RegistrationDataClass()
                                                  .univer[university]
                                              [columbiaFaculty]
                                                  .keys
                                                  .map<PopupMenuItem<String>>(
                                                      (String value) {
                                                    return PopupMenuItem(
                                                        value: value,
                                                        child: StatefulBuilder(
                                                          builder:
                                                              (context, state) {
                                                            return Row(
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    state(() {
                                                                      // academics.clear();

                                                                      if (academics
                                                                          .contains(
                                                                          value)) {
                                                                        academics
                                                                            .remove(
                                                                            value);
                                                                      } else if (academics
                                                                          .length <
                                                                          RegistrationDataClass().univer[university]
                                                                          [
                                                                          "length"]) {
                                                                        academics.add(
                                                                            value);
                                                                      }

                                                                      // print(academics);
                                                                    });
                                                                  },
                                                                  child:
                                                                  Container(
                                                                    width: 24,
                                                                    height: 24,
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius.circular(
                                                                            5),
                                                                        border: Border.all(
                                                                            width:
                                                                            1.5,
                                                                            color:
                                                                            const Color(0xff355CCA))),
                                                                    child: academics.contains(
                                                                        value)
                                                                        ? const Icon(
                                                                        Icons
                                                                            .check,
                                                                        size:
                                                                        18,
                                                                        color:
                                                                        Color(0xff355CCA))
                                                                        : null,
                                                                  ),
                                                                ),
                                                                Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        left: 10),
                                                                    child: Text(
                                                                        value))
                                                              ],
                                                            );
                                                          },
                                                        ));
                                                  }).toList();
                                            },
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            ],
                          ) : Container(),

                          showAcademic &&
                              !university.toString().contains("Columbia") && !university.toString().contains("Pennsylvania") ? Container(
                              margin: const EdgeInsets.fromLTRB(23, 0, 23, 5),
                              child: LayoutBuilder(builder:
                                  (BuildContext context,
                                  BoxConstraints constraints) {
                                return TextFormField(
                                  readOnly: true,
                                  validator: (val) {
                                    if(academics.isEmpty){
                                      return "Please select one academic";
                                    }

                                    return null;
                                  },
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: academics.isEmpty ? "Academic program": academics.join(", "),
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
                                        borderSide: BorderSide(
                                            color: Color(0xffD2DAFF),
                                            width: 1)),
                                    border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffD2DAFF),
                                            width: 1)),
                                    focusColor: const Color(0xffD2DAFF),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff36519D))),
                                    suffixIcon: PopupMenuButton<String>(
                                      color: const Color(0xffD2DAFF),
                                      constraints: BoxConstraints.expand(
                                          height: 150,
                                          width: constraints.maxWidth),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.grey,
                                      ),
                                      onSelected: (String value) {
                                        // controller.text = value;
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return RegistrationDataClass()
                                            .univer[university]["academics"]
                                            .keys
                                            .map<PopupMenuItem<String>>(
                                                (String value) {
                                              return PopupMenuItem(
                                                  value: value,
                                                  child: StatefulBuilder(
                                                    builder: (context, st) {
                                                      return Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              st(() {
                                                                if (academics
                                                                    .contains(
                                                                    value)) {
                                                                  academics
                                                                      .remove(
                                                                      value);
                                                                } else if (academics
                                                                    .length <
                                                                    RegistrationDataClass()
                                                                        .univer[
                                                                    university]
                                                                    [
                                                                    "length"]) {
                                                                  academics
                                                                      .add(value);
                                                                }
                                                              });

                                                              state(() {

                                                              });
                                                            },
                                                            child: Container(
                                                              width: 24,
                                                              height: 24,
                                                              alignment: Alignment
                                                                  .center,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      5),
                                                                  border: Border.all(
                                                                      width: 1.5,
                                                                      color: const Color(
                                                                          0xff355CCA))),
                                                              child: academics
                                                                  .contains(
                                                                  value)
                                                                  ? const Icon(
                                                                  Icons.check,
                                                                  size: 18,
                                                                  color: Color(
                                                                      0xff355CCA))
                                                                  : null,
                                                            ),
                                                          ),
                                                          Container(
                                                              margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                              child: Text(value))
                                                        ],
                                                      );
                                                    },
                                                  ));
                                            }).toList();
                                      },
                                    ),
                                  ),
                                );
                              })) : Container(),

                          university.toString().contains("Pennsylvania") ? Column(
                            children: [
                              DropDownField(
                                value: pensylvaniaFaculty,
                                validator: (val) {
                                  if(val == null) {
                                    return "Please choose college";
                                  }

                                  return null;
                                },
                                onChange: (val) {
                                  state(() {
                                    pensylvaniaSecond = null;
                                    pensylvaniaThird = null;
                                    pensylvaniaFourth = null;
                                    pensylvaniaFaculty = val;
                                  });
                                },
                                context: context,
                                initialValue: "Academic Program",
                                items: RegistrationDataClass().univer["University of Pennsylvania"].keys.toList(),
                              ),

                              RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null ? !RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty].containsKey("hasMany") && pensylvaniaFaculty != "School of Nursing" ? DropDownField(
                                value: pensylvaniaSecond,
                                validator: (val) {
                                  if(val == null) {
                                    return "Please choose academic";
                                  }

                                  return null;
                                },
                                onChange: (val) {
                                  state(() {
                                    pensylvaniaThird = null;
                                    pensylvaniaFourth = null;
                                    debugPrint(pensylvaniaFaculty.toString());
                                    debugPrint(RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty]["academics"].toString());
                                    pensylvaniaSecond = val;
                                  });
                                },
                                context: context,
                                initialValue: "Academic Program",
                                items: RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null && !RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty].containsKey("hasMany") && pensylvaniaFaculty != "School of Nursing" ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty]["academics"].keys.toList(): [],
                              ) : Container(): Container(),

                              RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty].containsKey("hasMany") && pensylvaniaThird != "School of Nursing" ? DropDownField(
                                  value: pensylvaniaThird,
                                  validator: (val) {
                                    if(val == null) {
                                      "Please choose academic";
                                    }

                                    return null;
                                  },
                                  onChange: (val) {
                                    state(() {
                                      pensylvaniaThird = val;
                                    });
                                  },
                                  context: context,
                                  initialValue: "Academic Program",
                                  items: RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty]["academicLinks"].toList(): []
                              ): Container(): Container(),
                              //
                              pensylvaniaThird.toString() != "null" && pensylvaniaThird != "School of Nursing" ? DropDownField(
                                  value: pensylvaniaFourth,
                                  validator: (val) {
                                    if(val == null) {
                                      return "Please choose academic";
                                    }

                                    return null;
                                  },
                                  onChange: (val) {
                                    state(() {
                                      pensylvaniaFourth = val;
                                    });
                                  },
                                  context: context,
                                  initialValue: "Academic Program",
                                  items: pensylvaniaThird.toString() != "null" && pensylvaniaThird != "School of Nursing" ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaThird]["academics"].keys.toList(): []
                              ): Container()
                            ],
                          ): Container(),
                        ],
                      )
                  ),

                  !widget.mode ? Container(
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
                  ): Container(),

                  !widget.mode ? Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                          child: Text(
                            "Academic",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                          child: Text(
                            widget.firstAcademic!,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ): Container(),

                  widget.mode
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 38,
                              width: 128,
                              margin: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  // _controller1 =
                                  //     TextEditingController(text: widget.selectedUniversity);
                                  university == widget.selectedUniversity;
                                  showAcademic = true;
                                  academics.clear();
                                  pensylvaniaFaculty = null;
                                  pensylvaniaSecond = null;
                                  pensylvaniaThird = null;
                                  pensylvaniaFourth = null;
                                  columbiaFaculty = null;
                                  widget.onSave();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  side: const BorderSide(width: 1.5, color: Color(0xffD2DAFF))
                                ),
                                child: Text(
                                  "Discard",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: const Color(0xffD2DAFF)
                                  )
                                ),
                              ),
                            ),
                            Button(
                                text: "Change",
                                onPressed: () async {
                                  var body = {
                                    "university": university,
                                  };

                                  if(university == "Columbia University") {
                                    body["academicProgramFirst"] = columbiaFaculty;
                                    body["academicProgramSecond"] = getValueAt(academics, 0);
                                    body["academicProgramThird"] = getValueAt(academics, 1);
                                    body["academicProgramFourth"] = getValueAt(academics, 2);
                                  } else if(university == "University of Pennsylvania") {
                                    body["academicProgramFirst"] = pensylvaniaFaculty;
                                    body["academicProgramSecond"] = pensylvaniaSecond;
                                    body["academicProgramThird"] = pensylvaniaThird;
                                    body["academicProgramFourth"] = pensylvaniaFourth;
                                  } else {
                                    body["academicProgramFirst"] = getValueAt(academics, 0);
                                    body["academicProgramSecond"] = getValueAt(academics, 1);
                                    body["academicProgramThird"] = getValueAt(academics, 2);
                                  }



                                  // if(_controller1.text == "Columbia University") {
                                  //   body["academicProgramFirst"] = _controller4.text;
                                  //   body["academicProgramSecond"] = _controller5.text;
                                  //   body["academicProgramThird"] = _controller6.text;
                                  //   body["academicProgramFourth"] = _controller7.text;
                                  // } else if(_controller1.text == "University of Pennsylvania") {
                                  //   body["academicProgramFirst"] = _controller5.text;
                                  //   body["academicProgramSecond"] = _controller3.text;
                                  //   body["academicProgramThird"] = _controller4.text;
                                  // } else {
                                  //   body["academicProgramFirst"] = _controller4.text;
                                  //   if(_controller3.text.isNotNullOrEmpty) {
                                  //     body["academicProgramSecond"] = _controller3.text;
                                  //   }
                                  //
                                  //   if(_controller5.text.isNotNullOrEmpty) {
                                  //     body["academicProgramThird"] = _controller5.text;
                                  //   }
                                  // }

                                  await httpClient
                                      .updateUniversityAndAcademic(body)
                                      .then((value) {
                                    widget.onSave();
                                  });

                                  widget.onSave();
                                  successMessage();
                                },
                                height: 38,
                                width: 128),
                          ],
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  Container buildQuestion(String question, bool isRequired) {
    return Container(
      margin: const EdgeInsets.fromLTRB(19, 20, 0, 0),
      alignment: Alignment.centerLeft,
      child: isRequired ? RichText(
        text: TextSpan(
            text: question,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white
            ),
            children: <TextSpan> [
              TextSpan(
                  text: " *",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white
                  )
              )
            ]
        ),
      ): Text(
          question,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white)
      ),
    );
  }

  void successMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff121623),
            title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Yeah! ",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: const Color(0xff355CCA)),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            "Your university details are changed successfully.",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white))
                  ]),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Button(
                  text: "Ok",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  height: 35,
                  width: 140)
            ],
          );
        });
  }
}

Container buildMode(
    TextEditingController controller,
    List<String> items,
    String lableText,
    bool? showValidationOrNo,
    String errorText,
    Function(String)? onChange) {
  // controller.text = lableText;
  return Container(
    margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
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
          labelText: lableText,
          errorText: showValidationOrNo ?? false ? errorText : null,
          errorStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: const Color(0xffE31F1F)),
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
              if (onChange != null) {
                onChange(value);
              }
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
