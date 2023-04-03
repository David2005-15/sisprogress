import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';

class CustomRadioGroup extends StatefulWidget {
  final RadioButtonHandler handler;
  final VoidCallback methodParent;
  final List<String> groupValue;
  final String? value;
  List<String>? errors;

  CustomRadioGroup({
    required this.methodParent,
    required this.handler, 
    required this.groupValue, 
    this.errors,
    this.value,
    super.key, 
  });

  @override
  State<StatefulWidget> createState() => CustomRadioGroupState();
}

class CustomRadioGroupState extends State<CustomRadioGroup> {
  bool selectedFirst = false;
  bool selectedSecond = false;
  bool selectedThrid = false;
  bool selectedFourth = false;

  @override
  void initState() {
    if(widget.groupValue[0] == widget.value) {
      selectedFirst = true;
      selectedSecond = false;
      selectedThrid = false;
      selectedFourth = false;
    } else if(widget.groupValue[1] == widget.value) {
      selectedFirst = false;
      selectedSecond = true;
      selectedThrid = false;
      selectedFourth = false;
    } else if(widget.groupValue[2] == widget.value) {
      selectedFirst = false;
      selectedSecond = false;
      selectedThrid = true;
      selectedFourth = false;
    } else  {
      selectedFirst = false;
      selectedSecond = false;
      selectedThrid = false;
      selectedFourth = false;
    }
    super.initState();
  }

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
                      selectedThrid = false;
                      selectedFourth = false;
                    });
                  },
                  child: Container(
                  // padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent, border: Border.all(width: 1.5, color: selectedFirst ? const Color(0xff355CCA): const Color(0xffBFBFBF))),
                  child: Icon(
                      Icons.circle,
                      size: 16,
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
                      selectedThrid = false;
                      selectedFourth = false;
                    });
                  },
                  child: Container(
                  // padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent, border: Border.all(width: 1.5, color: selectedSecond ? const Color(0xff355CCA): const Color(0xffBFBFBF))),
                  child: Icon(
                      Icons.circle,
                      size: 16,
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
                      widget.handler.value = widget.groupValue[2];
                      selectedFirst = false;
                      selectedSecond = false;
                      selectedThrid = true;
                      selectedFourth = false;
                    });
                  },
                  child: Container(
                  // padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent, border: Border.all(width: 1.5, color: selectedThrid ? const Color(0xff355CCA): const Color(0xffBFBFBF))),
                  child: Icon(
                      Icons.circle,
                      size: 16,
                      color: selectedThrid ? const Color(0xff355CCA) : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  widget.groupValue[2],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white
                  ),
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
                      widget.handler.value = widget.groupValue[3];
                      selectedFirst = false;
                      selectedSecond = false;
                      selectedThrid = false;
                      selectedFourth = true;
                    });
                  },
                  child: Container(
                  // padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent, border: Border.all(width: 1.5, color: selectedFourth ? const Color(0xff355CCA): const Color(0xffBFBFBF))),
                  child: Icon(
                      Icons.circle,
                      size: 16,
                      color: selectedFourth ? const Color(0xff355CCA) : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  widget.groupValue[3],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),

          widget.errors != null ? Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.errors!.map((e) {
                return Text(
                  e,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: const Color(0xffE31F1F)
                  ),
                );
              }).toList(),
            ),
          ): Container()
        ],
      ),
    );
  }
}