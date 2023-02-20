import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/registration_data_grade10.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/verify_email.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/input_box.dart';
import 'package:sis_progress/widgets/radio_button.dart';
import 'package:sis_progress/widgets/select_box.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';
import '../../widgets/progress/progress_bar.dart';

class Grade10thSecond extends StatefulWidget {
  final List<String> activites = [];
  final List<String> activites2 = [];
  final TextEditingController controller = TextEditingController();
  final TextEditingController work = TextEditingController();
  final TextEditingController work2 = TextEditingController();
  final RegistrationGrade10 reg;
  final RadioButtonHandler secondQuest = RadioButtonHandler(value: null);
  final RadioButtonHandler thirdQuest = RadioButtonHandler(value: null);
  final RadioButtonHandler fifthQuest = RadioButtonHandler(value: null);
  final RadioButtonHandler sixthQuest = RadioButtonHandler(value: null);
  final RadioButtonHandler ninthQuest = RadioButtonHandler(value: null);

  Grade10thSecond({
    required this.reg,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Grade10thSecond();

}

class _Grade10thSecond extends State<Grade10thSecond> {
  List<String> secondQuestion = ["Yes", "No"];
  List<String> thirdQuestion = ["Yes", "No"];
  List<String> yesOrNo = ["Yes", "No"];
  List<String> noOrYes = ["No", "Yes"];

  Client httpClient = Client();

  final GlobalKey<CustomRadioState> _key = GlobalKey();

  bool isVisible = false;
  bool testScore = false;

  bool isAct = false;
  bool isSat = false;

  void changeIsVisible() {
    setState(() {
      if(widget.ninthQuest.value == "No") {
        isVisible = true;
      } else if(widget.ninthQuest.value == "Yes") {
        isVisible = false;
      }
      // print()
    });
  }

  void satOrAct() {
    setState(() {
      testScore = !testScore;
      if(testScore == false) {
        whichTest = [];
      }
    });
  }

  String text = "0/60";
  Timer? timer;

  TextEditingController cont = TextEditingController();

  List<String> actions = [];
  List<String> values = [];

  List<String> whichTest = [];


  double getContainerWidth (String value) {
    if(value.length < 7) {
      return 60;
    }

    return value.length * 10;
  }

  @override
  void initState() {
    if(widget.reg.place != null) {
      widget.secondQuest.value = widget.reg.place;
    } 

    if(widget.reg.honors != null) {
      widget.fifthQuest.value = widget.reg.honors;
    }

    if(widget.reg.addmisionTest != null) {
      widget.sixthQuest.value = widget.reg.addmisionTest;  
    }

    if(widget.reg.essayWorkExp != null) {
      widget.work.text = widget.reg.essayWorkExp!;
    }

    if(widget.reg.school != null) {
      widget.controller.text = widget.reg.school!;
    }

    if(widget.reg.outActivity != null) {
      actions = widget.reg.outActivity!;
    }

    // print(widget.wo);
    if(widget.reg.details != null) {
      if(widget.reg.details == "No") {
        isVisible = false;
        widget.ninthQuest.value = "No";
      } else {
        widget.ninthQuest.value = "Yes";
        isVisible = true;
        widget.work2.text = widget.reg.details ?? "";
      }
    } 



    if(widget.reg.satAndAct != null) {
      whichTest = widget.reg.satAndAct!;
      // print(widget.reg.satAndAct);
      if(widget.reg.satAndAct!.isEmpty) {
        widget.thirdQuest.value = "No";
        whichTest = [];
      } else {
        widget.thirdQuest.value = "Yes";

        testScore = true;

        if(widget.reg.satAndAct!.contains("SAT")) {
          setState(() {
            isSat = true; 
          });
        } else {
          setState(() {
            isSat = false;            
          });

        }

        if(widget.reg.satAndAct!.contains("ACT")) {
          setState(() {
            isAct = true;
          });
        } else {
          setState(() {
            isAct = false;
          });
          
        }
      }
    } else {
      // widget.thirdQuest.value = "No";
      whichTest = [];
    }
    super.initState();
  }

  List<String> applyingFromErrors = [];
  List<String> honorsErrorText = [];
  List<String> addmisionTest = [];
  List<String> satOrAcrErrorText = [];
  String activityErrorText = "";
  bool validSchool = false;
  bool anyError = false;
  bool canPass = true;
 
  @override
  Widget build(BuildContext context) {
    // print(actions);

    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: const Color(0xff3A3D4C),
          borderRadius: BorderRadius.circular(5)
        ),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 32),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget> [
              const ProgressBar(isPassed: [true, true, false]),
              buildTitle(),

              Visibility(
                  visible: anyError,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text(
                      "This email is already been used, please try again",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: const Color(0xffE31F1F)
                      ),
                    ),
                  )
                ),
              buildQuestion("1. Are you applying from a school outside the US and Canada?"),
              // buildAnswer(getSeconeQuest, secondQuestion, secondQuest),
              CustomRadio(handler: widget.secondQuest, groupValue: secondQuestion, methodParent: () => print("Hello"), value: widget.secondQuest.value, errors: applyingFromErrors,),
              buildQuestion("2. Do you wish to submit SAT or ACT test scores?"),
              CustomRadio(handler: widget.thirdQuest, groupValue: noOrYes, methodParent: satOrAct, value: widget.thirdQuest.value, errors: satOrAcrErrorText,),

