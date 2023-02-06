import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';
import 'package:sis_progress/data%20class/registration_data_grade9.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/grades/grade_9th_second.dart';
import 'package:sis_progress/widgets/radio_button.dart';
import '../../widgets/drawers/app_bar.dart';
import '../../widgets/progress/progress_bar.dart';
import '../../widgets/progress/radio_button_group.dart';

class Grade9thFirst extends StatefulWidget {
  // String term = "Start term";
  // String plan = "Early Desicion";
  // String score = "Yes";
  // String legacy = "Yes";

  final RegistrationGrade9 registration;
  final RadioButtonHandler term = RadioButtonHandler(value: "Start term");
  final RadioButtonHandler plan = RadioButtonHandler(value: "Early Desicion");
  final RadioButtonHandler score = RadioButtonHandler(value: "Yes");
  final RadioButtonHandler legacy = RadioButtonHandler(value: "Yes");

  Grade9thFirst({required this.registration, super.key});

  @override
  State<StatefulWidget> createState() => _Grade9thFirst();
}

class _Grade9thFirst extends State<Grade9thFirst> {
  List<String> terms = ["Fall 2023", "Fall 2024", "Fall 2025", "Fall 2026"];
  List<String> plans = ["Early Desicion", "Regular Desicion"];
  List<String> scores = ["Yes", "No"];
  List<String> legacys = ["Yes", "No"];
  String term = "Start term";
  String plan = "Early Desicion";
  String score = "Yes";
  String legacy = "Yes";

  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  // late SingleValueDropDownController _cnt;

  Client httpClient = Client();

  String universityErrorText = "";
  String studyErrorText = "";
  String academicErrorText = "";

  bool showuniversityErrorText = false;
  bool showstudyErrorText = false;
  bool showacademicErrorText = false;

  late List<String> uni;

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
    _controller4 = TextEditingController();
    // _cnt = SingleValueDropDownController();
    super.initState();
  }

  final GlobalKey _menuKey = GlobalKey<PopupMenuButtonState>();

  // void changeTerms(String? item) {
  //   setState(() {
  //     term = item ?? '';
  //   });
  // }

  // void changePlan(String? item) {
  //   setState(() {
  //     plan = item ?? '';
  //   });
  // }

  // void changeScore(String? item) {
  //   setState(() {
  //     score = item ?? '';
  //   });
  // }

  // void changeLegacy(String? item) {
  //   setState(() {
  //     legacy = item ?? '';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        decoration: BoxDecoration(
            color: const Color(0xff3A3D4C),
            borderRadius: BorderRadius.circular(5)),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const ProgressBar(isPassed: [true, false, false]),
              buildTitle(),
              buildQuestion("1. Pick your dream university"),
              buildMode(_controller1, Universities().universities, "University", showuniversityErrorText, universityErrorText),
              buildQuestion("2. What academic at college Choose the interests you?",),
              buildMode(_controller3, Universities().academics, "Profession", showacademicErrorText, academicErrorText),
              buildQuestion("3. Which field of study interests you?"),
              buildMode(_controller4, Universities().subjects, "Study", showstudyErrorText, studyErrorText),
              // buildMode(_controller2, , lableText),
              // CustomRadio(value: term, groupValue: terms),
              buildQuestion("4. Choose the filed of study."),
              // buildAnswer(changeTerms, terms, term),
              CustomRadioGroup(
                handler: widget.term,
                groupValue: terms,
                methodParent: () => print("Hello"),
              ),
              buildQuestion("5. Preferred admission plan."),
              // buildAnswer(changePlan, plans, plan),
              CustomRadio(
                handler: widget.plan,
                groupValue: plans,
                methodParent: () => print("Hello"),
              ),
              buildQuestion(
                  "6. Do you intend to pursue need-based Financial Aid?"),
              // buildAnswer(changeScore, scores, score),
              CustomRadio(
                  handler: widget.score,
                  groupValue: scores,
                  methodParent: () => print("Hello")),
              buildQuestion("7. Are you a legacy?"),
              // buildAnswer(changeLegacy, legacys, legacy),
              CustomRadio(
                  handler: widget.legacy,
                  groupValue: legacys,
                  methodParent: () => print("Hello")),

              Container(
                padding: const EdgeInsets.fromLTRB(0, 27, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: TextButton.icon(
                        // <-- TextButton
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/previous.png"),
                          size: 14,
                          color: Color(0xffBFBFBF),
                        ),
                        label: Text(
                          'Previous',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color(0xffBFBFBF)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff36519D)),
                        child: Text(
                          "Next",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString("university", _controller1.text);

                          widget.registration.university = _controller1.text;
                          widget.registration.school = _controller2.text;
                          widget.registration.proffession = _controller3.text;
                          widget.registration.term = widget.term.value;
                          widget.registration.addmision = widget.plan.value;
                          widget.registration.aid = widget.score.value;
                          widget.registration.legacy = widget.legacy.value;
                          if(_controller1.text == "University") {
                            setState(() {
                              showuniversityErrorText= true;
                              universityErrorText = "Please select your university";
                            });
                          } else {
                            setState(() {
                              showuniversityErrorText= false;
                            });
                          }

                          if(_controller3.text == "Profession") {
                            setState(() {
                              showacademicErrorText= true;
                              academicErrorText = "Please select your academic program";
                            });
                          } else {
                            setState(() {
                              showacademicErrorText= false;
                            });
                          }

                          if(_controller4.text == "Study") {
                            setState(() {
                              showstudyErrorText = true;
                              studyErrorText = "Please select your study";
                            });
                          } else {
                            setState(() {
                              showstudyErrorText = false;
                            });
                          }
              
                          if(!(showstudyErrorText && showacademicErrorText && showuniversityErrorText)) {
                             await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Grade9thSecond(
                                        registration: widget.registration,
                                      )));
                          }

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Grade9thSecond(
                          //               registration: widget.registration,
                          //             )));
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
            color: Colors.white),
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
          fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white),
    ),
  );
}

Container buildMode(
    TextEditingController controller,
    List<String> items,
    String lableText, bool? showValidationOrNo, String errorText) {
  controller.text = lableText;
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
          // labelText: lableText,
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