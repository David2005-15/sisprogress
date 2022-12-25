import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/dropdown.dart';
import 'package:sis_progress/data%20class/registration_data_grade10.dart';
import 'package:sis_progress/data%20class/registration_data_grade9.dart';
import 'package:sis_progress/page/grades/grade_9th_first.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drop_down.dart';
import 'package:sis_progress/widgets/input_box.dart';
import 'package:sis_progress/widgets/progress/progress_bar.dart';
import 'grades/grade_10th_first.dart';


class Registration extends StatefulWidget {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController country = TextEditingController();
  final DropDownDataClass dropDown = DropDownDataClass();
  final RegistrationGrade9 registration = RegistrationGrade9();
  final RegistrationGrade10 reg10 = RegistrationGrade10();

  Registration({super.key});

  @override
  State<StatefulWidget> createState() => _Registration();
}


class _Registration extends State<Registration> {
  Color color = const Color(0xffD4D4D4);

  bool isVisible = false;

  Color capitalLetter = const Color(0xffFE8F8F);
  Color containNumber= const Color(0xffFE8F8F);
  Color containSmall = const Color(0xffFE8F8F);
  Color cotain8charecters = const Color(0xffFE8F8F);
  Color containSpecial = const Color(0xffFE8F8F);

  void changeColor() {
    capitalLetter = const Color(0xffFE8F8F);
    containNumber= const Color(0xffFE8F8F);
    containSmall = const Color(0xffFE8F8F);
    cotain8charecters = const Color(0xffFE8F8F);
    containSpecial = const Color(0xffFE8F8F);

    setState(() {
      if(widget.password.text.contains(RegExp(r'[0-9]'))) {
        containNumber = const Color(0xff94B49F);
      }
      
      if(widget.password.text.contains(RegExp(r'[A-Z]'))) {
        capitalLetter = const Color(0xff94B49F);
      }

      if(widget.password.text.contains(RegExp(r'[a-z]'))) {
        containSmall = const Color(0xff94B49F);
      }

      if(widget.password.text.contains(RegExp(r'[^\w\s]+')) && widget.password.text.length >= 8) {
        cotain8charecters = const Color(0xff94B49F);
        containSpecial = const Color(0xff94B49F);
      }
    });
  }

  // void changeValidation() {
  //   setState(() {
  //     length8 = false;
  //     hasNumber = false;
  //     hasCapital = false;
  //     hasSmall = false;

  //     if(widget.password.text.length >= 8) {
  //       length8 = true;
  //     }

  //     if(widget.password.text.contains(RegExp(r'[0-9]'))) {
  //       hasNumber = true;
  //     }

  //     if(widget.password.text.contains(RegExp(r'[A-Z]'))) {
  //       hasCapital = true;
  //     }

  //     if(widget.password.text.contains(RegExp(r'[a-z]'))) {
  //       hasSmall = true;
  //     }
  //   });
  // }

  // void changeColor() {
  //   setState(() {
  //     color = const Color(0xffFE8F8F);

  //     if(length8 == true && hasNumber == true && hasCapital == true && hasSmall == true) {
  //       color = const Color(0xff94B49F);
  //     } else {
  //       color = const Color(0xffFE8F8F);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: const NavBar(),
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xff3A3D4C),
          borderRadius: BorderRadius.circular(5)
        ),
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 32),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              const ProgressBar(isPassed: [false, false, false]),
              buildTitle(),
              InputBox(controller: widget.fullName, context: context, isPassword: false, initialValue: "Full Name", onChanged: (String val) {print(val);}, textInputType: TextInputType.text),
              InputBox(controller: widget.email, context: context, isPassword: false, initialValue: "Email", onChanged: (String val) {print(val);}, textInputType: TextInputType.emailAddress),
              Focus(onFocusChange: ((value) {
                setState(() {
                  isVisible = value;
                });
              }), child: InputBox(controller: widget.password, context: context, isPassword: true, initialValue: "Password", onChanged: (String val) {changeColor();}, textInputType: TextInputType.text)),
              Visibility(
                visible: isVisible,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(31, 5, 23, 0),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan> [
                          TextSpan(text: "A", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: capitalLetter,
                            fontSize: 13
                          )),
                          TextSpan(text: "a", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: containSmall,
                            fontSize: 13
                          )),
                          TextSpan(text: 123456.toString(), style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: containNumber,
                            fontSize: 13
                          )),
                          TextSpan(text: "*", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: containSpecial,
                            fontSize: 13
                          ))
                        ]
                      ),
                    )
                  ),
              ),
              InputBox(controller: widget.confirmPassword, context: context, isPassword: true, initialValue: "Confirm Password", onChanged: (String val) {print(val);}, textInputType: TextInputType.text),
              InputBox(controller: widget.phone, context: context, isPassword: false, initialValue: "Phone", onChanged: (String val) {print(val);}, textInputType: TextInputType.phone),
              InputBox(controller: widget.age, context: context, isPassword: false, initialValue: "Age", onChanged: (String val) {print(val);}, textInputType: TextInputType.number),
              InputBox(controller: widget.country, context: context, isPassword: false, initialValue: "Country", onChanged: (String val) {print(val);}, textInputType: TextInputType.text),
              // InputBox(controller: widget.grade, context: context, isPassword: false, initialValue: "Grade",),
              DropDown(context: context, dropDownDataClass: widget.dropDown),
              Button(text: "Next", height: 38, width: double.infinity, onPressed: () {
                if(widget.dropDown.value == "9th Grade") {
                  widget.registration.fullName = widget.fullName.text;
                  widget.registration.email = widget.email.text;
                  widget.registration.password = widget.password.text;
                  widget.registration.phone = widget.phone.text;
                  widget.registration.country = widget.country.text;
                  widget.registration.age = widget.age.text;
                  widget.registration.grade = widget.dropDown.value;
                  print(widget.registration.grade);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Grade9thFirst(registration: widget.registration,)));
                } else if(widget.dropDown.value == "10th Grade") {
                  widget.reg10.fullName = widget.fullName.text;
                  widget.reg10.email = widget.email.text;
                  widget.reg10.password = widget.password.text;
                  widget.reg10.phone = widget.phone.text;
                  widget.reg10.country = widget.country.text;
                  widget.reg10.age = widget.age.text;
                  widget.reg10.grade = widget.dropDown.value;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Grade10thFirst(registration: widget.reg10,)));
                }
              },)
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
    alignment: Alignment.center,
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


  