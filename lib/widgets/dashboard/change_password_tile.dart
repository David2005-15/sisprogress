import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/widgets/custom_button.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 111,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const <BoxShadow>[
            BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
          ],
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xff272935),
                Color(0xff121623),
              ])),
      child: Column(
        children: <Widget> [
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            child: Text(
              "Change password",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xffD2DAFF)
              ),
            ),
          ),

          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Button(
              text: "Change",
              onPressed: () {},
              height: 38,
              width: 110,
            ),
          )
        ],
      ),
    );
  }
}
