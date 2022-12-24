import 'package:flutter/material.dart';

class AppMaterial extends StatelessWidget {
  final dynamic home;

  const AppMaterial({
    required this.home,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xff121623)),
      home: home,
    );
  }
}