import 'package:flutter/material.dart';
import 'package:sis_progress/page/forgot_password.dart';
import 'package:sis_progress/page/home.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      '/forgetPassword': (context) => ForgotPassword()
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      canvasColor: const Color(0xff121623)
    ),
    home: const HomePage()
  ));
}
