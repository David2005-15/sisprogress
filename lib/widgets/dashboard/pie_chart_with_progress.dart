import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartWithProgressBar extends StatefulWidget {
  final List<int> values;

  const PieChartWithProgressBar({
    required this.values,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _PieChart();
}

class _PieChart extends State<PieChartWithProgressBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<double> containerSize = getContainerSize(width);
    List<int> fontSize = getFontSize(width);
    
    return AspectRatio(
      aspectRatio: 16 / 10.45,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow> [
            BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color> [
              Color(0xff272935),
              Color(0xff121623)
            ]
          )
        ),

        child: Column(
          children: <Widget> [
            Row(
              children: [
                Container(
              margin: const EdgeInsets.fromLTRB(25, 17, 0, 0),
              child: Text(
                "Progress",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize[0].toDouble(),
                  color: Colors.white
                ),
              ),
            ),
            Container(
              // width: 200
              width: 220,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              margin: const EdgeInsets.fromLTRB(25, 17, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [   
                    const Color(0xffE31F1F).withOpacity(0.69),
                    // Color.fromRGBO(227, 31, 31, 0.69),
                    const Color(0xff355CCA),
                  ],
                ),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "Inactive categories will come soon.",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.white
                  ),
                ),
              ),
            ),
              ],
            ),

            Row(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 130,
                  height: 150,
                  child: CustomPaint(
                    painter: LinearProgressIndicator(value: widget.values, width: width),
                    child: Container(),
                  )
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                  width: containerSize[0],
                  height: containerSize[1],
                  child: CustomPaint(
                    painter: ProgressBarPainter(value: widget.values, width: width),
                    child: Container(),
                  ),
                )

              ],
            )
          ],
        )
      ),
    );
  }
}


List<double> getPointerSize(double width) {
  if(width > 500) {
    return [-100, -80, -60, -40, -20];
  } else if(width < 360) {
    return [50, 70, 90, 110, 130];
  } else if(width < 380) {
    return [30, 50, 70, 90, 110];
  } 

  return [15, 40, 65, 90, 115];
}

List<double> getTextPlace(double width) {
  if(width > 500) {
    return [-115, -95, -75, -55, -35];
  } else if(width < 360) {
    return [35, 55, 75, 95, 115];
  } else if(width < 380) {
    return [15, 35, 55, 75, 95];
  } 

  return [0, 25, 50, 75, 100];
}

class LinearProgressIndicator extends CustomPainter {
  final List<int> value;
  final double width;

  LinearProgressIndicator({
    required this.width,
    required this.value
  });

  @override
  void paint(Canvas canvas, Size size) {
    List<double> linearCoord = getPointerSize(width);
    List<double> textPlace = getTextPlace(width);

    drawProgressLine(canvas, 25 + value[0], linearCoord[0], Colors.red);
    drawProgressLine(canvas, 25, linearCoord[1], Colors.blue.withOpacity(0.3));
    drawProgressLine(canvas, 25, linearCoord[2], Colors.amber.withOpacity(0.3));
    drawProgressLine(canvas, 25, linearCoord[3], Colors.orange.withOpacity(0.3));

    drawPointer(canvas, textPlace[0], "Extraculicular", Colors.white);
    drawPointer(canvas, textPlace[1], "Personal development", Colors.white.withOpacity(0.3));
    drawPointer(canvas, textPlace[2], "Academics", Colors.white.withOpacity(0.3));
    drawPointer(canvas, textPlace[3], "Standardized test", Colors.white.withOpacity(0.3));
    // drawPointer(canvas, textPlace[4], "Category 5");
  }

  void drawProgressLine(Canvas canvas, int percentage, double offset, Color color) {
    canvas.drawLine(Offset(20, offset), Offset(120, offset), Paint()..color=const Color(0xff121623).withOpacity(0.5)..strokeWidth=2..strokeCap=StrokeCap.round);
    canvas.drawLine(Offset(20, offset), Offset(percentage.toDouble(), offset), Paint()..color=color..strokeWidth=3..strokeCap=StrokeCap.round);
  }

