import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/dropdown.dart';
import 'package:sis_progress/data%20class/registration_data_grade10.dart';
import 'package:sis_progress/data%20class/registration_data_grade9.dart';
import 'package:sis_progress/page/grades/grade_9th_first.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drop_down.dart';
import 'package:sis_progress/widgets/input_box.dart';
import 'package:sis_progress/widgets/progress/progress_bar.dart';
import 'package:table_calendar/table_calendar.dart';
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
  final DropDownDataClass coutnry = DropDownDataClass();
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
  Color containNumber = const Color(0xffFE8F8F);
  Color containSmall = const Color(0xffFE8F8F);
  Color cotain8charecters = const Color(0xffFE8F8F);
  Color containSpecial = const Color(0xffFE8F8F);

  void changeColor() {
    capitalLetter = const Color(0xffFE8F8F);
    containNumber = const Color(0xffFE8F8F);
    containSmall = const Color(0xffFE8F8F);
    cotain8charecters = const Color(0xffFE8F8F);
    containSpecial = const Color(0xffFE8F8F);

    setState(() {
      if (widget.password.text.contains(RegExp(r'[0-9]'))) {
        containNumber = const Color(0xff94B49F);
      }

      if (widget.password.text.contains(RegExp(r'[A-Z]'))) {
        capitalLetter = const Color(0xff94B49F);
      }

      if (widget.password.text.contains(RegExp(r'[a-z]'))) {
        containSmall = const Color(0xff94B49F);
      }

      if (widget.password.text.contains(RegExp(r'[^\w\s]+')) &&
          widget.password.text.length >= 8) {
        cotain8charecters = const Color(0xff94B49F);
        containSpecial = const Color(0xff94B49F);
      }
    });
  }

  String fullNameErrorText = "";
  String emailErrorText = "";
  String gradeErrorText = "";
  String passwordErroText = "";
  String confirmPasswordErrorText = "";
  String phoneErrorText = "";
  String ageErroText = "";
  String countryErrorText = "";
  String phoneValue = "";

  bool showFullNameErrorText = false;
  bool showEmailValidation = false;
  bool showGradeErrorText = false;
  bool showpasswordErroText = false;
  bool showconfirmPasswordErrorText = false;
  bool showphoneErrorText = false;
  bool showageErroText = false;
  bool showcountryErrorText = false;

  bool showCalendar = false;

  OverlayEntry? overlayEntry;

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> years = [
    
  ];

  bool emailMatch(String email) {
    return emailRegex.hasMatch(email);
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

  String month = DateFormat("MMMM").format(DateTime.now());
  String year = DateTime.now().year.toString();

  

  @override
  Widget build(BuildContext context) {
    for (int i = 2023; i >= 1950; i--) {
      years.add(i.toString());
    }

    String initialCountry = 'NG';
    PhoneNumber number = PhoneNumber(isoCode: 'AM');

    double height = MediaQuery.of(context).size.height - 141;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // bottomNavigationBar: const NavBar(),
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Column(
        children: [
          Text(
            "It will take you 20 mins to Register.",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400, color: Colors.white, fontSize: 13),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xff3A3D4C),
                borderRadius: BorderRadius.circular(5)),
            width: double.infinity,
            height: height,
            margin: const EdgeInsets.fromLTRB(16, 25, 16, 20),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const ProgressBar(isPassed: [false, false, false]),
                  buildTitle(),
                  InputBox(
                    controller: widget.fullName,
                    context: context,
                    isPassword: false,
                    initialValue: "Full Name",
                    onChanged: (String val) {
                      print(val);
                    },
                    textInputType: TextInputType.text,
                    errorText: fullNameErrorText,
                    showValidationOrNot: showFullNameErrorText,
                  ),
                  // InputBox(
                  //   controller: widget.email,
                  //   context: context,
                  //   isPassword: false,
                  //   initialValue: "Email",
                  //   onChanged: (String val) {
                  //     print(val);
                  //   },
                  //   textInputType: TextInputType.emailAddress,
                  //   errorText: emailErrorText,
                  //   showValidationOrNot: showEmailValidation,
                  // ),
                  Container(
                    margin: EdgeInsets.fromLTRB(23, 25, 23, 0),
                    child: TextFormField(
                      // readOnly: true,
                      maxLines: 1,
                      autocorrect: false,
                      // initialValue: widget.initialValue,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          errorText:
                              showEmailValidation ?? false ? emailErrorText : null,
                          alignLabelWithHint: true,
                          labelText: "Email",
                          errorStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: const Color(0xffE31F1F)),
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
                              borderSide: BorderSide(
                                  color: Color(0xffD2DAFF), width: 1)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: color, width: 1)),
                          focusColor: const Color(0xffD2DAFF),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff36519D))),
                          suffixIcon: Container(
                            padding: const EdgeInsets.all(14),
                            height: 24,
                            width: 24,
                            child: Tooltip(
                              margin: const EdgeInsets.only(right: 15),
                              preferBelow: false,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0xff121623)
                              ),
                              textStyle: GoogleFonts.workSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: const Color(0xffBFBFBF)
                              ),
                              triggerMode: TooltipTriggerMode.tap,
                              message: "If you want to get a waiver/discount,\nyou need to provide your school\nemail",
                              child: SvgPicture.asset(
                                "assets/Tooltip.svg",
                                height: 24,
                                width: 24,
                                // color: Color(0xFF3A5A98),
                              ),
                            ),
                          )
                          // suffixIcon: GestureDetector(
                          //   onTap: () {
                          //     choosenDate = DateTime.now();
                          //     _dialogBuilder();
                          //   },
                          //   child: Icon(
                          //     Icons.calendar_month_outlined,
                          //     color: Colors.white,
                          //     size: 20,
                          //   ),
                          // )
                        ),

                      controller: widget.email,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                  ),
                  Focus(
                      onFocusChange: ((value) {
                        setState(() {
                          isVisible = value;
                        });
                      }),
                      child: InputBox(
                        controller: widget.password,
                        context: context,
                        isPassword: true,
                        initialValue: "Password",
                        onChanged: (String val) {
                          changeColor();
                        },
                        textInputType: TextInputType.text,
                        errorText: passwordErroText,
                        showValidationOrNot: showpasswordErroText,
                      )),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(31, 5, 23, 0),
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "A",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: capitalLetter,
                                    fontSize: 13)),
                            TextSpan(
                                text: "a",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: containSmall,
                                    fontSize: 13)),
                            TextSpan(
                                text: 123456.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: containNumber,
                                    fontSize: 13)),
                            TextSpan(
                                text: "*",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    color: containSpecial,
                                    fontSize: 13))
                          ]),
                        )),
                  ),
                  InputBox(
                    controller: widget.confirmPassword,
                    context: context,
                    isPassword: true,
                    initialValue: "Confirm Password",
                    onChanged: (String val) {
                      print(val);
                    },
                    textInputType: TextInputType.text,
                    errorText: confirmPasswordErrorText,
                    showValidationOrNot: showconfirmPasswordErrorText,
                  ),
                  // InputBox(controller: widget.phone, context: context, isPassword: false, initialValue: "Phone", onChanged: (String val) {print(val);}, textInputType: TextInputType.phone, errorText: phoneErrorText, showValidationOrNot: showphoneErrorText,),
                  Container(
                    margin: const EdgeInsets.fromLTRB(23, 30, 23, 0),
                    child: InternationalPhoneNumberInput(
                      textAlign: TextAlign.start,
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                        phoneValue = number.phoneNumber.toString();
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },

                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DROPDOWN,

                        // backgroundColor: Colors.black
                      ),
                      textStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),

                      inputDecoration: InputDecoration(
                        errorText: showphoneErrorText ? phoneErrorText : null,
                        // alignLabelWithHint: true,
                        labelText: "Phone",
                        errorStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: const Color(0xffE31F1F)),
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
                            borderSide:
                                BorderSide(color: Color(0xffD2DAFF), width: 1)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: color, width: 1)),
                        focusColor: const Color(0xffD2DAFF),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff36519D))),
                      ),
                      searchBoxDecoration: InputDecoration(
                        errorText: showphoneErrorText ? phoneErrorText : null,
                        alignLabelWithHint: true,
                        labelText: "Phone",
                        errorStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: const Color(0xffE31F1F)),
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
                            borderSide:
                                BorderSide(color: Color(0xffD2DAFF), width: 1)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: color, width: 1)),
                        focusColor: const Color(0xffD2DAFF),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff36519D))),
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: const Color(0xffD4D4D4)),

                      initialValue: number,
                      textFieldController: widget.phone,
                      formatInput: true,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      // inputBorder: OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  // InputBox(
                  //   controller: widget.age,
                  //   context: context,
                  //   isPassword: false,
                  //   initialValue: "Age",
                  //   onChanged: (String val) {
                  //     print(val);
                  //   },
                  //   textInputType: TextInputType.number,
                  //   errorText: ageErroText,
                  //   showValidationOrNot: showageErroText,

                  // ),
                  Container(
                    margin: EdgeInsets.fromLTRB(23, 25, 23, 0),
                    child: TextFormField(
                      readOnly: true,
                      maxLines: 1,
                      autocorrect: false,
                      // initialValue: widget.initialValue,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          errorText:
                              showageErroText ?? false ? ageErroText : null,
                          alignLabelWithHint: true,
                          labelText: "Age",
                          errorStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: const Color(0xffE31F1F)),
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
                              borderSide: BorderSide(
                                  color: Color(0xffD2DAFF), width: 1)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: color, width: 1)),
                          focusColor: const Color(0xffD2DAFF),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff36519D))),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // choosenDate = DateTime.now();
                              _dialogBuilder();
                            },
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          )),

                      controller: widget.age,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                  ),

                  // InputBox(controller: widget.country, context: context, isPassword: false, initialValue: "Country", onChanged: (String val) {print(val);}, textInputType: TextInputType.text, errorText: countryErrorText, showValidationOrNot: showcountryErrorText,),
                  // buildMode(widget.country, Universities().countryList, "Country", showcountryErrorText, countryErrorText),
                  // InputBox(controller: widget.grade, context: context, isPassword: false, initialValue: "Grade",),
                  CountryDropDown(
                    dropDownDataClass: widget.coutnry,
                    context: context,
                    onChange: (val) {
                      setState(() {
                        widget.coutnry.value = val;
                      });
                    },
                    showValidationOrNot: showcountryErrorText,
                    errorText: countryErrorText,
                  ),
                  DropDown(
                    context: context,
                    dropDownDataClass: widget.dropDown,
                    errorText: gradeErrorText,
                    showValidationOrNot: showGradeErrorText,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Button(
                      text: "Next",
                      height: 38,
                      width: double.infinity,
                      onPressed: () async {
                        if (widget.dropDown.value == "9th Grade") {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setString("email", widget.email.text);
                          prefs.setString("number", widget.phone.text);
                          prefs.setString("full name", widget.fullName.text);

                          widget.registration.fullName = widget.fullName.text;
                          widget.registration.email = widget.email.text;
                          widget.registration.password = widget.password.text;
                          widget.registration.phone = widget.phone.text;
                          widget.registration.country = widget.coutnry.value;
                          widget.registration.age = DateTime.parse(widget.age.text).toIso8601String();
                          widget.registration.grade = widget.dropDown.value;
                          // print(widget.registration.grade);

                          if (!emailMatch(widget.email.text)) {
                            setState(() {
                              showEmailValidation = true;
                              emailErrorText =
                                  "Email must be in the correct format";
                            });
                          } else {
                            setState(() {
                              showEmailValidation = false;
                            });
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Grade9thFirst(registration: widget.registration,)));
                          }

                          if (widget.password.text.length < 8) {
                            setState(() {
                              passwordErroText = "Please fill password field";
                              showpasswordErroText = true;
                            });
                          } else {
                            setState(() {
                              showpasswordErroText = false;
                            });
                          }

                          if (widget.confirmPassword.text.length < 8) {
                            setState(() {
                              confirmPasswordErrorText =
                                  "Please fill confirm password field";
                              showconfirmPasswordErrorText = true;
                            });
                          } else {
                            setState(() {
                              showconfirmPasswordErrorText = false;
                            });
                          }

                          if (widget.phone.text.length == 0) {
                            setState(() {
                              phoneErrorText = "Please fill phone field";
                              showphoneErrorText = true;
                            });
                          } else {
                            setState(() {
                              showphoneErrorText = false;
                            });
                          }

                          if (widget.age.text.length == 0) {
                            setState(() {
                              ageErroText = "Please fill age field";
                              showageErroText = true;
                            });
                          } else {
                            setState(() {
                              showageErroText = false;
                            });
                          }

                          if (widget.country.text.length == 0) {
                            setState(() {
                              countryErrorText = "Please fill age field";
                              showcountryErrorText = true;
                            });
                          } else {
                            setState(() {
                              showcountryErrorText = false;
                            });
                          }

                          if (!(showEmailValidation &&
                              showcountryErrorText &&
                              showageErroText &&
                              showpasswordErroText)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Grade9thFirst(
                                          registration: widget.registration,
                                        )));
                          }

                          // print(emailErrorText);

                          // if(showValidationOrNo && showEmailValidation) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Grade9thFirst(
                          //               registration: widget.registration,
                          //             )));
                          // }
                        } else if (widget.dropDown.value == "10th Grade") {
                          print(widget.age.text);
                          setState(() {
                            widget.reg10.fullName = widget.fullName.text;
                            widget.reg10.email = widget.email.text;
                            widget.reg10.password = widget.password.text;
                            widget.reg10.phone = phoneValue;
                            widget.reg10.country = widget.coutnry.value;
                            widget.reg10.age = DateFormat("MM/dd/yyyy").parse(widget.age.text).toIso8601String();
                            widget.reg10.grade = widget.dropDown.value;
                          });

                          print(widget.reg10.fullName);
                          print(widget.reg10.email);
                          print(widget.reg10.password);
                          print(widget.reg10.phone);
                          print(widget.reg10.age);
                          print(widget.reg10.country);
                          // print(widget.coutnry.value);
                          print(widget.reg10.grade);


                          if (!emailMatch(widget.email.text)) {
                            setState(() {
                              showEmailValidation = true;
                              emailErrorText =
                                  "Email must be in the correct format";
                            });
                          } else {
                            setState(() {
                              showEmailValidation = false;
                            });
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Grade9thFirst(registration: widget.registration,)));
                          }

                          if (widget.password.text.length < 8) {
                            setState(() {
                              passwordErroText = "Please fill password field";
                              showpasswordErroText = true;
                            });
                          } else {
                            setState(() {
                              showpasswordErroText = false;
                            });
                          }

                          if (widget.confirmPassword.text.length < 8) {
                            setState(() {
                              confirmPasswordErrorText =
                                  "Please fill confirm password field";
                              showconfirmPasswordErrorText = true;
                            });
                          } else {
                            setState(() {
                              showconfirmPasswordErrorText = false;
                            });
                          }

                          if (widget.phone.text.length == 0) {
                            setState(() {
                              phoneErrorText = "Please fill phone field";
                              showphoneErrorText = true;
                            });
                          } else {
                            setState(() {
                              showphoneErrorText = false;
                            });
                          }

                          if (widget.age.text.length == 0) {
                            setState(() {
                              ageErroText = "Please fill age field";
                              showageErroText = true;
                            });
                          } else {
                            setState(() {
                              showageErroText = false;
                            });
                          }

                          if (widget.coutnry.value == 0) {
                            setState(() {
                              countryErrorText = "Please fill country field";
                              showcountryErrorText = true;
                            });
                          } else {
                            setState(() {
                              showcountryErrorText = false;
                            });
                          }

                          // if(!(showEmailValidation && showcountryErrorText && showageErroText && showpasswordErroText)) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Grade10thFirst(
                          //               registration: widget.reg10,
                          //             )));
                          // // }
                          if ((showEmailValidation == false) && (showcountryErrorText == false) && (showageErroText == false) && (showpasswordErroText == false)) {
                                print((showEmailValidation &&
                              showcountryErrorText &&
                              showageErroText &&
                              showpasswordErroText));

                              // print()
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Grade10thFirst(
                                          registration: widget.reg10,
                                        )));
                          }

                          // if(showValidationOrNo && showEmailValidation) {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Grade10thFirst(registration: widget.reg10,)));
                          // }
                        } else {
                          setState(() {
                            showGradeErrorText = true;
                            gradeErrorText = "Please choose grade level";
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder() {
    DateTime choosenDate = DateTime.now();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: const Color(0xff121623),
                content: Container(
                      width: 100,
                      height: 220,
                      child: TableCalendar(
                            availableGestures: AvailableGestures.all,
                            daysOfWeekHeight: 30,
                            rowHeight: 30,
                            selectedDayPredicate: (day) => isSameDay(day, choosenDate),
                            onDaySelected: (selectedDay, focusedDay) {
                              state(() {
                                
                              });

                              state(() {
                                choosenDate = selectedDay;
                                widget.age.text = DateFormat("MM/dd/yyyy").format(choosenDate).toString();
                                // print(widget.age.text);
                                // updateEvent();
                                print(choosenDate);
                              });

                              state(() {
                                
                              });
                            },
                            calendarBuilders: CalendarBuilders(
                              selectedBuilder: (context, day, focusedDay) {
                                return Container(
                                  height: 38,
                                  width: 38,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white, width: 1)
                                  ),
                                  child: Text(
                                    "${day.day}",
                                    style:  GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white
                                    ),
                                  ),
                                );
                              },
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: const Color(0xffD2DAFF)
                              ),
                              weekendStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: const Color(0xffD2DAFF)
                              ),
                              dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
                            ),
                            firstDay: DateTime.utc(1946, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: choosenDate,
                            headerVisible: false,
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              leftChevronVisible: false,
                              rightChevronVisible: false,
                            ),
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: false,
                              defaultTextStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              todayDecoration: BoxDecoration(color: Colors.transparent),
                              holidayTextStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              weekendTextStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                    ),
                  
                  title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(9, 13, 0, 0),
                          child: DefaultTextStyle(
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white),
                            child: Text(
                              month,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                          child: PopupMenuButton(
                            onSelected: (val) {
                              // widget.onMonthSelect(
                              //     val.toString());
                              setState(() {
                                
                              });

                              state(() {
                                month = val;
                                choosenDate = DateTime(choosenDate.year, months.indexOf(month), choosenDate.day);
                                print(choosenDate);
                                widget.age.text = DateFormat("MM/dd/yyyy").format(choosenDate).toString();
                              });

                              setState(() {
                                
                              });
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/Vectorchevorn.png"),
                              size: 12,
                              color: Color(0xffBFBFBF),
                            ),
                            offset: const Offset(0, 0),
                            color: const Color(0xff3A3D4C),
                            itemBuilder: (BuildContext context) {
                              return months.map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    height: 15,
                                    value: value.toString(),
                                    child: Text(
                                      value.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                          color: Colors.white),
                                    ));
                              }).toList();
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 13, 9, 0),
                          child: DefaultTextStyle(
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white),
                            child: Text(
                              year,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                          child: PopupMenuButton(
                            constraints: const BoxConstraints.expand(width: 68, height: 150),
                            onSelected: (val) {
                              // widget.onMonthSelect(
                              //     val.toString());
                              // setState(() {

                              // });

                              state(() {
                                year = val;
                                choosenDate = DateTime(int.parse(year), choosenDate.month, choosenDate.day);
                                print(choosenDate);
                                widget.age.text = DateFormat("MM/dd/yyyy").format(choosenDate).toString();
                                setState(() {
                                  
                                });
                              });

                              // setState(() {
                              //   year = val;
                              //   choosenDate = DateTime(int.parse(year), choosenDate.month, choosenDate.day);
                              //   print(choosenDate);
                              //   widget.age.text = DateFormat("MM/dd/yyyy").format(choosenDate).toString();
                              // });

                              // setState(() {
                              //   // choosenDate = DateTime(int.parse(year), choosenDate.month, choosenDate.day);
                              // });
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/Vectorchevorn.png"),
                              size: 12,
                              color: Color(0xffBFBFBF),
                            ),
                            offset: const Offset(0, 0),
                            color: const Color(0xff3A3D4C),
                            itemBuilder: (BuildContext context) {
                              return years.map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    height: 15,
                                    value: value.toString(),
                                    child: Text(
                                      value.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 8,
                                          color: Colors.white),
                                    ));
                              }).toList();
                            },
                          ),
                        ),
                      ]
                    )
                   
                );
            }
          );
        }
      );
  }
}

Container buildMode(TextEditingController controller, List<String> items,
    String lableText, bool? showValidationOrNo, String errorText) {
  controller.text = lableText;
  return Container(
    margin: const EdgeInsets.fromLTRB(23, 25, 23, 0),
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
