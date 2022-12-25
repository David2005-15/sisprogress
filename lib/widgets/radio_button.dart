import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';

class CustomRadio extends StatefulWidget {
  final RadioButtonHandler handler;
  final VoidCallback methodParent;
  final List<String> groupValue;

  const CustomRadio({
    required this.methodParent,
    required this.handler, 
    required this.groupValue, 
    super.key, 
  });

  @override
  State<StatefulWidget> createState() => CustomRadioState();
}

class CustomRadioState extends State<CustomRadio> {
  bool selectedFirst = true;
  bool selectedSecond = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(38, 10, 0, 0),
      child: Column(
        children: <Widget> [
           Row(
             children: [
               Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                width: 24,
                height: 24,
                child: InkWell(
                  // key: UniqueKey(),
                  onTap: () {
                    setState(() {
                      widget.methodParent();
                      widget.handler.value = widget.groupValue[0];
                      selectedFirst = true;
                      selectedSecond = false;
                    });
                  },
                  child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent, border: Border.all(width: 1, color: selectedFirst ? const Color(0xff355CCA): const Color(0xffBFBFBF))),
                  child: Icon(
                      Icons.circle,
                      size: 14,
                      color: selectedFirst ? const Color(0xff355CCA) : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Text(
                widget.groupValue[0],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white
                ),
              )
             ],
           ),

          Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                width: 24,
                height: 24,
                child: InkWell(
                  // key: UniqueKey(),
                  onTap: () {
                    setState(() {
                      widget.methodParent();
                      // widget.methodParent!();
                      // widget.handler.visible = true;
                      widget.handler.value = widget.groupValue[1];
                      selectedFirst = false;
                      selectedSecond = true;
                    });
                  },
                  child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent, border: Border.all(width: 1, color: selectedSecond ? const Color(0xff355CCA): const Color(0xffBFBFBF))),
                  child: Icon(
                      Icons.circle,
                      size: 14,
                      color: selectedSecond ? const Color(0xff355CCA) : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  widget.groupValue[1],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}