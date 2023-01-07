import 'package:flutter/material.dart';

enum EventProccess {
  progress("In Progress", Color(0xffCEE5D0), Color(0xff94B49F), Icon(Icons.refresh_outlined, color: Color(0xff94B49F), size: 16,)),
  completed("Completed", Color(0xffD2C5DF), Color(0xff8675A9), Icon(Icons.check_outlined, color: Color(0xff8675A9), size: 16,)),
  later("Late Done", Color(0xffFE8F8F), Color(0xffE31F1F), Icon(Icons.error_outlined, color: Color(0xffE31F1F), size: 16,)),
  overdue("Overdue", Color(0xffFFF89A), Color(0xffFFC900), Icon(Icons.refresh_outlined, color: Color(0xffFFC900), size: 16,)),
  planned("Planned", Color(0xffD2DAFF), Color(0xffAAC4FF), Icon(Icons.refresh_outlined, color: Color(0xffAAC4FF), size: 16,));

  final String eventName;
  final Color eventColor;
  final Color leftColor;
  final Icon icon;

  const EventProccess(
    this.eventName,
    this.eventColor,
    this.leftColor,
    this.icon
  );
}