  void drawPointer(Canvas canvas, double offset, String category, Color color) {
    var textSpan = TextSpan(
      text: category,
      style: GoogleFonts.roboto(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 10
      ),
    );

    var textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(20, offset));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Map<String, List<double>> getPoint(double width) {
  if(width > 500) {
    return {
      "first": [40, 50],
      "second": [40, 80],
      "third": [40, 145],
      "fourth": [40, 210],
      "fifth": [40, 240]
    };
  }

  return {
    "first": [30, 15],
    "second": [30, 45],
    "third": [30, 75],
    "fourth": [30, 105],
    "fifth": [30, 135]
  };
}

Map<String, List<double>> getPointCoord(double width) {
  if(width > 500) {
    return {
      "first": [95, 90],
      "second": [90, 120],
      "third": [90, 145],
      "fourth": [100, 165],
      "fifth": [110, 175],
    };
  }

  return {
    "first": [75, 45],
    "second": [75, 60],
    "third": [80, 75],
    "fourth": [90, 90],
    "fifth": [100, 95],
  };
}

class ProgressBarPainter extends CustomPainter {
  final List<int> value;
  final double width;

  ProgressBarPainter({
    required this.width,
    required this.value
  });

  @override
  void paint(Canvas canvas, Size size) {
    final List<double> widthSize = getProgressBarSize(width);
    final Map<String, List<double>> points = getPoint(width);
    final Map<String, List<double>> pointsCoord = getPointCoord(width);

    final center = Offset((size.width + 50) / 2, size.height / 2);
    drawPie(canvas, Colors.red, makeCenter(center, widthSize[0]), (3.1415 * 2) * (value[0] / 100));
    drawPie(canvas, Colors.blue.withOpacity(0.3), makeCenter(center, widthSize[1]), 0.2);
    drawPie(canvas, Colors.amber.withOpacity(0.3), makeCenter(center, widthSize[2]), 0.2);
    drawPie(canvas, Colors.orange.withOpacity(0.3), makeCenter(center, widthSize[3]), 0.2);
    // drawPie(canvas, Colors.purple, makeCenter(center, widthSize[4]), 3.5);

    drawPointer(canvas, points["first"], pointsCoord["first"], Colors.red, Colors.white, value[0]);
    drawPointer(canvas, points["second"], pointsCoord["second"], Colors.blue.withOpacity(0.3), Colors.white.withOpacity(0.3), value[1]);
    drawPointer(canvas, points["third"], pointsCoord["third"], Colors.amber.withOpacity(0.3), Colors.white.withOpacity(0.3), value[2]);
    drawPointer(canvas, points["fourth"], pointsCoord["fourth"], Colors.orange.withOpacity(0.3), Colors.white.withOpacity(0.3), value[3]);
    // drawPointer(canvas, points["fifth"], pointsCoord["fifth"], Colors.purple, Colors.white, value[4]);
  }

  void drawPie(Canvas canvas, Color color, Rect rect, double value) {
    canvas.drawArc(rect, 0, value, false, Paint()..color=color..strokeWidth=3..style=PaintingStyle.stroke..strokeCap=StrokeCap.round);
  }

  double degToRad(double degree) => degree * (3.1415 / 180);

  void drawPointer(Canvas canvas, List<double>? first, List<double>? second, Color color, Color textColor, int value) {
    canvas.drawLine(Offset(first!.first, first.last), Offset(second!.first, second.last), Paint()..color=color..strokeWidth=2);
    canvas.drawLine(Offset(first.first, first.last), Offset(first.first - 20, first.last), Paint()..color=color..strokeWidth=2);

    var textSpan = TextSpan(
      text: "$value %",
      style: GoogleFonts.roboto(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 10
      ),
    );

    var textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(first.first - 20, first.last - 15));
  }

  Rect makeCenter(Offset center, double radialSize) {
    return Rect.fromCenter(center: center, width: radialSize, height: radialSize);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}

List<double> getProgressBarSize(double width) {
  if(width > 500) {
    return [200, 185, 170, 155, 140];
  } else if(width < 360) {
    return [80, 65, 50, 35, 20];
  } else if(width < 380) {
    return [110, 95, 80, 65, 50];
  }

  return [120, 105, 90, 75, 60];
}

List<double> getContainerSize(double width) {
  if(width > 500) {
    return [300, 300];
  } else if(width < 360) {
    return [140, 75];
  } else if(width < 380) {
    return [175, 125];
  }

  return [200, 150];
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