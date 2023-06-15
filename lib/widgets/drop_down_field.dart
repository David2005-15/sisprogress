import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownField extends StatefulWidget {
  final BuildContext context;
  String initialValue;
  final List<String> items;
  final String? value;
  final String? Function(dynamic)? validator;
  final Function(dynamic)? onChange;

  DropDownField({
    required this.value,
    required this.validator,
    required this.onChange,
    required this.context,
    required this.initialValue,
    required this.items,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _DropDownField();
}

class _DropDownField extends State<DropDownField> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = widget.items.map((e) {
      return DropdownMenuItem(
        value: e,
        child: Text(
          e,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: const Color(0xff121623),
          ),
        ),
      );
    }).toList();

    return Container(
      margin: const EdgeInsets.fromLTRB(23, 10, 23, 10),
      child: Center(
        child: DropdownButtonFormField(
          menuMaxHeight: 200,
          validator: widget.validator,
          // isExpanded: true,
          hint: Text(
            widget.initialValue,
            style:  GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color(0xffD2DAFF),
            ),
          ),
          dropdownColor: const Color(0xffD2DAFF),
          decoration: InputDecoration(
              alignLabelWithHint: true,
              // labelText: widget.initialValue,
              labelStyle: GoogleFonts.poppins(
                color: const Color(0xffD2DAFF)
              ),
              errorStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color(0xffE31F1F)
              ),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
              ),

              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
              ),

              focusColor: const Color(0xffD2DAFF)
          ),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: const Color(0xff121623),
          ),
          value: widget.value,
          items: items,
          onChanged: widget.onChange,
          selectedItemBuilder: (context) {
            return widget.items.map<Widget>((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}