import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';
import 'package:sis_progress/data%20class/registration_data_grade9.dart';
import 'package:sis_progress/page/grades/grade_9th_second.dart';
import 'package:sis_progress/widgets/radio_button.dart';
import '../../widgets/drawers/app_bar.dart';
import '../../widgets/progress/progress_bar.dart';

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

  Grade9thFirst({
    required this.registration,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Grade9thFirst();

}

class _Grade9thFirst extends State<Grade9thFirst> {
  List<String> terms = ["Start term", "Mandatory"];
  List<String> plans = ["Early Desicion", "Regular Desicion"];
  List<String> scores = ["Yes", "No"];
  List<String> legacys = ["Yes", "No"];
  String term = "Start term";
  String plan = "Early Desicion";
  String score = "Yes";
  String legacy = "Yes";

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
          borderRadius: BorderRadius.circular(5)
        ),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              const ProgressBar(isPassed: [true, false, false]),
              buildTitle(),
              // CustomRadio(value: term, groupValue: terms),
              buildQuestion("1. Preferred start term (mandatory)"),
              // buildAnswer(changeTerms, terms, term),
              CustomRadio(handler: widget.term, groupValue: terms, methodParent: () => print("Hello")),
              buildQuestion("2. Preferred admission plan."),
              // buildAnswer(changePlan, plans, plan),
              CustomRadio(handler: widget.plan, groupValue: plans, methodParent: () => print("Hello"),),
              buildQuestion("3. Do you instead to pursue need-based finanial AID?"),
              // buildAnswer(changeScore, scores, score),
              CustomRadio(handler: widget.score, groupValue: scores, methodParent: () => print("Hello")),
              buildQuestion("4. Are you a legacy?"),
              // buildAnswer(changeLegacy, legacys, legacy),
              CustomRadio(handler: widget.legacy, groupValue: legacys, methodParent: () => print("Hello")),
            
              Container(
                padding: const EdgeInsets.fromLTRB(0, 27, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: TextButton.icon(     // <-- TextButton
                        onPressed: () {
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
                        onPressed: () {
                          widget.registration.term = widget.term.value;
                          widget.registration.addmision = widget.plan.value;
                          widget.registration.aid = widget.score.value;
                          widget.registration.legacy = widget.legacy.value;
              
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => Grade9thSecond(registration: widget.registration,)));
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
        "Registration for admission",
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

