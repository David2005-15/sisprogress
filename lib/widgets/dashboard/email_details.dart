import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/login.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import '../input_box.dart';

class Emaildetails extends StatefulWidget {
  bool mode;
  final String email;
  final VoidCallback updateStates;
  String? secondaryEmail;
  bool isVerified;

  Emaildetails(
      {required this.mode,
      required this.email,
      required this.secondaryEmail,
      required this.updateStates,
        required this.isVerified,
      super.key});

  @override
  State<StatefulWidget> createState() => _Emaildetails();
}

//
class _Emaildetails extends State<Emaildetails> {
  late TextEditingController primaryEmail;
  var secondaryEmail = TextEditingController();
  late bool isSecondaryEmail;
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
                          "Contact information",
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
                              onChanged: (val) {
                                state(() {

                                });
                              },
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
                                Container(
                                  height: 38,
                                  width: 128,
                                  margin:
                                      const EdgeInsets.fromLTRB(22, 20, 22, 10),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      state(() {
                                        widget.mode = false;
                                        primaryEmail.text = widget.email;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        side: const BorderSide(
                                            width: 1.5,
                                            color: Color(0xffD2DAFF))),
                                    child: Text("Discard",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                            color: const Color(0xffD2DAFF))),
                                  ),
                                ),
                                Button(
                                    text: "Update",
                                    onPressed: primaryEmail.text != widget.email ? () {
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
                                        successMessage(primaryEmail.text, false);
                                      }
                                    }: null,
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
                                  showValidationOrNot:
                                      showSecondaryEmailValidation,
                                  onChanged: (val) {
                                    setState(() {

                                    });
                                  },
                                  context: context,
                                  controller: secondaryEmail,
                                  isPassword: false,
                                  initialValue: "Secondary Email",
                                ),

                                !widget.isVerified ? Container(
                                  margin: const EdgeInsets.fromLTRB(28, 5, 0, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Tooltip(
                                        preferBelow: false,
                                        message: "Important! Please verify your new email address /${secondaryEmail.text}/. Until it is verified, you will continue to use your original email address. You can delete the unverified email address or change it in your account settings.",
                                        textStyle: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 9,
                                          color: Colors.white
                                        ),
                                        triggerMode: TooltipTriggerMode.tap,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffE31F1F),
                                          borderRadius: BorderRadius.circular(2)
                                        ),
                                        showDuration: const Duration(seconds: 10),
                                        margin: EdgeInsets.fromLTRB(20, 0, MediaQuery.of(context).size.width/2, 0),
                                        child: const Icon(
                                          Icons.error_outlined,
                                          color: Color(0xffE31F1F),
                                          size: 16,
                                        )
                                      ),
                                      Text(
                                        "   New email address not verified",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 9,
                                          color: const Color(0xffE31F1F)
                                        ),
                                      )
                                    ],
                                  ),
                                ): Container(),

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
                                    Container(
                                      height: 38,
                                      width: 128,
                                      margin: const EdgeInsets.fromLTRB(
                                          22, 20, 22, 10),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          state(() {
                                            widget.mode = false;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            side: const BorderSide(
                                                width: 1.5,
                                                color: Color(0xffD2DAFF))),
                                        child: Text("Discard",
                                            style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color:
                                                    const Color(0xffD2DAFF))),
                                      ),
                                    ),
                                    Button(
                                        text: "Update",
                                        onPressed: (widget.secondaryEmail  == secondaryEmail.text) ? null : () {
                                          if (!emailMatch(
                                              secondaryEmail.text)) {
                                            state(() {
                                              showSecondaryEmailValidation =
                                                  true;
                                            });
                                          } else {
                                            state(() {
                                              showSecondaryEmailValidation =
                                                  false;
                                            });

                                            httpClient.sendUpdateEmail(
                                                secondaryEmail.text,
                                                "Secondary");
                                            successMessage(secondaryEmail.text, true);
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
                      : secondaryEmail.text != "empty" &&
                              secondaryEmail.text != "Secondary Email"
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

  Future successMessage(String which, bool isSecondary) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xff121623),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Verification link sent to ',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                            text: which,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: const Color(0xffFCD2D1))),
                        TextSpan(
                            text: " email",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white))
                      ],
                    ),
                  ),
                  Button(
                      text: "OK",
                      onPressed: () {
                        Navigator.pop(context);
                        if(!isSecondary) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        }
                      },
                      height: 36,
                      width: 145)
                ],
              ),
            );
          });
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
