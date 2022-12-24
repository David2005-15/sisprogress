import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/progress/progress_bar.dart';

class GoToDashboard extends StatefulWidget {
  const GoToDashboard({super.key});

  @override
  State<StatefulWidget> createState() => _GoToDshbard();

}

class _GoToDshbard extends State<GoToDashboard> {
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
        margin: const EdgeInsets.fromLTRB(16, 200, 16, 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            const ProgressBar(isPassed: [true, true, true],),
            buildTitle(),
            Button(text: "Go to your dashboard", onPressed: () {}, height: 38, width: double.infinity)
           ],
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
    margin: const EdgeInsets.fromLTRB(0, 50, 0, 30),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              "You have filled the registration form",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white
              ),
            ),
          ),

          Text(
            "form successfully.",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.white
            ),
          )
        ],
      )
    ),
  );
}