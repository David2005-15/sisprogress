import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/home.dart';
import 'package:sis_progress/page/login.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/progress/progress_bar.dart';

import '../http client/http_client.dart';


class VerifyEmail extends StatefulWidget {
  final String? email;

  const VerifyEmail({
    required this.email,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _VerifyEmail();

}

class _VerifyEmail extends State<VerifyEmail> with SingleTickerProviderStateMixin{
  Client httpClient = Client();

  @override
  void initState() {
    super.initState();
  }

  bool sendAgain = false;
  bool isDisabled = true;
  int count = 0;
  String resetOrSendAgain = "Send verification link";

  int timer = 30;
  String time = "0:30";

  void startTimer () {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if(timer != 0) {
          timer--;
        }
        time = "0:$timer";
      });
    });
  }


  void changeIsDiabled() {
    Future.delayed(const Duration(seconds: 30), () {
      setState(() {
        isDisabled = true;
      });
    }); 

    setState(() {
      if(timer == 0) {
        isDisabled = true;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if(resetOrSendAgain == "Resend verification link") {
      changeIsDiabled();
    }

    if(sendAgain) {
      startTimer();
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

        return Future.value(true);
      },
      child: Scaffold(
        appBar: CustomAppBar(buildLogoIcon(context), List.empty()),
        body: Container(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff3A3D4C),
              borderRadius: BorderRadius.circular(5)
            ),
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 15, 16, 32),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget> [
                  const ProgressBar(isPassed: [true, true, true],),
                  buildTitle(),
                  buildSubtitle(widget.email ?? ""),
                  buildDescription(),
                  Button(text: resetOrSendAgain, onPressed: isDisabled ? () {

                    httpClient.sendVerificationLink(widget.email!);
                    if(resetOrSendAgain == "Resend verification link") {
                      _dialogBuilder(context, widget.email ?? "");
                    }
                    setState(() {
                      sendAgain = true;
                      resetOrSendAgain = "Resend verification link";
                      isDisabled = false;

                    });
                  } : null, height: 35, width: double.infinity),

                  Visibility(
                    visible: sendAgain,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(5, 15, 20, 0),
                      child: IntrinsicHeight(
                        child: Stack(
                          children: <Widget> [
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                time,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: const Color(0xffB1B2FF),
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: sendAgain,
                    child: Button(text: "Back to login", onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }, height: 36, width: double.infinity),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, String email) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff121623),
          content: Text(
            'A letter has been sent to your email address $email, you can confirm it within 24 hours, otherwise it will be expired. If you havent received the email yet, you can check the spam section or resend the email.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white),
          ),
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
                      onPressed: () {
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
                ],
              ),
            ),
          ],
        );
      },
    );
  }

}

InkWell buildLogoIcon(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (build) => const HomePage()),);
    },
    child: Image.asset(
      "assets/logo.png",
    ),
  );
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Verify your email address",
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

Container buildSubtitle(String email) {
  return Container(
    margin: const EdgeInsets.fromLTRB(24, 15, 24, 0),
    alignment: Alignment.center,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "You have entered ",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: Colors.white
        ),
        children: <TextSpan> [
          TextSpan(
            text: email,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: const Color(0xffFCD2D1)
            )
          ),
          const TextSpan(text: " as the email address for your account")
        ]
      )
    ),
  );
}

Container buildDescription() {
  return Container(
    margin: const EdgeInsets.fromLTRB(26, 25, 26, 0),
    alignment: Alignment.center,
    child: Text(
      "Please verify this email address by clicking button below.",
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        color: Colors.white
      ),
    ),
  );
}
