import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final String text;
  EdgeInsets? margin;

  Button({
    this.margin,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.fromLTRB(22, 20, 22, 10),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow> [
          BoxShadow(offset: const Offset(0, 30), spreadRadius: 0, blurRadius: 30, color: Colors.black.withOpacity(0.25))
        ]
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff355CCA),
          disabledBackgroundColor: const Color(0xff355CCA).withOpacity(0.25),
          disabledForegroundColor: Colors.white.withOpacity(0.25),
          textStyle: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white
          )
        ),
        
        child: Text(text),
      ),
    );
  }
}