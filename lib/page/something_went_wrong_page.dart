import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/login.dart';
import 'package:sis_progress/widgets/custom_button.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff121623)
      ),

      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          RichText(
              text: TextSpan(
                text: "OOPS!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: const Color(0xffFE8F8F)
                ),
                children: <InlineSpan> [
                  TextSpan(
                    text: " Something went wrong",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Colors.white
                    )
                  )
                ]
              )
          ),

          Button(
              text: "Back to login",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              height: 38,
              width: double.infinity
          )
        ],
      ),
    );
  }

}