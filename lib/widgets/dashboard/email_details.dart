import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import '../input_box.dart';

class Emaildetails extends StatefulWidget {
  bool mode;
  final String email;
  final VoidCallback updateStates;
  String? secondaryEmail;

  Emaildetails(
      {required this.mode,
      required this.email,
      required this.secondaryEmail,
      required this.updateStates,
      super.key});

  @override
  State<StatefulWidget> createState() => _Emaildetails();
}
//
class _Emaildetails extends State<Emaildetails> {
  late TextEditingController primaryEmail;
  var secondaryEmail = TextEditingController();
  late bool isSecondaryEmail;
//
  Client httpClient = Client();


  bool selectedFirst = false;
  bool selectedSecond = false;
  bool flag = false;
  int value = 0;

  @override
  void initState() {
    value = 0;
    primaryEmail = TextEditingController(text: widget.email);

    isSecondaryEmail =
        (widget.secondaryEmail != "empty") || (widget.secondaryEmail != null);
    primaryEmail.text = widget.email;
    secondaryEmail.text = widget.secondaryEmail!;

    super.initState();
  }

  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool emailMatch(String email) {
    return emailRegex.hasMatch(email);
  }

  bool showEmailValidation = false;
  bool showSecondaryEmailValidation = false;

  @override
  Widget build(BuildContext context) {
    flag = widget.secondaryEmail != "empty";

    return StatefulBuilder(builder: (context, state) {
      state(() {
        debugPrint(secondaryEmail.text);
        if (value == 0 && secondaryEmail.text == "") {
          primaryEmail.text = widget.email;
          secondaryEmail.text = widget.secondaryEmail!;
        }
      });

      return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          if (widget.mode == true) {
            state(() {
              widget.mode = false;
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xff272935),
                    Color(0xff121623),
                  ])),
          child: Wrap(
            children: [
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 13, 0, 0),
                        child: Text(
                          "Email Details",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: const Color(0xffD2DAFF)),
                        ),
                      ),
                      widget.mode
                          ? Container()
                          : InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                state(() {
                                  widget.mode = !widget.mode;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 13, 15, 0),
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Colors.grey),
                                ),
                              ),
                            )
                    ],
                  ),
                  widget.mode
                      ? Column(
                          children: [
                            InputBox(
                              showValidationOrNot: showEmailValidation,
                              errorText: "Invalid email format",
                              textInputType: TextInputType.text,
                              onChanged: (val) {},
                              context: context,
                              controller: primaryEmail,
                              isPassword: false,
                              initialValue: "Primary Email (Log in)",
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  buillRadiobutton(() {
                                    state(() {
                                      selectedFirst = !selectedFirst;
                                    });
                                  }, selectedFirst),
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(
                                      "Get notifications on this email",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11,
                                          color: const Color(0xffBFBFBF)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(),
                                Button(
                                    text: "Update",
                                    onPressed: () {
                                      if (!emailMatch(primaryEmail.text)) {
                                        setState(() {
                                          showEmailValidation = true;
                                        });
                                      } else {
                                        setState(() {
                                          showEmailValidation = false;
                                        });

                                        httpClient.sendUpdateEmail(
                                            primaryEmail.text, "First");
                                        successMessage(primaryEmail.text);
                                      }
                                    },
                                    height: 38,
                                    width: 116)
                              ],
                            )
                          ],
                        )
                      : Container(
                          margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                                child: Text(
                                  "Primary Email",
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: Text(
                                  widget.email,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                  widget.mode
                      ? secondaryEmail.text != "empty"
                          ? Column(
                              children: [
                                InputBox(
                                  textInputType: TextInputType.text,
                                  errorText: "Invalid email format",
                                  showValidationOrNot: showSecondaryEmailValidation,
                                  onChanged: (val) {},
                                  context: context,
                                  controller: secondaryEmail,
                                  isPassword: false,
                                  initialValue: "Secondary Email",
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(26, 0, 0, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      buillRadiobutton(() {
                                        state(() {
                                          selectedSecond = !selectedSecond;
                                        });
                                      }, selectedSecond),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 0),
                                        child: Text(
                                          "Get notifications on this email",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              color: const Color(0xffBFBFBF)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(),
                                    Button(
                                        text: "Update",
                                        onPressed: () {
                                          // httpClient.sendUpdateEmail(
                                          //     secondaryEmail.text, "Secondary");
                                          // successMessage(secondaryEmail.text);
                                          if (!emailMatch(secondaryEmail.text)) {
                                            state(() {
                                              showSecondaryEmailValidation = true;
                                            });
                                          } else {
                                            state(() {
                                              showSecondaryEmailValidation = false;
                                            });

                                            httpClient.sendUpdateEmail(
                                                secondaryEmail.text, "Secondary");
                                            successMessage(secondaryEmail.text);
                                          }
                                        },
                                        height: 38,
                                        width: 116)
                                  ],
                                )
                              ],
                            )
                          : Container()
                      : Container(),
                  widget.mode
                      ? Container()
                      : secondaryEmail.text != "empty" && secondaryEmail.text != "Secondary Email"
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 0, 15, 0),
                                    child: Text(
                                      "Secondary Email",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                  ),

                                  Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    child: Text(
                                      widget.secondaryEmail!,
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                  widget.mode
                      ? secondaryEmail.text != "empty"
                          ? InkWell(
                              onTap: () {
                                state(() {
                                  httpClient.removeSecondaryMail();
                                  secondaryEmail.text = "empty";
                                  widget.updateStates();
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.remove,
                                      size: 15,
                                      color: Color(0xff355CCA),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        "Remove secondary email",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: const Color(0xff355CCA)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                state(() {
                                  secondaryEmail.text = "Secondary Email";
                                  value += 1;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Color(0xff355CCA),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Text(
                                        "Add secondary email",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: const Color(0xff355CCA)),
                                      ),
                                    ),
                                    Tooltip(
                                      triggerMode: TooltipTriggerMode.tap,
                                      decoration: BoxDecoration(
                                          color: const Color(0xff646464),
                                          borderRadius:
                                              BorderRadius.circular(2)),
                                      textStyle: GoogleFonts.workSans(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: Colors.white),
                                      message:
                                          "By adding a email address,\nyou can receive messages from\nthe program to that email․",
                                      child: SvgPicture.asset(
                                        "assets/Greyquest.svg",
                                        height: 20,
                                        width: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                      : Container()
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Future successMessage(String which) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xff121623),
              content: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: const Color(0xff355CCA)),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  'Verification link sent to this $which email',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    Button(
                        text: "OK",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        height: 36,
                        width: 145)
                  ],
                ),
              ),
            );
          });
        });
  }

  Future changeEmail(String email, String whichEmail) {
    bool _onEditing = true;
    String? _code;

    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: const Color(0xff121623),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(),
                    Center(
                      child: Text(
                        "Verify your email",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                    _getUpdateCloseButton(context, () {})
                  ],
                ),
                content: SizedBox(
                  height: 300,
                  child: Column(
                    children: <Widget>[
                      buildSubtitle(email),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: VerificationCode(
                          digitsOnly: false,
                          textStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white),
                          // length: 6,
                          keyboardType: TextInputType.number,
                          underlineColor: const Color(0xffD2DAFF),
                          underlineUnfocusedColor: const Color(0xffD2DAFF),
                          // If this is null it will use primaryColor: Colors.red from Theme
                          length: 6,
                          cursorColor: Colors.blue,
                          onCompleted: (String value) {
                            state(() {
                              _code = value;
                            });
                          },
                          onEditing: (bool value) {
                            state(() {
                              _onEditing = value;
                            });
                            if (!_onEditing) FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                      Button(
                          text: "Submit",
                          onPressed: _code != null
                              ? () {
                                  state(() {
                                    httpClient.sendCode(email, _code!);
                                    Navigator.pop(context);
                                    successMessage(whichEmail);
                                  });
                                }
                              : null,
                          height: 36,
                          width: 175),
                      Column(
                        children: <Widget>[
                          Text(
                            "Haven't received your verification code yet?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xffD4D4D4)),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text("Resend Again",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: const Color(0xffD2DAFF),
                                      decoration: TextDecoration.underline)))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _getUpdateCloseButton(context, VoidCallback updateState) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: GestureDetector(
        child: Container(
          alignment: FractionalOffset.topRight,
          child: GestureDetector(
            child: const Icon(
              Icons.clear,
              color: Color(0xff646464),
              size: 12.5,
            ),
            onTap: () {
              Navigator.pop(context);
              updateState();
            },
          ),
        ),
      ),
    );
  }

  Container buildSubtitle(String email) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
      alignment: Alignment.center,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "You have entered ",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.white),
              children: <TextSpan>[
                TextSpan(
                    text: email,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: const Color(0xffFCD2D1))),
                const TextSpan(text: " as the email address for your account")
              ])),
    );
  }

  buillRadiobutton(VoidCallback onTap, bool selected) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 15, 0),
      width: 20,
      height: 20,
      alignment: Alignment.center,
      child: InkWell(
        // key: UniqueKey(),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                  width: 1,
                  color: selected
                      ? const Color(0xff355CCA)
                      : const Color(0xffBFBFBF))),
          child: Icon(
            Icons.circle,
            size: 14,
            color: selected ? const Color(0xff355CCA) : Colors.transparent,
          ),
        ),
      ),
    );
  }
}
