import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreTile extends StatelessWidget {
  const ExploreTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 190,
      margin: const EdgeInsets.fromLTRB(12, 14, 12, 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xFFD2DAFF),
      ),
      child: Stack(
        children: <Widget> [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: const Image(
                image: AssetImage("assets/Rectangle 1114.png"),
                fit: BoxFit.contain
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: (190 / 2) - 12,
              child: Stack(
                children: <Widget> [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          "Title of the task",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color(0xff2E2323)
                          ),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget> [
                        Container(
                          margin: const EdgeInsets.fromLTRB(17, 0, 7, 0),
                          child: const Icon(Icons.calendar_month, size: 11, color: Color(0xff2E2323),)
                        ),
                        Text(
                          "0/10",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: const Color(0xff2E2323)
                          ),
                        )
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 4, 8),
                      height: 23,
                      width: 73,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff355CCA)
                        ),
                        child: const Text("ADD"),
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }

}