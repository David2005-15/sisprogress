import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkRow extends StatelessWidget {
  const NetworkRow({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(23, 26, 23, 0),
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: <Widget> [
            Container(
              width: double.infinity,
              height: 2,
              decoration: const BoxDecoration(
                color: Color(0xff121623)
              ),
            ),

            Container(
              width: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xff3A3D4C)
              ),
              child: Text(
                "Or",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: const Color(0xff121623)
                ),
              ),
            ),
          ],
        ),

        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Container(
                margin: const EdgeInsets.fromLTRB(7.5, 20, 7.5, 0),
                child: const Icon(
                  Icons.facebook_outlined, 
                  color: Color(0xff355CCA),
                  size: 30,
                )
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(7.5, 20, 7.5, 0),
                child: const Icon(
                  Icons.facebook_outlined, 
                  color: Color(0xff355CCA),
                  size: 30,
                )
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(7.5, 20, 7.5, 0),
                child: const Icon(
                  Icons.facebook_outlined, 
                  color: Color(0xff355CCA),
                  size: 30,
                )
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(7.5, 20, 7.5, 0),
                child: const Icon(
                  Icons.facebook_outlined, 
                  color: Color(0xff355CCA),
                  size: 30,
                )
              ),
            ],
          ),
        )
      ],
    ),
  );
}
}
