import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/registration_data_grade10.dart';
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
  final RadioButtonHandler secondQuest = RadioButtonHandler(value: "Outside the US and Canada");
  final RadioButtonHandler thirdQuest = RadioButtonHandler(value: "SAT");
  final RadioButtonHandler fifthQuest = RadioButtonHandler(value: "Yes");
  final RadioButtonHandler sixthQuest = RadioButtonHandler(value: "Yes");
  final RadioButtonHandler ninthQuest = RadioButtonHandler(value: "No");

  Grade10thSecond({
    required this.reg,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Grade10thSecond();

}

class _Grade10thSecond extends State<Grade10thSecond> {
  List<String> secondQuestion = ["Outside the US and Canada", "From the US and Canada"];
  List<String> thirdQuestion = ["SAT", "ACT"];
  List<String> yesOrNo = ["Yes", "No"];
  List<String> noOrYes = ["No", "Yes"];

  final GlobalKey<CustomRadioState> _key = GlobalKey();

  bool isVisible = false;

  void changeIsVisible() {
    setState(() {
      isVisible = !isVisible;
      // print()
    });
  }

  String text = "0/160";
  Timer? timer;

  @override
  Widget build(BuildContext context) {

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
              buildQuestion("1. Please indicate which fields of study you would be interested in exploring further at the University"),
              buildActivity([1, 1, 2], widget.activites, ["Football", "Science", "Music"]),
              buildActivity([1, 2, 1], widget.activites, ["Write", "Chemestry", "Math"]),
              buildQuestion("2. Are you applying from a school outside the US and Canada?"),
              // buildAnswer(getSeconeQuest, secondQuestion, secondQuest),
              CustomRadio(handler: widget.secondQuest, groupValue: secondQuestion, methodParent: () => print("Hello")),
              buildQuestion("3. Do you wish to submit SAT or ACT test scores?"),
              CustomRadio(handler: widget.thirdQuest, groupValue: thirdQuestion, methodParent: () => print("Hello")),
              buildQuestion("4. What is your current or most recent secondary/high school?"),
              InputBox(textInputType: TextInputType.text, onChanged: (String val) {print("Hello World");}, context: context, controller: widget.controller, isPassword: false, initialValue: "School"),
              buildQuestion("5. Do you wish to report any honors related to your aademic achievements?"),
              // buildAnswer(getFifthQuest, yesOrNo, fifthQuest),
              CustomRadio(handler: widget.fifthQuest, groupValue: yesOrNo, methodParent: () => print("Hello")),
              buildQuestion("6. Did you take any admission tests?"),
              // buildAnswer(getSixthQuest, yesOrNo, sixthQuest),
              CustomRadio(handler: widget.sixthQuest, groupValue: yesOrNo, methodParent: () => print("Hello")),
              buildQuestion("7. Please report up to 10 activities that can help colleges better understand your life outside of the classroom"),
              buildActivity([2, 1, 1], widget.activites2, ["Reading", "Sport", "Run"]),
              buildActivity([1, 2, 1], widget.activites2, ["Games", "Writing", "Walk"]),
              buildActivity([2, 1, 1], widget.activites2, ["Dancing", "TV", "Coding"]),
              buildQuestion("8. Please briefly elaborate on one of your extracurricular activitiesor work experiences."),
              Container(
                margin: const EdgeInsets.fromLTRB(23, 10, 23, 0),
                height: 160,
                child: TextFormField(

                  onChanged: (value) {
                    setState(() {
                      text = "${value.length}/160";
                    });
                  },
                  controller: widget.work,
                  expands: false,
                  maxLines: 8,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: const Color(0xffD2DAFF)
                  ),
                  decoration: InputDecoration(
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
        
              Container(
                margin: const EdgeInsets.fromLTRB(0, 7, 23, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: const Color(0xffD2DAFF)
                  )
                ),
              ),
              buildQuestion("9. Do you wish to provide details of circumstances or qualifications not reflected in the registration form"),
              CustomRadio(handler: widget.ninthQuest, groupValue: noOrYes, key: _key, methodParent: changeIsVisible,),
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
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: const Color(0xffD2DAFF)
                  ),
                  decoration: InputDecoration(
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
        
              Container(
                margin: const EdgeInsets.fromLTRB(0, 7, 23, 0),
                alignment: Alignment.centerRight,
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: const Color(0xffD2DAFF)
                  )
                ),
              ),
                  ],
                ),
              ),
              buildNavigation(context, widget.activites, () {
                widget.reg.uniActvity = widget.activites;
                widget.reg.place = widget.secondQuest.value;
                widget.reg.testScore = widget.thirdQuest.value;
                widget.reg.school = widget.controller.text;
                widget.reg.honors = widget.fifthQuest.value;
                // widget.reg.test = sixthQuest;
                widget.reg.addmisionTest = widget.sixthQuest.value;
                widget.reg.outActivity = widget.activites2;
                widget.reg.essayWorkExp = widget.work.text;
                if (widget.ninthQuest.value == "Yes") {
                  widget.reg.details = widget.work2.text;
                } else {
                  widget.reg.details = "No";
                }

                Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyEmail(email: widget.reg.email,)));
              }),

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

Row buildNavigation(BuildContext context, List<String> printable, Function()? onPress) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget> [
      Container(
        margin: const EdgeInsets.fromLTRB(20, 37, 0, 20),
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

