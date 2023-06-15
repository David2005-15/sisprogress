import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/dropdown.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/dashboard/account_deletion.dart';
import 'package:sis_progress/page/home.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drop_down.dart';
import 'package:sis_progress/widgets/input_box.dart';
import 'package:table_calendar/table_calendar.dart';

class PersonalDetails extends StatelessWidget {
  final bool mode;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final String phone;
  final String email;
  final String age;
  final String country;
  final String name;

  PersonalDetails({
    required this.phone,
    required this.email,
    required this.onSave,
    required this.onEdit,
    required this.mode,
    required this.age,
    required this.country,
    required this.name,
    super.key
  });

  TextEditingController fullName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController secondaryMail = TextEditingController();
  TextEditingController verifyMail = TextEditingController();
  TextEditingController agecnt = TextEditingController();
  DropDownDataClass coutnry = DropDownDataClass();
  TextEditingController instagram = TextEditingController();


  bool isFullNameEmpty = false;
  bool isPhoneEmpty = false;


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

  String month = DateFormat("MMMM").format(DateTime.now());
  String year = DateTime(2008, DateTime.now().month).year.toString();

  List<String> years = List.generate(74, (i) => (2008 - i).toString());

  Client httpClient = Client();

  @override
  Widget build(BuildContext context) {
    mail.text = email;
    number.text = phone;
    agecnt.text = age;
    coutnry.value= country;
    fullName.text = name;

    return StatefulBuilder(
      builder: (context, state) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            onSave();
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const <BoxShadow> [
                BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
              ],
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color> [
                  Color(0xff272935),
                  Color(0xff121623),
                ]
              )
            ),
            child: Wrap(
              children: <Widget> [
                Column(
                  children: <Widget> [
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 13, 0, 0),
                      child: Text(
                        "Profile information",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xffD2DAFF)
                        ),
                      ),
                    ),
            
