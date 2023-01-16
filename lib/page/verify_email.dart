import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/login.dart';
import 'package:sis_progress/widgets/countdown.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/progress/progress_bar.dart';

import 'dashboard/scaffold_keeper.dart';

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

  @override
  Widget build(BuildContext context) {
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
                Button(text: "Verify your email", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }, height: 35, width: double.infinity),
    
                Container(
                  margin: const EdgeInsets.fromLTRB(5, 15, 20, 0),
                  child: IntrinsicHeight(
                    child: Stack(
                      children: <Widget> [
                        Align(
                          alignment: Alignment.center,
                          child: buildSendAgainButton(),
                        ),
                        
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
                )
              ],
            ),
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