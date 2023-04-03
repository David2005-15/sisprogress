import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/radio_button_handler.dart';

class CustomRadio extends StatefulWidget {
  final RadioButtonHandler handler;
  final VoidCallback methodParent;
  final List<String> groupValue;
  final String? value;
  final List<Widget>? child;

  List<String>? errors;

  CustomRadio({
    required this.methodParent,
    required this.handler,
    required this.groupValue,
    this.value,
    this.child,
    this.errors,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => CustomRadioState();
}

class CustomRadioState extends State<CustomRadio> {
  bool selectedFirst = false;
  bool selectedSecond = false;

  @override
  void initState() {
    super.initState();

    if (widget.value != null) {
      if (widget.groupValue[0] == widget.value) {
        selectedFirst = true;
        selectedSecond = false;
      } else if (widget.groupValue[1] == widget.value) {
        selectedFirst = false;
        selectedSecond = true;
      } else {
        selectedFirst = false;
        selectedSecond = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(38, 10, 0, 0),
      child: Column(
        children: <Widget>[
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
                      widget.handler.value = widget.groupValue[0];
                      selectedFirst = true;
                      selectedSecond = false;
                      widget.methodParent();
                    });
                  },
                  child: Container(
                    // padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1.5,
                            color: selectedFirst
                                ? const Color(0xff355CCA)
                                : const Color(0xffBFBFBF))),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.circle,
                      size: 16,
                      color: selectedFirst
                          ? const Color(0xff355CCA)
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              widget.child != null ? Expanded(child: widget.child![0],) : InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    widget.handler.value = widget.groupValue[0];
                    selectedFirst = true;
                    selectedSecond = false;
                    widget.methodParent();
                  });
                },
                child: Text(
                  widget.groupValue[0],
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white),
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
                  onTap: () {
                    setState(() {
                      widget.handler.value = widget.groupValue[1];
                      selectedFirst = false;
                      selectedSecond = true;
                      widget.methodParent();
                    });
                  },
                  child: Container(
                    // padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1.5,
                            color: selectedSecond
                                ? const Color(0xff355CCA)
                                : const Color(0xffBFBFBF))),
                    child: Icon(
                      Icons.circle,
                      size: 16,
                      color: selectedSecond
                          ? const Color(0xff355CCA)
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
              widget.child != null ? Expanded(child: widget.child![1],):InkWell(
                onTap: () {
                  setState(() {
                    widget.handler.value = widget.groupValue[1];
                    selectedFirst = false;
                    selectedSecond = true;
                    widget.methodParent();
                  });
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    widget.groupValue[1],
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          widget.errors != null
              ? Container(
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
                            color: const Color(0xffE31F1F)),
                      );
                    }).toList(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
