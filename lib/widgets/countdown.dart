import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Countdown extends AnimatedWidget {
  Countdown({super.key, required this.animation}) : super(listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
   

    return Text(
        timerText,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: const Color(0xffB1B2FF),
        ),
    );
  }
}