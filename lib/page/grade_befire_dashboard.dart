import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/dashboard/dashboard.dart';
import 'package:sis_progress/page/dashboard/scaffold_keeper.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/progress/radio_button_group.dart';
import 'package:sis_progress/widgets/radio_button.dart';

import '../widgets/drawers/app_bar.dart';

class GradeDashboard extends StatefulWidget {
  GradeDashboard({super.key});

  final RadioButtonHandler plan = RadioButtonHandler(value: null);
  final RadioButtonHandler term = RadioButtonHandler(value: null);
  final RadioButtonHandler score = RadioButtonHandler(value: null);
  final RadioButtonHandler legacy = RadioButtonHandler(value: null);
  final RadioButtonHandler usaOrCanada = RadioButtonHandler(value: null);
  final RadioButtonHandler satOrAct = RadioButtonHandler(value: null);
  final RadioButtonHandler honors = RadioButtonHandler(value: null);
  final RadioButtonHandler addmission = RadioButtonHandler(value: null);

  @override
  State<StatefulWidget> createState() => _BeforeDashboard();
}

class _BeforeDashboard extends State<GradeDashboard> {
  List<String> terms = ["Fall 2024", "Fall 2025", "Fall 2026", "Fall 2027"];
  List<String> plans = ["Early Decision", "Regular Decision"];
  List<String> scores = ["Yes", "No"];
  List<String> legacys = ["Yes", "No"];
  List<String> usaOrCanada = ["Yes", "No"];
  List<String> satOrAct = ["Yes", "No"];
  List<String> honors = ["Yes", "No"];
  List<String> addmission = ["Yes", "No"];

  List<String> planErrorMessage = [];
  List<String> termErrorMessage = [];
  List<String> aidErrorMessage = [];
  List<String> legacyErrorMessage = [];
  List<String> usaOrCanadaErrorMessage = [];
  List<String> satOrActErrorMessage = [];
  List<String> honorsErrorMessage = [];
  List<String> addmissionErrorMessage = [];
  bool showActivityErrorMessage = false;

  var brelify = TextEditingController();

  Client httpClient = Client();

  Map<String, int> activities = {};

  List<dynamic> selection = [];
  bool errorArea = false;

  void setSelections() async {
    var temp = await httpClient.getAllActivities();

    setState(() {
      selection = temp;
    });
  }

  @override
  void initState() {
    setSelections();
    debugPrint(selection.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 5, 16, 20),
        decoration: BoxDecoration(
            color: const Color(0xff3A3D4C),
            borderRadius: BorderRadius.circular(5)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 20),
                alignment: Alignment.center,
                child: Text(
                  "Unlock your dream university",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "Welcome to SIS Progress!\n",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xffD2DAFF)),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                            "Please answer the following questions\naccurately and completely to gain access to\nthe full functionality of the dashboard and\nprogram. Let's get started!",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ))
                      ]),
                ),
              ),
              buildQuestion("1. Preferred Start term options.", false),
              CustomRadioGroup(
                handler: widget.term,
                groupValue: terms,
                methodParent: () => debugPrint("Hello"),
                value: widget.term.value,
                errors: termErrorMessage,
              ),
              buildQuestion("2. Preferred admission plan.", false),
              CustomRadio(
                handler: widget.plan,
                groupValue: plans,
                methodParent: () => debugPrint("Hello"),
                value: widget.plan.value,
                errors: planErrorMessage,
              ),
              buildQuestion(
                  "3. Do you instead to pursue need-based Financial AID? ",
                  false),
              CustomRadio(
                handler: widget.score,
                groupValue: scores,
                methodParent: () => debugPrint("Hello"),
                value: widget.score.value,
                errors: aidErrorMessage,
              ),
              buildQuestion("4. Are you a legacy?", false),
              CustomRadio(
                handler: widget.legacy,
                groupValue: legacys,
                methodParent: () => debugPrint("Hello"),
                value: widget.legacy.value,
                errors: legacyErrorMessage,
              ),
              buildQuestion("5. Please briefly elaborate on your extracurricular activities or work experiences.", false),
              Container(
                margin: const EdgeInsets.fromLTRB(23, 10, 23, 0),
                height: 160,
                child: TextFormField(
                  controller: brelify,
                  expands: false,
                  maxLines: 8,
                  maxLength: 1600,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: const Color(0xffD2DAFF)
                  ),

                  decoration: InputDecoration(
                    errorText: errorArea ? "Required field": null,
                    counterStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: const Color(0xffD2DAFF)
                    ),
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xffD2DAFF)
                    ),
                    errorStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: const Color(0xffE31F1F)
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
              ),

              Button(
                  text: "Submit",
                  onPressed: () async {
                    setState(() {
                      planErrorMessage = [];
                      termErrorMessage = [];
                      aidErrorMessage = [];
                      legacyErrorMessage = [];
                      addmissionErrorMessage = [];

                      showActivityErrorMessage = false;

                      if(brelify.text.isNullOrEmpty) {
                        errorArea = true;
                      }

                      if(widget.term.value == null) {
                        termErrorMessage.add("Required field");
                      }

                      if (widget.plan.value == null) {
                        planErrorMessage.add("Required field");
                      }

                      if (widget.addmission.value == null) {
                        addmissionErrorMessage.add("Required field");
                      }

                      if (widget.score.value == null) {
                        aidErrorMessage.add("Required field");
                      }

                      if (widget.legacy.value == null) {
                        legacyErrorMessage.add("Required field");
                      }

                      if (activities.keys
                          .toList()
                          .length < 2) {
                        showActivityErrorMessage = true;
                      }
                    });

                    if (planErrorMessage.isEmpty &&
                        termErrorMessage.isEmpty &&
                        aidErrorMessage.isEmpty &&
                        legacyErrorMessage.isEmpty) {

                      var acti = <String> [];

                      activities.forEach((key, value) {
                        acti.addAll(List<String>.filled(value, key));
                      });

                      Map<String, dynamic> data = await httpClient.updateUserInfo(
                          term: widget.term.value.toString(),
                          planType: widget.plan.value.toString(),
                          aid: widget.score.value.toString() == "Yes"
                              ? true
                              : false,
                          legacy: widget.legacy.value.toString() == "Yes" ? true: false,
                          area: brelify.text,
                          applying: widget.usaOrCanada.value.toString() == "Yes" ? true: false,
                          testSubmit: "['SAT', 'ACT']",
                          achievements: widget.honors.value.toString() == "Yes" ? true: false,
                          admission: widget.addmission.value.toString() == "Yes" ? true: false,
                          activityName: acti);


                      if(data["success"] == true) {
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScaffoldHome()));
                      }
                    }
                  },
                  height: 38,
                  width: double.infinity)
            ],
          ),
        ),
      ),
    );
  }

  Image buildLogoIcon() {
    return Image.asset(
      "assets/logo.png",
    );
  }

  Container buildQuestion(String question, bool isRequired) {
    return Container(
      margin: const EdgeInsets.fromLTRB(19, 20, 0, 0),
      alignment: Alignment.centerLeft,
      child: isRequired
          ? RichText(
        text: TextSpan(
            text: question,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white),
            children: <TextSpan>[
              TextSpan(
                  text: " *",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white))
            ]),
      )
          : Text(question,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.white)),
    );
  }
}
