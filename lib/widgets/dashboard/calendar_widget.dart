import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarWidget extends StatelessWidget {
  String value;
  List<int> years;
  Function(String) onSelected;

  CalendarWidget({
    required this.onSelected,
    required this.value,
    required this.years,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: "December ",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: const Color(0xffB1B2FF)
                  ),
                  children: <TextSpan> [
                    TextSpan(
                      text: "4, $value",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: const Color(0xffB1B2FF)
                      )
                    )
                  ]
                ),
              ),

              PopupMenuButton(
                onSelected: onSelected,
                offset: Offset(20, 50),
                icon: Icon(
                  Icons.arrow_back_outlined, 
                  color: const Color(0xffB1B2FF)
                ),
                color: const Color(0xff3A3D4C),
                itemBuilder: (BuildContext context) {  
                  return years.map<PopupMenuItem<String>>((int value) {
                    return PopupMenuItem(value: value.toString(), child: Text(value.toString(), style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white
                    ),));
                  }
                ).toList();},
              )
            ],
          ),
        ],
      )
    );
  }
}