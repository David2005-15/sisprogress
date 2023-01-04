import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sis_progress/data%20class/graph_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  final List<GraphData> data; 
  final List<GraphData> lineData;

  const Graph({
    required this.lineData,
    required this.data, 
    super.key
  });


  
  @override
  State<StatefulWidget> createState() => _Graph();
}

class _Graph extends State<Graph> {
  late List<GraphData> columnData;

  @override
  void initState() {
    columnData = List.from(widget.data);
    columnData.addAll(widget.data);
    columnData.removeAt(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int fontSize = getFontSize(MediaQuery.of(context).size.width);

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
        // padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  // height: 250,
            // padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(25, 17, 0, 0),
                    child: Text(
                      "Activity chart",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: fontSize.toDouble(),
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // width: 150,
                    margin: const EdgeInsets.fromLTRB(13, 0, 14, 0),
                    height: getChartSize(MediaQuery.of(context).size.width).toDouble(),
                    child: SfCartesianChart(
                      borderWidth: 0,
                      borderColor: Colors.transparent,
                      plotAreaBorderWidth: 0,
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(
                          text: "Remaining Effort",
                          textStyle: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: fontSize - 10,
                            color: Colors.white
                          )
                        ),
                        majorGridLines: const MajorGridLines(width: 0,),
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize - 10
                        ),
                        maximum: 60,
                        minimum: 0,
                        interval: 10,
                        axisLine: const AxisLine(
                          color: Colors.red,
                          width: 2,
                        ),
                        
                      ),
                      primaryXAxis: NumericAxis(
                        
                        title: AxisTitle(
                          text: "Remaining Effort",
                          textStyle: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: fontSize - 10,
                            color: Colors.white
                          )
                        ),
                        minimum: 0,
                        maximum: 25,
                        interval: 5,
                        labelStyle: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize - 10
                        ),
                        majorGridLines: const MajorGridLines(width: 0),
                        axisLine: const AxisLine(
                          color: Colors.red,
                          width: 2
                        ),
                      ),
                            // primaryXAxis: DateTimeAxis(),
                      series: <ChartSeries> [
                        ColumnSeries<GraphData, int>(
                          color: const Color(0xff355CCA),
                          dataSource: columnData, 
                          width: 0.03,
                          xValueMapper: (GraphData datum, _) => datum.year, 
                          yValueMapper: (GraphData datum, _) => datum.sales
                        ),
                        LineSeries<GraphData, int>(
                          color: Colors.blue,
                          dataSource: widget.lineData, 
                          xValueMapper: (GraphData datum, _) => datum.year, 
                          yValueMapper: (GraphData datum, _) => datum.sales
                        ),
                        SplineSeries<GraphData, int>(
                          color: Colors.red,  
                          markerSettings: const MarkerSettings(
                            shape: DataMarkerType.circle,
                            borderColor: Color(0xffB1B2FF),
                            borderWidth: 2.3,
                            height: 1.5,
                            width: 1.5,
                            isVisible: true,
                            color: Colors.white
                          ),
                          dataSource: widget.data, 
                          xValueMapper: (GraphData datum, _) => datum.year, 
                          yValueMapper: (GraphData datum, _) => datum.sales
                      ),
                    ],
                  ),
                  ),
                ),
              ],
            ), 
      ),
    );
  }
}

int getFontSize(double width) {
  if(width > 400) {
    return 23;
  }

  return 16;
}

int getChartSize(double width) {
  if(width > 500) {
    return 250;
  }

  return 150;
}