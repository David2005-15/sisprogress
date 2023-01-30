import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/login.dart';
import 'package:sis_progress/widgets/countdown.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/progress/progress_bar.dart';


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
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(minutes: 5));
    _controller.forward();
  }

  bool sendAgain = false;
  bool isDisabled = true;
  int count = 0;
  String resetOrSendAgain = "Send verification link";


  void changeIsDiabled() {
    Future.delayed(const Duration(minutes: 2), () {
      setState(() {
        isDisabled = true;
      });
    }); 
  }


  @override
  Widget build(BuildContext context) {
    if(resetOrSendAgain == "Resend verification link") {
      changeIsDiabled();
    }

    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff3A3D4C),
            borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          height: double.infinity,
          // constraints: BoxConstraints.expand(),
          margin: const EdgeInsets.fromLTRB(16, 15, 16, 32),
          // alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                const ProgressBar(isPassed: [true, true, true],),
                buildTitle(),
                buildSubtitle(widget.email ?? ""),
                buildDescription(),
                Button(text: resetOrSendAgain, onPressed: isDisabled ? () {
                  if(resetOrSendAgain == "Resend verification link") {
                    _dialogBuilder(context, widget.email ?? "");
                  }
                  setState(() {
                    sendAgain = true;
                    resetOrSendAgain = "Resend verification link";
                    isDisabled = false;

                  });


                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
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
                            child: Countdown(
                              
                              animation: StepTween(
                                begin: 2 * 60,
                                end: 0
                              ).animate(_controller),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
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

                  

                  //
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     width: 104,
                  //     height: 36,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(5),
                  //       border: Border.all(
                  //         width: 2.0,
                  //         color: const Color(0xffD2DAFF),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       "Cancel",
                  //       style: GoogleFonts.poppins(
                  //         fontWeight: FontWeight.w400,
                  //         fontSize: 15,
                  //         color: const Color(0xffD2DAFF)
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              // alignment: Alignment.center,
              // child: ButtonBar(
              //   alignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //      TextButton(
              // style: TextButton.styleFrom(
              //   textStyle: Theme.of(context).textTheme.labelLarge,
              // ),
              // child: const Text('Disable'),
              // onPressed: () {
              //   Navigator.of(context).pop();
              // },
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //     b
            //   ),
            //    child: const Text('Enable'),
            //   onPressed: () {

            //     onSave();
            //     Navigator.pop(context);
            //   },
            // ),
          ],
        );
      },
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

TextButton buildSendAgainButton() {
  return TextButton(
    onPressed: () {
      
    },
    child: Text(
      "Send Again",
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: const Color(0xffBFBFBF)
      ),
    ),
  );
}

// void getHeight(BuildContext context) {
//   double height = MediaQuery.of(context).size.height;

//   print(height);
// }