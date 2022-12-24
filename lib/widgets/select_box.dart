import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectBox extends StatefulWidget {
  final String activityName;
  List<String> activity;

  SelectBox({
    required this.activityName,
    required this.activity,
    super.key
  });

  @override
  State<StatefulWidget> createState() =>_SelectBox();
}

class _SelectBox extends State<SelectBox> {
  Color color = const Color(0xffBFBFBF);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          side: BorderSide(width: 1.5, color: color,)
        ),
        onPressed: () {
          if(!widget.activity.contains(widget.activityName)) {
            widget.activity.add(widget.activityName);
            setState(() {
              color = const Color(0xffFE8F8F);
            });
          } else {
            widget.activity.remove(widget.activityName);
            setState(() {
              color = const Color(0xffBFBFBF);
            });
          }
        },
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.activityName,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: color
            ),
          ),
        ),
      ),
    );
  }
}