import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordCheck extends StatefulWidget {
  final String password;
  final Color color;
  final double value;
  final List<Color> validation;

  const PasswordCheck({
    required this.validation,
    required this.color,
    required this.value,
    required this.password,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Test();

}

class _Test extends State<PasswordCheck> {
  double passwordStrength = 0;

  void getPasswordStrength() {
    setState(() {
      passwordStrength = widget.value * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    getPasswordStrength();

    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 11),
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                "Password strength $passwordStrength%",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: widget.value,
                backgroundColor: const Color(0xffBFBFBF),
                minHeight: 5,
                color: widget.color,
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget> [
                  buildText("At least 8 charectes", widget.validation[0]),
                  buildText("At least 1 small letter", widget.validation[1]),
                  buildText("At least 1 capital letter", widget.validation[2]),
                  buildText("At least one number", widget.validation[3])
                ],
              ),
            )
          ],
        ),
      );
  }
}

Row buildText(String text, Color iconColor ) {
  return Row(
    children: <Widget> [
      Icon(Icons.check, color: iconColor, size: 8,),
      Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white 
          ),
        ),
      )
    ],
  );
}