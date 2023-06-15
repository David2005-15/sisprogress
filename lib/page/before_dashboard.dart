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

class BeforeDashboard extends StatefulWidget {
  BeforeDashboard({super.key});

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

class _BeforeDashboard extends State<BeforeDashboard> {
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

  Client httpClient = Client();

  Map<String, int> activities = {};

  List<dynamic> selection = [];

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
  List<String> tests = [];

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
              buildQuestion("1.  Preferred Start term options.", false),
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
              buildQuestion(
                  "5. Are you applying from a school outside the US and Canada?",
                  false),
              CustomRadio(
                handler: widget.usaOrCanada,
                groupValue: usaOrCanada,
                methodParent: () => debugPrint("Hello"),
                value: widget.usaOrCanada.value,
                errors: usaOrCanadaErrorMessage,
              ),
              buildQuestion(
                  "6. Do you wish to submit SAT or ACT test scores?", false),
              CustomRadio(
                handler: widget.satOrAct,
                groupValue: satOrAct,
                methodParent: () {
                  setState(() {

                  });
                },
                value: widget.satOrAct.value,
                errors: satOrActErrorMessage,
              ),
              Container(margin: const EdgeInsets.fromLTRB(38, 10, 0, 0),
                child: Visibility(
                  visible: widget.satOrAct.value == "Yes",
                    child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: tests.contains("SAT") ? const Color(0xff355CCA) : Colors.transparent,
                            border: Border.all(
                                width: 1, color: const Color(0xff355CCA))),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if(tests.contains("SAT")) {
                                tests.remove("SAT");
                                return;
                              }

                              tests.add("SAT");
                            });
                          },
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: tests.contains("SAT") ? Colors.white : Colors.transparent,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "SAT",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        decoration: BoxDecoration(
                            color: tests.contains("ACT") ? const Color(0xff355CCA) : Colors.transparent,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: const Color(0xff355CCA))),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if(tests.contains("ACT")) {
                                tests.remove("ACT");
                                return;
                              }

                              tests.add("ACT");
                            });
                          },
                          child: Icon(Icons.check,
                              size: 15, color: tests.contains("ACT")? Colors.white :Colors.transparent),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text("ACT",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white)),
                      )
                    ],
                  ),
                ])),
              ),
              buildQuestion(
                  "7. Do you wish to report any honors related to your academic achievements?",
                  false),
              CustomRadio(
                handler: widget.honors,
                groupValue: honors,
                methodParent: () => debugPrint("Hello"),
                value: widget.honors.value,
                errors: honorsErrorMessage,
              ),
              buildQuestion("8. Did you take any admission tests?", false),
              CustomRadio(
                handler: widget.addmission,
                groupValue: addmission,
                methodParent: () => debugPrint("Hello"),
                value: widget.addmission.value,
                errors: addmissionErrorMessage,
              ),
              buildQuestion(
                  "9. Please report up to 10 activities that can help colleges better understand your life outside of the classroom.",
                  false),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                child: Wrap(
                  runSpacing: 10,
                  spacing: 5.0,
                  direction: Axis.horizontal,
                  children: activities.entries.map((entry) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      height: 29,
                      // width: 150,
                      width: entry.key.toString().length * 10,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1, color: const Color(0xffB1B2FF))),

                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                entry.key,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xffB1B2FF)),
                              ),
                              Text(
                                " (${entry.value})",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xffB1B2FF)),
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      activities.remove(entry.key);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    size: 15,
                                    color: Color(0xffB1B2FF),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return TextFormField(
                      readOnly: true,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                      decoration: InputDecoration(
                        errorText:
                            showActivityErrorMessage ? "Change My Mind" : null,
                        alignLabelWithHint: true,
                        labelText: "Select your activities",
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
                            borderSide:
                                BorderSide(color: Color(0xffD2DAFF), width: 1)),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffD2DAFF), width: 1)),
                        focusColor: const Color(0xffD2DAFF),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff36519D))),
                        suffixIcon: PopupMenuButton<String>(
                          color: const Color(0xffD2DAFF),
                          constraints: BoxConstraints.expand(
                              height: 150, width: constraints.maxWidth),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xffD2DAFF),
                          ),
                          onSelected: (String value) {
                            // controller.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return selection
                                .map<PopupMenuItem<String>>((dynamic value) {
                              return PopupMenuItem(
                                  value: value,
                                  child: StatefulBuilder(
                                      builder: (context, state) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
                                              child: InkWell(
                                                onTap: () {
                                                  int sum = 0;
                                                  if (activities.isNotEmpty) {
                                                    sum = activities.values
                                                        .reduce((value,
                                                                element) =>
                                                            value + element);
                                                  }
                                                  state(() {
                                                    // int sum = activities.values.reduce((value, element) => value + element);
                                                    // print(sum);

                                                    if (!activities.containsKey(
                                                            value) &&
                                                        sum < 10) {
                                                      activities[value] = 1;
                                                    } else {
                                                      activities.remove(value);
                                                    }
                                                  });

                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          width: 1.5,
                                                          color: const Color(
                                                              0xff355CCA))),
                                                  child: activities
                                                          .containsKey(value)
                                                      ? const Icon(Icons.check,
                                                          size: 18,
                                                          color:
                                                              Color(0xff355CCA))
                                                      : null,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              value.length > 20
                                                  ? value.substring(0, 20)
                                                  : value,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: const Color(0xff121623),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 20,
                                              height: 20,
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 5, 0),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xff355CCA)
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xff355CCA))),
                                              child: InkWell(
                                                  onTap: () {
                                                    state(() {
                                                      if (activities
                                                          .containsKey(value)) {
                                                        activities.update(value,
                                                            (val) {
                                                          if (val > 0) {
                                                            val -= 1;
                                                          }

                                                          return val;
                                                        });
                                                      }
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                      Icons.remove,
                                                      size: 14,
                                                      color:
                                                          Color(0xff355CCA))),
                                            ),
                                            Text(activities.containsKey(value)
                                                ? activities[value].toString()
                                                : "0"),
                                            Container(
                                              width: 20,
                                              height: 20,
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 0, 0),
                                              decoration: BoxDecoration(
                                                  color: const Color(0xff355CCA)
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: const Color(
                                                          0xff355CCA))),
                                              child: InkWell(
                                                  onTap: () {
                                                    int sum = 0;
                                                    if (activities.isNotEmpty) {
                                                      sum = activities.values
                                                          .reduce((value,
                                                                  element) =>
                                                              value + element);
                                                    }

                                                    state(() {
                                                      if (activities
                                                              .containsKey(
                                                                  value) &&
                                                          sum < 10) {
                                                        activities.update(value,
                                                            (val) {
                                                          if (val < 10) {
                                                            val += 1;
                                                          }

                                                          return val;
                                                        });
                                                      }
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 14,
                                                    color: Color(0xff355CCA),
                                                  )),
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  }));
                            }).toList();
                          },
                        ),
                      ),
                    );
                  })),
              Button(
                  text: "Submit",
                  onPressed: () async {
                    setState(() {
                      planErrorMessage = [];
                      termErrorMessage = [];
                      aidErrorMessage = [];
                      legacyErrorMessage = [];
                      usaOrCanadaErrorMessage = [];
                      satOrActErrorMessage = [];
                      honorsErrorMessage = [];
                      addmissionErrorMessage = [];

                      showActivityErrorMessage = false;

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

                      if (widget.honors.value == null) {
                        honorsErrorMessage.add("Required field");
                      }

                      if (widget.usaOrCanada.value == null) {
                        usaOrCanadaErrorMessage.add("Required field");
                      }

                      if (widget.satOrAct.value == null) {
                        satOrActErrorMessage.add("Required field");
                      }

                      if (widget.term.value == null) {
                        termErrorMessage.add("Required field");
                      }

                      if (activities.keys.toList().length < 2) {
                        showActivityErrorMessage = true;
                      }
                    });

                    if (planErrorMessage.isEmpty &&
                        addmissionErrorMessage.isEmpty &&
                        aidErrorMessage.isEmpty &&
                        legacyErrorMessage.isEmpty &&
                        honorsErrorMessage.isEmpty &&
                        usaOrCanadaErrorMessage.isEmpty &&
                        satOrActErrorMessage.isEmpty &&
                        termErrorMessage.isEmpty &&
                        !showActivityErrorMessage) {
                      var acti = <String>[];

                      activities.forEach((key, value) {
                        acti.addAll(List<String>.filled(value, key));
                      });

                      Map<String, dynamic> data =
                          await httpClient.updateUserInfo(
                              term: widget.term.value.toString(),
                              planType: widget.plan.value.toString(),
                              aid: widget.score.value.toString() == "Yes"
                                  ? true
                                  : false,
                              legacy: widget.legacy.value.toString() == "Yes"
                                  ? true
                                  : false,
                              area: "",
                              applying:
                                  widget.usaOrCanada.value.toString() == "Yes"
                                      ? true
                                      : false,
                              testSubmit: "['SAT', 'ACT']",
                              achievements:
                                  widget.honors.value.toString() == "Yes"
                                      ? true
                                      : false,
                              admission:
                                  widget.addmission.value.toString() == "Yes"
                                      ? true
                                      : false,
                              activityName: acti);

                      if (data["success"] == true) {
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
