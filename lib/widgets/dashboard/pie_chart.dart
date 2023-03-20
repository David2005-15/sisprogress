import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PieChart extends StatelessWidget {
  final String title;
  final String halfPerc;
  final String percentage;
  final double redLine;
  final double blueLine;
  final BuildContext context;

  const PieChart({
    required this.context,
    required this.halfPerc,
    required this.title,
    required this.redLine,
    required this.blueLine,
    required this.percentage,
    super.key
  });

  // double width = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<int> fonts = getFontSize(width);

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow> [
            BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
          ],
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: <Color> [
              Color(0xff272935),
              Color(0xff121623)
            ]
          )
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(18, 16, 0, fonts.last.toDouble()),
                  child: Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontWeight:FontWeight.w700,
                      fontSize: fonts[0].toDouble(),
                      color: Colors.white
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(18, 22, 0, 0),
                  child: Text(
                    halfPerc,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: fonts[1].toDouble(),
                      color: const Color(0xffBFBFBF)
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(18, 15, 0, 0),
                  child: Row(
                    children: <Widget> [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red
                        ),
                      ),
                
                      Container(
                        margin: const EdgeInsets.all(9),
                        child: Text(
                          "Done",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: fonts[2].toDouble(),
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                  child: Row(
                    children: <Widget> [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue
                        ),
                      ),
                
                      Container(
                        margin: const EdgeInsets.all(9),
                        child: Text(
                          "Progress",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: fonts[2].toDouble(),
                            color: Colors.white
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 36, 0),
              decoration:  const BoxDecoration(
                // borderRadius: BorderRadius.circular(100),
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                  Color(0xFF121623),
                  Color(0xFF272935),
                  ],
                  stops: [
                    0.0748,
                    0.9006,
                  ],
                  transform: GradientRotation(318.06 * (3.141592 / 180))
                )
              ),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget> [
                  RotatedBox(
                    quarterTurns: 1,
                    child: CircularPercentIndicator(
                      radius: fonts[3].toDouble(),
                      lineWidth: 5.0,
                      percent: redLine,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          percentage,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: fonts[0].toDouble(),
                            color: Colors.white
                          ),
                          )
                      ),
                      progressColor: Colors.red,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: CircularPercentIndicator(
                      radius: fonts[4].toDouble(),
                      lineWidth: 5.0,
                      percent: blueLine,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.blue,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<int> getFontSize(double height) {
  if(height > 500) {
    return [25, 22, 18, 100, 90, 20];
  } else if(height < 360) {
    return [14, 12, 12, 40, 30, 0];
  } else if(height < 380) {
    return [14, 12, 12, 50, 40, 0];
  }

  return [16, 12, 14, 60, 50, 15];

}