              Visibility(
                visible: testScore,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(38, 24, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: const Color(0xff355CCA))
                            ),
                
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isSat = !isSat;

                                  if(isSat) {
                                    whichTest.add("SAT");
                                  } else {
                                    whichTest.remove("SAT");
                                  }

                                  // print(whichTest);
                                });
                              },
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: isSat ? const Color(0xff355CCA): Colors.transparent,
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
                                color: Colors.white
                              ),
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
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 1, color: const Color(0xff355CCA))
                            ),
                
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isAct = !isAct;

                                  if(isAct) {
                                    whichTest.add("ACT");
                                  } else {
                                    whichTest.remove("ACT");
                                  }

                                  // print(whichTest);
                                });
                              },
                              child: Icon(
                                Icons.check,
                                size: 15,
                                color: isAct ? const Color(0xff355CCA) : Colors.transparent
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              "ACT",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Colors.white
                              )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

              ),
              buildQuestion("3. What is your current high school?"),
              InputBox(textInputType: TextInputType.text, onChanged: (String val) {print("Hello World");}, context: context, controller: widget.controller, isPassword: false, initialValue: "School", showValidationOrNot: validSchool, errorText: "This field is required",),
              buildQuestion("4. Do you wish to report any honors related to your academic achievements?"),
              // buildAnswer(getFifthQuest, yesOrNo, fifthQuest),
              CustomRadio(handler: widget.fifthQuest, groupValue: yesOrNo, methodParent: () => print("Hello"), value: widget.fifthQuest.value, errors: honorsErrorText,),
              buildQuestion("5. Did you take any admission tests?"),
              // buildAnswer(getSixthQuest, yesOrNo, sixthQuest),
              CustomRadio(handler: widget.sixthQuest, groupValue: yesOrNo, methodParent: () => print("Hello"), value: widget.sixthQuest.value, errors: addmisionTest,),
              buildQuestion("6. Please report up to 10 activities that can help colleges better understand your life outside of the classroom "),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                child: Wrap(
                  runSpacing: 10,
                  spacing: 5.0,
                  direction: Axis.horizontal,
                  children: actions.map((e) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                      height: 29,
                      // width: 150,
                      width: getContainerWidth(e),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: const Color(0xffB1B2FF))
                      ),
                            
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                e,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xffB1B2FF)
                                ),
                              ),
                        
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    actions.remove(e);
                                  });
                                }, 
                                child: const Icon(
                                  Icons.remove,
                                  size: 15,
                                  color:  Color(0xffB1B2FF),
                                )
                              )
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
    child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          

      return TextFormField(
        readOnly: true,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                fontStyle: FontStyle.normal,
                color: Colors.white),
            controller: cont,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: "Select your activites",
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
                  // controller.text = value;
                },
                itemBuilder: (BuildContext context) {
                  


                  return Universities().clubCategories.map<PopupMenuItem<String>>((String value) {
                    bool isEnabled = actions.where((element) => element.contains(value)).isNotEmpty;

                    return PopupMenuItem(
                        value: value,
                        child: StatefulBuilder(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [ 
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            var temp = isEnabled;

                                          },); 

                                          setState(() {
                                            var temp = actions;
                                          });

                                          setState(() {
                                            if(actions.length != 10) {
                                              if(!isEnabled) {
                                                actions.add(value); 
                                              } else {
                                                // print(actions);
                                                actions.removeWhere((e) => e.contains(value));

                                                // print(actions);
                                              }
                                            }
                                          });

                                          state(() {             
                                            // actions = temp;
                                            isEnabled = !isEnabled;
                                          });
                                          
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1,color: const Color(0xff355CCA))
                                          ),
                                          child:  Icon(
                                            Icons.check,
                                            size: 18,
                                            color: isEnabled ?  const Color(0xff355CCA): Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      value.length > 20 ? value.substring(0, 20): value,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: const Color(0xff121623),
                                      ),
                                    ),
                                  ],
                                ),
      
                                Row(
                                  children: <Widget> [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: Color(0xff355CCA).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5),
      
                                        border: Border.all(width: 1, color: const Color(0xff355CCA))
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            var temp = actions;
                                          });


                                          setState(() {
                                              for(int i = 0; i < actions.length; i++) {
                                                
                                                if(actions[i].contains(value)) {
                                                
                                                  try {
                                                    var content = actions[i].split(" ");
                                                    print(content[0]);
                                                    var val = int.parse(content[1].replaceAll(RegExp(r'[\(\)]'), ''));
                                                    // values.remove(actions[i]);
                                                  // print("${content[0]} (${content.length - 1})");
                                                    
                                                    
                                                      if(values.where((e) => e.contains(value)).length == 1) {
                                                        actions[i] = "${content[0]}";
                                                        values.removeAt(i);
                                                      }else {
                                                        if(values.where((e) => e.contains(value)).length != 1) {
                                                          actions[i] = "${content[0]} (${val - 1})";
                                                          values.removeAt(i);
                                                        }                                                     
                                                      }
                                                    
                                                  } catch(e) {
                                                    // actions[i] = "${actions[i]} (${actions.where((element) => element.contains(value)).length + 1})";
                                                    actions.remove(value);
                                                  }
                                              
                                                // if(actions.where((element) => element.contains(value)).length > 1) {
                                                //   var content = actions[i].split(" ");
                                                //   print(content[0]);
                                                //   print(content[1]);
                                                //   print("${content[0]} (${content.length - 1})");
                                                //   actions[i] = "${content[0]} (${content.length - 1})";

                                                // } else {

                                                // }
                                                // var content = actions[i].split(" ");

                                                
                                                
                                                
                                                }
                                              }
                                          });

                                          state(() {
                                            var val = 0;
                                          },);

                                          setState(() {
                                            var temp = actions.reversed;
                                            print(temp);
                                          },);
                                          
                                          
                                          print(actions);
                                        }, 
                                        child: const Icon(
                                          Icons.remove,
                                          size: 14,
                                          color: Color(0xff355CCA)
                                        )
                                      ),
                                    ),
      
                                    Text(
                                      isEnabled ? "${values.where((e) => e.contains(value)).length + 1}" : "1"
                                    ),
                                    
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff355CCA).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5),
      
                                        border: Border.all(width: 1, color: const Color(0xff355CCA))
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            var val = 0;
                                          },);

                                          setState(() {
                                            // if(actions.length != 10) {
                                            //   if(actions.where((element) => element.contains(value)).length > 0) {
                                            //     actions.add("$value (${actions.where((element) => element.contains(value)).length + 1})");
                                            //   }
                                            // }    
                                            for(int i = 0; i < actions.length; i++) {
                                              if(actions[i].contains(value)) {
                                                
                                                try {
                                                  var content = actions[i].split(" ");
                                                  print(content[0]);
                                                  var val = int.parse(content[1].replaceAll(RegExp(r'[\(\)]'), ''));
                                                  // print("${content[0]} (${content.length - 1})");
                                                  if(val < 10) {
                                                    actions[i] = "${content[0]} (${val + 1})";
                                                    values.add("${actions[i]} (${actions.where((element) => element.contains(value)).length + 1})");
                                                  }
                                                } catch(e) {
                                                  values.add("${actions[i]} (${actions.where((element) => element.contains(value)).length + 1})");
                                                  actions[i] = "${actions[i]} (${actions.where((element) => element.contains(value)).length + 1})";
                                                }
                                              
                                                // if(actions.where((element) => element.contains(value)).length > 1) {
                                                //   var content = actions[i].split(" ");
                                                //   print(content[0]);
                                                //   print(content[1]);
                                                //   print("${content[0]} (${content.length - 1})");
                                                //   actions[i] = "${content[0]} (${content.length - 1})";

                                                // } else {

                                                // }
                                                // var content = actions[i].split(" ");

                                                
                                                
                                                
                                              }
                                            }            
                                            // temp = actions;
                                          });

                                          state(() {
                                            var val = 0;
                                          },);



                                          setState(() {
                                            var temp = actions.reversed;
                                            print(temp);
                                          },);
                                        }, 
                                        child: const Icon(
                                          Icons.add,
                                          size: 14,
                                          color: Color(0xff355CCA),
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          }
                        ));
                  }).toList();
                },
              ),
            ),
          );
        }
      )),
              // RegistrationActivities(cont, Universities().clubCategories, "Select your activities", actions),
              // RegistrationActivities(labelText: "Select your activities", controller: cont, items: Universities().clubCategories, actions: actions),
 
            
              // buildActivity([2, 1, 1], widget.activites2, ["Reading", "Sport", "Run"]),
              // buildActivity([1, 2, 1], widget.activites2, ["Games", "Writing", "Walk"]),
              // buildActivity([2, 1, 1], widget.activites2, ["Dancing", "TV", "Coding"]),
              Container(
                margin: const EdgeInsets.fromLTRB(23, 10, 23, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  activityErrorText,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: const Color(0xffE31F1F)
                  ),
                ),
              ),
              buildQuestion("7. Please briefly elaborate on your extracurricular activities or work experiences."),
              Container(
                margin: const EdgeInsets.fromLTRB(23, 10, 23, 0),
                height: 160,
                child: TextFormField(

                  onChanged: (value) {
                    setState(() {
                      text = "${value.length}/60";
                    });
                  },
                  controller: widget.work,
                  expands: false,
                  maxLines: 8,
                  maxLength: 160,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: const Color(0xffD2DAFF)
                  ),
                  decoration: InputDecoration(
                    counterStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color(0xffD2DAFF)
                    ),
                    errorText: !canPass ? "Please fill required fields" : null,
                    hintText: "Type about your activites or work experiance",
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xffD2DAFF)
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
        
              
              buildQuestion("8. Do you wish to provide details of circumstances or qualifications not reflected in the registration form"),
              CustomRadio(handler: widget.ninthQuest, groupValue: noOrYes, key: _key, methodParent: changeIsVisible, value: widget.ninthQuest.value),
              Visibility(
                visible: isVisible,
                maintainSize: false,
                child: Column(
                  children: <Widget> [
                    Container(
                margin: const EdgeInsets.fromLTRB(23, 10, 23, 0),
                height: 160,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      text = "${value.length}/160";
                    });
                  },
                  controller: widget.work2,
                  expands: false,
                  maxLines: 8,
                  maxLength: 160,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: const Color(0xffD2DAFF)
                  ),
                  decoration: InputDecoration(
                    hintText: "Type about your activites or work experiance",
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
                  ],
                ),
              ),
              buildNavigation(context, widget.activites, () async {
                widget.reg.place = widget.secondQuest.value;
                widget.reg.testScore = widget.thirdQuest.value;
                widget.reg.school = widget.controller.text;
                widget.reg.honors = widget.fifthQuest.value;
                // widget.reg.test = sixthQuest;
                widget.reg.addmisionTest = widget.sixthQuest.value;
                widget.reg.outActivity = actions;
                widget.reg.essayWorkExp = widget.work.text;
                
                if (widget.ninthQuest.value == "Yes") {
                  widget.reg.details = widget.work2.text;
                } else {
                  widget.reg.details = "No";
                }
                // await httpClient.registerForGrade10(widget.reg);

                setState(() {
                  applyingFromErrors = [];
                  honorsErrorText = [];
                  addmisionTest = [];
                  satOrAcrErrorText = [];
                  validSchool = false;
                  activityErrorText = "";
                });

                if(widget.secondQuest.value == null) {
                  setState(() {
                    applyingFromErrors.add("This field is required");
                  });                
                } 

                if(widget.fifthQuest.value == null) {
                  setState(() {
                    // Do you wish to report any honors related to your academic achievements?
                    honorsErrorText.add("This field is required");
                  });                
                } 

                if(widget.sixthQuest.value == null) {
                  setState(() {
                    addmisionTest.add("This field is required");
                  });
                }

                if(widget.controller.text.isEmpty) {
                  setState(() {
                    validSchool = true;
                  });
                }

                if(widget.work.text.length == 0) {
                  setState(() {
                    canPass = false;
                  });
                } else {
                  setState(() {
                    canPass = true;
                  });
                }

                if(widget.thirdQuest.value == null) {
                  setState(() {
                    satOrAcrErrorText.add("This field is required");
                  });
                }

                if(widget.thirdQuest.value == "Yes") {
                  setState(() {
                    if(whichTest.isEmpty) {
                      satOrAcrErrorText.add("This field is required");
                    }
                  });
                }

                if(actions.isEmpty) {
                  setState(() {
                    activityErrorText = "Please select at least 2 distinct activities";
                  });
                }

                if((activityErrorText == "") && satOrAcrErrorText.isEmpty && !validSchool && addmisionTest.isEmpty && honorsErrorText.isEmpty && applyingFromErrors.isEmpty) {
                   var value = await httpClient.registerForGrade10(widget.reg);
                   if(value == "user alredy exit") {
                    setState(() {
                      anyError = true;
                    });
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmail(email: widget.reg.email,)));
                  } 

                  
                }

              }, 
              () {
                widget.reg.place = widget.secondQuest.value;
                widget.reg.testScore = widget.thirdQuest.value;
                widget.reg.honors = widget.fifthQuest.value;
                widget.reg.addmisionTest = widget.sixthQuest.value;
                widget.reg.school = widget.controller.text;
                widget.reg.outActivity = actions;
                widget.reg.essayWorkExp = widget.work.text;
                widget.reg.satAndAct = whichTest;
                if (widget.ninthQuest.value == "Yes") {
                  widget.reg.details = widget.work2.text;
                } else {
                  widget.reg.details = "No";
                }
              }),

            ],
          ),
        ),
      ),
    );
  }

  String count(List<String> temp, String value) {
    String value = "";

    setState(() {
      value = "${temp.where((element) => element.contains(value)).length}";
    });

    return value;
  }

  Container buildMode(
    TextEditingController controller,
    List<String> items,
    String lableText, ) {
    
  List<String> temp = [];
  setState(() {
    temp = actions;
  });

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
                  // controller.text = value;
                },
                itemBuilder: (BuildContext context) {
                  


                  return items.map<PopupMenuItem<String>>((String value) {
                    bool isEnabled = actions.where((element) => element.contains(value)).isNotEmpty;

                    return PopupMenuItem(
                        value: value,
                        child: StatefulBuilder(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [ 
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            if(actions.length != 10) {
                                              if(!isEnabled) {
                                                actions.add(value); 
                                              } else {
                                                actions.remove(value);
                                              }
                                            }
                                            
                                            // actions = temp;
                                            isEnabled = !isEnabled;
                                          });
                                          
                                        },
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1,color: const Color(0xff355CCA))
                                          ),
                                          child:  Icon(
                                            Icons.check,
                                            size: 18,
                                            color: isEnabled ?  const Color(0xff355CCA): Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      value.length > 20 ? value.substring(0, 20): value,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: const Color(0xff121623),
                                      ),
                                    ),
                                  ],
                                ),
      
                                Row(
                                  children: <Widget> [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        color: Color(0xff355CCA).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5),
      
                                        border: Border.all(width: 1, color: const Color(0xff355CCA))
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            actions.remove(value);

                                            actions = temp;
                                          });
                                          setState(() {
                                            
                                          });
                                          
                                          print(actions);
                                        }, 
                                        child: const Icon(
                                          Icons.remove,
                                          size: 14,
                                          color: Color(0xff355CCA)
                                        )
                                      ),
                                    ),
      
                                    Text(
                                      isEnabled ? "${temp.where((e) => e.contains(value)).length}" : "1"
                                    ),
                                    
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff355CCA).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5),
      
                                        border: Border.all(width: 1, color: const Color(0xff355CCA))
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            if(actions.length != 10) {
                                                actions.add("$value (${temp.where((element) => element == value).length})");
                                            }
                                          
                                            // temp = actions;
                                          });
                                        }, 
                                        child: const Icon(
                                          Icons.add,
                                          size: 14,
                                          color: Color(0xff355CCA),
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ],
                            );
                          }
                        ));
                  }).toList();
                },
              ),
            ),
          );
        }
      ));
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
    margin: const EdgeInsets.fromLTRB(19, 20, 58, 0),
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

Container buildActivity(List<int> flex, List<String> activites, List<String> activityName) {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Expanded(flex: flex[0], child: SelectBox(activity: activites, activityName: activityName[0],)),
        Expanded(flex: flex[1], child: SelectBox(activity: activites, activityName: activityName[1],)),
        Expanded(flex: flex[2], child: SelectBox(activity: activites, activityName: activityName[2]))
      ],
    ),
  );
}

Container buildButton(String value, List<String> activites, Color color) {
  return Container(
    // height: 100,
    // width: 150,
    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(18.0),
        ),
        side: BorderSide(width: 1.5, color: color,)
      ),
      onPressed: () => activites.add(value),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: color
          ),
        ),
      ),
    ),
  );
}

Row buildNavigation(BuildContext context, List<String> printable, Function()? onPress, VoidCallback onPop) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget> [
      Container(
        margin: const EdgeInsets.fromLTRB(20, 37, 0, 20),
        child: TextButton.icon(     // <-- TextButton
          onPressed: () {
            onPop();
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
      margin: const EdgeInsets.fromLTRB(0, 37, 20, 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff36519D)
        ),
        onPressed: onPress,
        child: Text( 
          "Next",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18
          ),
        )
      ),
    )
  ],
  );
}