                    mode ? Container() : InkWell (
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: onEdit,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 15, 0),
                        child: Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.grey
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                  mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: fullName, isPassword: false, initialValue: "Full Name", disabledSymbols: true, showValidationOrNot: isFullNameEmpty, errorText: "Fill this field", disableNumbers: true,) : Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                        child: Text(
                          "Phone",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white
                          ),
                        ),
                      ),
                
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Text(
                          phone,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                
        
                mode ?  InputBox(textInputType: TextInputType.phone, onChanged: (val) {}, context: context, controller: number, isPassword: false, initialValue: "Phone", disabledSymbols: true, showValidationOrNot: isPhoneEmpty, errorText: "Fill this field",) : Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                        child: Text(
                          "Full Name",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white
                          ),
                        ),
                      ),
                
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Text(
                          name,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                mode ? Container(
                  margin: const EdgeInsets.fromLTRB(23, 20, 23, 0),
                  child: TextFormField(
                          readOnly: true,
                          maxLines: 1,
                          autocorrect: false,
                          // initialValue: widget.initialValue,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Birth date",
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
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffD4D4D4), width: 1)),
                              focusColor: const Color(0xffD2DAFF),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff36519D))),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _showCalendar(context);
                                },
                                child: const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )),
                
                          controller: agecnt,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                        ),
                )  : 
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                        child: Text(
                          "Birth date",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white
                          ),
                        ),
                      ),
                
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Text(
                          age,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                mode ? CountryDropDown(
                      dropDownDataClass: coutnry,
                      context: context,
                      onChange: (val) {
                        state(() {
                          coutnry.value = val;
                        });
                      },
                      showValidationOrNot: false,
                      errorText: "",
                    ) : Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                        child: Text(
                          "Country",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white
                          ),
                        ),
                      ),
                
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Text(
                          country,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.grey
                          ),
                        ),
                      )
                    ],
                  ),
                ),
               
                mode ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 38,
                      width: 128,
                      margin: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                      child: ElevatedButton(
                        onPressed: () {
                          onSave();
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
                    Button(text: "Change ", onPressed: () async {
                      var body = {
                        "fullName": fullName.text,
                        "phone": number.text,
                        "age": DateFormat("MM/dd/yyyy").parse(agecnt.text).toIso8601String(),
                        "country": coutnry.value,
                      };

                      if(fullName.text.isNotEmpty && number.text.isNotEmpty) {
                        await httpClient.updateUniversityAndAcademic(body).then((value) {
                          onSave();
                        });

                        message(context);
                      } else {
                        state(() {
                          if(fullName.text.isEmpty) {
                            isFullNameEmpty = true;
                          }

                          if(number.text.isEmpty) {
                            isPhoneEmpty = true;
                          }
                        });
                      }
                    }, height: 38, width: 128),
                  ],
                ): Container()
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 25, 2, 0),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.5, color: Color(0xffBFBFBF))
                        )
                      ),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          deleteAccount(context, true);
                        },
                        child: Text(
                          "Delete My account",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            color: Colors.red
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff3A3D4C)
                      ),
                      width: 18,
                      height: 18,
                      alignment: Alignment.center,
                      child: Tooltip(
                          preferBelow: false,
                          message: "Deleting your account will result in the immediate removal of all your associated data, eliminating any chance of recovery in the future.",
                          textStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: Colors.white
                          ),
                          triggerMode: TooltipTriggerMode.tap,
                          decoration: BoxDecoration(
                              color: const Color(0xff3A3D4C),
                              borderRadius: BorderRadius.circular(2)
                          ),
                          showDuration: const Duration(seconds: 10),
                          margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: const Icon(
                            Icons.question_mark_rounded,
                            color: Colors.white,
                            size: 16,
                          )
                      ),
                    )
                  ],
                ),

                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 10, 2, 0),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          deleteAccount(context, false);
                        },
                        child: Text(
                          "Deactivate My account",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              color: Colors.red
                          ),
                        ),
                      ),
                    ),

                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff3A3D4C)
                      ),
                      width: 18,
                      height: 18,
                      child: Tooltip(
                          preferBelow: false,
                          message: "Deactivating your account will put it on hold for a month before permanent deletion. Reactivate by logging in within this period to retain data. Note that your task time will still progress before deletion occurs.",
                          textStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 9,
                              color: Colors.white
                          ),
                          triggerMode: TooltipTriggerMode.tap,
                          decoration: BoxDecoration(
                              color: const Color(0xff3A3D4C),
                              borderRadius: BorderRadius.circular(2)
                          ),
                          showDuration: const Duration(seconds: 10),
                          margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                          child: const Icon(
                            Icons.question_mark_rounded,
                            color: Colors.white,
                            size: 16,
                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }

  void deleteAccount(BuildContext context, bool isDelete) {
    var reason = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff121623),
            title: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      isDelete ? "Account deletion" : "Account deactivation",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: const AlignmentDirectional(1, 1),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        deleteAccountInput(context, isDelete);
                      },
                      child: Text(
                        "Skip",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color(0xffBFBFBF)
                        )
                      )
                  ),
                )
              ],
            ),
            contentPadding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please type the reason why do you want to ${isDelete ? "delete": "deactivate"} your account.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white
                  ),
                ),

                Container(
                  height: 140,
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: reason,
                    expands: false,
                    maxLines: 8,
                    maxLength: 100,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: const Color(0xffD2DAFF)
                    ),

                    decoration: InputDecoration(
                      hintText: "Enter the reason",
                      hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          color: const Color(0xffD2DAFF)
                      ),
                      counterStyle: GoogleFonts.poppins(color: Colors.transparent),
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
                )
              ],
            ),
            actions: <Widget> [
              FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 38,
                      width: 110,
                      margin: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            side: const BorderSide(width: 1.5, color: Color(0xffD2DAFF))
                        ),
                        child: Text(
                            "Cancel",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: const Color(0xffD2DAFF)
                            )
                        ),
                      ),
                    ),
                    Button(text: "Next", onPressed: () {
                      Navigator.pop(context);
                      httpClient.addReason(reason.text, isDelete);
                      deleteAccountInput(context, isDelete);
                    }, height: 38, width: 110),
                  ],
                ),
              )
            ],
          );
        }
    );
  }

  void deleteAccountInput(BuildContext context, bool isDelete) {
    var password = TextEditingController();

    bool showPasswordErrorMessage = false;

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: const Color(0xff121623),
                title: Text(
                  isDelete ? "Account deletion": "Account deactivation",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${isDelete ? "Deleting": "Deactivating"} your account will result in the immediate removal of all your data, with no option for recovery. Please enter your password to initiate the ${isDelete ? "deletion": "deactivation"} process.\nYou will receive a confirmation email shortly.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.white
                      ),
                    ),

                    InputBox(textInputType: TextInputType.text, onChanged: (val) {state((){});}, context: context, controller: password, isPassword: true, disableSpace: true, initialValue: "Password", showValidationOrNot: showPasswordErrorMessage, errorText: "Invalid password",)
                  ]
                ),
                actions: <Widget> [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 38,
                          width: 110,
                          margin: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                side: const BorderSide(width: 1.5, color: Color(0xffD2DAFF))
                            ),
                            child: Text(
                                "Cancel",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: const Color(0xffD2DAFF)
                                )
                            ),
                          ),
                        ),
                        Button(text: "Next", onPressed: password.text.isEmpty ? null: ()  async {
                          var result = null;

                          if(isDelete) {
                            result = await httpClient.removeAccount(password.text);
                          } else {
                            result = await httpClient.deactivateAccount(password.text);
                          }

                          state(() {
                            showPasswordErrorMessage = false;
                          });

                          if(result == "invalid password") {
                            state(() {
                              showPasswordErrorMessage = true;
                            });
                          } else {
                            if(isDelete) {
                              Navigator.pop(context);
                              submitAccountDeletionRequest(context);
                            } else {
                              SharedPreferences.getInstance().then((value) {
                                value.setBool("auth", false);
                                value.remove("token");
                              });

                              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                            }

                          }

                        }, height: 38, width: 110),
                      ],
                    ),
                  )
                ],
              );
            }
          );
        }
    );
  }

  void submitAccountDeletionRequest(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff121623),
            title: Text(
              "Account deletion",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.white
              ),
            ),
            content: Container(
              margin: const EdgeInsets.fromLTRB(5, 15, 5, 5),
              child: Text(
                "Your account deletion request has been submitted. You will receive a confirmation email shortly. To complete the deletion process, please follow the instructions in the email.",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.white
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                height: 38,
                width: 110,
                margin: const EdgeInsets.fromLTRB(22, 20, 22, 15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    SharedPreferences.getInstance().then((value) {
                      value.setBool("auth", false);
                      value.remove("token");
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      side: const BorderSide(width: 1.5, color: Color(0xffD2DAFF))
                  ),
                  child: Text(
                      "Cancel",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: const Color(0xffD2DAFF)
                      )
                  ),
                ),
              ),
            ],
          );
        }
    );
  }

  void message(BuildContext context) {
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
                        "Your personal details are changed successfully.",
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

  Future<void> _showCalendar(BuildContext context) {
    DateTime choosenDate = DateTime(2008, DateTime.now().month);;

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
                                choosenDate = selectedDay;
                                agecnt.text = DateFormat("MM/dd/yyyy").format(choosenDate).toString();
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
                              todayDecoration: const BoxDecoration(color: Colors.transparent),
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
                              state(() {
                                month = val;
                                var value = 0;
                               
                                choosenDate = DateTime(choosenDate.year, months.indexOf(month) + 1, choosenDate.day);
                                print(choosenDate);
                                agecnt.text = DateFormat("MM/dd/yyyy").format(choosenDate).toString();
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
                                    height: 25,
                                    value: value.toString(),
                                    child: Text(
                                      value.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
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
                            constraints: const BoxConstraints.expand(width: 68, height: 200),
                            onSelected: (val) {

                              state(() { 
                                year = val;
                                choosenDate = DateTime(int.parse(year), choosenDate.month, choosenDate.day);
                                print(choosenDate);
                                agecnt.text = DateFormat("MM/dd/yyyy").format(choosenDate).toString();
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
                              return years.map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    height: 25,
                                    value: value.toString(),
                                    child: Text(
                                      value.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
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


Future<void> _addSecondaryEmail(BuildContext context, TextEditingController secondary, TextEditingController verify) {
  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xff121623),
        title: Text(
          "Add secondary email",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(    
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.white
          ),
        ),

        actions: <Widget> [
          Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => {},
        autocorrect: false,
        // initialValue: widget.initialValue,
        textAlignVertical: TextAlignVertical.center,
        
        decoration: InputDecoration(
          hintText: "Secondary email",
          alignLabelWithHint: true,
          errorStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: const Color(0xffE31F1F)
          ),
          // hintText: widget.hintText,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: const Color(0xffD2DAFF)
          ),
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: const Color(0xffD2DAFF)
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
          ),
          focusColor: const Color(0xffD2DAFF),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff36519D))
          ),

        ),
        controller: secondary,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          fontStyle: FontStyle.normal,
          color: Colors.white
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => {},
        autocorrect: false,
        
        // initialValue: widget.initialValue,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Confirm your password",
          alignLabelWithHint: true,
          errorStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: const Color(0xffE31F1F)
          ),
          // hintText: widget.hintText,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: const Color(0xffD2DAFF)
          ),
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: const Color(0xffD2DAFF)
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
          ),
          focusColor: const Color(0xffD2DAFF),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff36519D))
          ),

        ),
        controller: verify,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          fontStyle: FontStyle.normal,
          color: Colors.white
        ),
      ),
    ),
        Container(
          width: double.infinity,
          height: 36,
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff355CCA)
            ),
            child: Text(
              "Add",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white
              ),
            ),
            onPressed: () {

            },
          ),
        )
        ],
      );
    }
  );
}
 
Future<void> _dialogBuilder(BuildContext context, VoidCallback onSave,) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff121623),
          title: Text(
            'Are you sure to change your personal details?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
          ),
          // content: Text(
          //   'After you make a change, the tasks that have been already completed or in progress will not be deleted. ',
          //   textAlign: TextAlign.center,
          //   style: GoogleFonts.montserrat(
          //       fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white),
          // ),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(
                    width: 104,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff355CCA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      onPressed: () async {
                        onSave();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 104,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                  color: Color(0xffD2DAFF), width: 2))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }