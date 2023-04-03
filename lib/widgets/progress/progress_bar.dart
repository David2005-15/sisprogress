import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressBar extends StatefulWidget {
  final EdgeInsets progressMargin = const EdgeInsets.fromLTRB(25, 0, 25, 0);
  final List<bool> isPassed;

  const ProgressBar({super.key, required this.isPassed});

  @override
  State<StatefulWidget> createState() => _ProgressBar();

}

class _ProgressBar extends State<ProgressBar> {


  @override
  Widget build(BuildContext context) {
    List<Color> colors = getCircleColor(widget.isPassed);
    var gradient = getProgress();

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              height: 2,
              decoration: BoxDecoration(
                gradient: gradient
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  margin: widget.progressMargin,
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff3a3d4c),
                    border: Border.all(width: 2, color: colors[0])
                  ),
                  child: Center(
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
                ),
                Container(
                  alignment: Alignment.center,
                  margin: widget.progressMargin,
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff3a3d4c),
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
                  margin: widget.progressMargin,
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff3a3d4c),
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
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient getProgress() {
    if(widget.isPassed[0] == true && widget.isPassed[1] == false) {
      return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xff355CCA),
            Color(0xff355CCA),
            Colors.white
          ],
        stops: [
          0,
          0.40,
          0.40
        ]
      );
    } else if(widget.isPassed[0] == true && widget.isPassed[1] == true && widget.isPassed[2] == false) {
      return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xff355CCA),
            Color(0xff355CCA),
            Colors.white
          ],
          stops: [
            0,
            0.60,
            0.60
          ]
      );
    } else if(widget.isPassed[0] == true && widget.isPassed[1] == true && widget.isPassed[2] == true) {
      return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xff355CCA),
            Color(0xff355CCA),
          ]
      );
    }

    return const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white,
          Colors.white
        ]
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

