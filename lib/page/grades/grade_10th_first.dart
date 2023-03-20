import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/widgets/radio_button.dart';
import '../../data class/registration_data_grade10.dart';
import '../../widgets/drawers/app_bar.dart';
import '../../widgets/progress/progress_bar.dart';
import '../../widgets/progress/radio_button_group.dart';
import 'grade_10th_second.dart';

class Grade10thFirst extends StatefulWidget {
  final RegistrationGrade10 registration;
  final String? university;
  final String? academicProgram;
  final String? study;
  final RadioButtonHandler term = RadioButtonHandler(value: null);
  final RadioButtonHandler plan = RadioButtonHandler(value: null);
  final RadioButtonHandler score = RadioButtonHandler(value: null);
  final RadioButtonHandler legacy = RadioButtonHandler(value: null);

  final dynamic _controller1 = TextEditingController();
  final dynamic _controller3 = TextEditingController();
  final dynamic _controller4 = TextEditingController();

  Grade10thFirst({
    required this.registration,
    this.university,
    this.academicProgram,
    this.study,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Grade10thFirst();

}

class _Grade10thFirst extends State<Grade10thFirst> {
  List<String> terms = ["Fall 2024", "Fall 2025", "Fall 2026", "Fall 2027"];
  List<String> plans = ["Early Decision", "Regular Decision"];
  List<String> scores = ["Yes", "No"];
  List<String> legacys = ["Yes", "No"];



  String universityErrorText = "";
  String studyErrorText = "";
  String academicErrorText = "";

  bool showuniversityErrorText = false;
  bool showstudyErrorText = false;
  bool showacademicErrorText = false;
  List<String> planErrorMessage = [];
  List<String> aidErrorMessage = [];
  List<String> legacyErrorMessage = [];
  List<String> termErrorMessage = [];

  @override
  void initState() {
    if(widget.university != null) {
      widget._controller1.text = widget.university;
    }

    if(widget.study != null) {
      widget._controller3.text = widget.study;
    }

    if(widget.academicProgram != null) {
      widget._controller4.text = widget.academicProgram;
    }

    if(widget.registration.legacy != null) {
      widget.legacy.value = widget.registration.legacy;
    }

    if(widget.registration.addmision != null) {
      widget.plan.value = widget.registration.addmision;
    }

    if(widget.registration.aid != null) {
      widget.score.value = widget.registration.aid;
    }

    if(widget.registration.term != null) {
      widget.term.value = widget.registration.term;
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xff3A3D4C),
          borderRadius: BorderRadius.circular(5)
        ),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 25),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              const ProgressBar(isPassed: [true, false, false]),
              buildTitle(),
              buildQuestion("1. Pick your dream university"),
              buildMode(widget._controller1, Universities().universities, "University", showuniversityErrorText, universityErrorText),
              buildQuestion("2. Choose the academic program."),
              buildMode(widget._controller3, Universities().academics, "Profession", showacademicErrorText, academicErrorText),
              buildQuestion("3. Which field of study interests you?"),
              buildMode(widget._controller4, Universities().subjects, "Study", showstudyErrorText, studyErrorText),
              // CustomRadio(value: term, groupValue: terms),
              buildQuestion("4. Preferred Start term options."),
              // buildAnswer(changeTerms, terms, term),
              CustomRadioGroup(
                handler: widget.term,
                groupValue: terms,
                methodParent: () => debugPrint("Hello"),
                value: widget.term.value,
                errors: termErrorMessage,
              ),
              buildQuestion("5. Preferred admission plan."),
              // buildAnswer(changePlan, plans, plan),
              CustomRadio(handler: widget.plan, groupValue: plans, methodParent: () => debugPrint("Hello"), value: widget.plan.value, errors: planErrorMessage,),
              buildQuestion("6. Do you intend to pursue need-based Financial Aid?"),
              // buildAnswer(changeScore, scores, score),
              CustomRadio(handler: widget.score, groupValue: scores, methodParent: () => debugPrint("Hello"), value: widget.score.value, errors: aidErrorMessage,),
              buildQuestion("7. Are you a legacy?"),
              // buildAnswer(changeLegacy, legacys, legacy),
              CustomRadio(handler: widget.legacy, groupValue: legacys, methodParent: () => debugPrint("Hello"), value: widget.legacy.value, errors: legacyErrorMessage,),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 27, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: TextButton.icon(     // <-- TextButton
                        onPressed: () {
                          widget.registration.term = widget.term.value;
                          widget.registration.addmision = widget.plan.value;
                          widget.registration.aid = widget.score.value;
                          widget.registration.legacy = widget.legacy.value;
                          widget.registration.university = widget._controller1.text;
                          widget.registration.study = widget._controller4.text;
                          widget.registration.profession = widget. _controller3.text;

                          Navigator.pop(context);
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/previous.png"),
                          size: 14,
                          color:Color(0xffBFBFBF),
                        ),
                        label: Text(
                          'Previous',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: const Color(0xffBFBFBF)
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff36519D)
                        ),
                        child: Text(
                          "Next",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                          ),
                        ),
                        onPressed: () async {
                          widget.registration.term = widget.term.value;
                          widget.registration.addmision = widget.plan.value;
                          widget.registration.aid = widget.score.value;
                          widget.registration.legacy = widget.legacy.value;
                          widget.registration.university = widget._controller1.text;
                          widget.registration.study = widget._controller4.text;
                          widget.registration.profession = widget. _controller3.text;

                          setState(() {
                            planErrorMessage = [];
                            aidErrorMessage = [];
                            legacyErrorMessage = [];
                            termErrorMessage = [];
                          });

                          if(widget.plan.value == null) {
                            setState(() {
                              planErrorMessage.add("Please select your addmision plan");
                            });
                          }

                          if(widget.term.value == null) {
                            setState(() {
                              termErrorMessage.add("Please select your start term");
                            });
                          }

                          if(widget.score.value == null) {
                            setState(() {
                              aidErrorMessage.add("Please select your financial aid");
                            });
                          }

                          if(widget.legacy.value == null) {
                            setState(() {
                              legacyErrorMessage.add("Please select your legacy");
                            });
                          }

                          if(widget._controller1.text == "") {
                            setState(() {
                              showuniversityErrorText= true;
                              universityErrorText = "Please select your university";
                            });
                          } else {
                            setState(() {
                              academicErrorText = "";
                              showuniversityErrorText= false;
                            });
                          }

                          if(widget._controller3.text == "") {
                            setState(() {
                              showacademicErrorText= true;
                              academicErrorText = "Please select your academic program";
                            });
                          } else {
                            setState(() {
                              showacademicErrorText= false;
                              academicErrorText = "";
                            });
                          }

                          if(widget._controller4.text == "") {
                            setState(() {
                              showstudyErrorText = true;
                              studyErrorText = "Please select your study";
                            });
                          } else {
                            setState(() {
                              showstudyErrorText = false;
                              studyErrorText = "";
                            });
                          }
              
                          if((showstudyErrorText == false) && (showacademicErrorText == false) && (showuniversityErrorText == false) && aidErrorMessage.isEmpty && legacyErrorMessage.isEmpty && termErrorMessage.isEmpty && planErrorMessage.isEmpty) {
                            if(!mounted) return;
                            Navigator.push(context,  MaterialPageRoute(builder: (context) => Grade10thSecond(reg: widget.registration,)));
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ); 
  }
}


Image buildLogoIcon() {
  return Image.asset(
    "assets/logo.png",
  );
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Start Your Journey Today",
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


Container buildQuestion(String question) {
  return Container(
    margin: const EdgeInsets.fromLTRB(19, 20, 0, 0),
    alignment: Alignment.centerLeft,
    child: Text(
      question,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.white
      ),
    ),
  );
}

Container buildMode(
    TextEditingController controller,
    List<String> items,
    String lableText, bool? showValidationOrNo, String errorText) {
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
          // hintText: widget.hintText,
          errorText: showValidationOrNo ?? false ? errorText: null,
          errorStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: const Color(0xffE31F1F)
          ),
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