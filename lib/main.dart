import 'package:flutter/material.dart';
import 'package:sis_progress/page/home.dart';
import 'package:sis_progress/widgets/drawers/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      canvasColor: const Color(0xff121623)
    ),
    home: const HomePage()
  ));
}
