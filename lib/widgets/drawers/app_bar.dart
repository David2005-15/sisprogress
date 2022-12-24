import 'package:flutter/material.dart';


class CustomAppBar extends AppBar {
  final Widget child;
  final List<Widget> action;

  CustomAppBar(this.child, this.action, {super.key}):super(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: action,
    title: Container(
      width: 62,
      height: 39,
      // margin: const EdgeInsets.fromLTRB(18, 16, 0, 0),
      child: child
    )
  );
}
