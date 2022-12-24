import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressBar extends StatefulWidget {
  final EdgeInsets porgressMargin = const EdgeInsets.fromLTRB(25, 20, 25, 0);
  final List<bool> isPassed;

  const ProgressBar({super.key, required this.isPassed});

  @override
  State<StatefulWidget> createState() => _ProgressBar();

}

class _ProgressBar extends State<ProgressBar> {


  @override
  Widget build(BuildContext context) {
    List<Color> colors = getCircleColor(widget.isPassed);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        Container(
          alignment: Alignment.center,
          margin: widget.porgressMargin,
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: colors[0])
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "1",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: colors[0]
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: widget.porgressMargin,
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: colors[1])
          ),

          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "2",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: colors[1]
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: widget.porgressMargin,
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2, color: colors[2])
          ),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              "3",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontStyle: FontStyle.normal,
                color: colors[2]
              ),
            ),
          ),
        )
      ],
    );
  }
}

List<Color> getCircleColor(List<bool> stagePass) {
  List<Color> circleColor = [];

  for(int i = 0; i < stagePass.length; i++) {
    if(stagePass[i] == true) {
      circleColor.add(const Color(0xff355CCA));
    } else {
      circleColor.add(Colors.white);
    }
  }

  return circleColor;
}