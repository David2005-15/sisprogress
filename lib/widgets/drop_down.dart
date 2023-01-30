import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/dropdown.dart';

class DropDown extends StatefulWidget {
  final BuildContext context;
  final DropDownDataClass dropDownDataClass;

  const DropDown({
    required this.dropDownDataClass,
    required this.context,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _DropDown();

}

class _DropDown extends State<DropDown> {
  // String? dropDownItem;
  // Color selectedColor = const Color(0xff121623);
  


  @override
  Widget build(BuildContext context) {
     List<DropdownMenuItem> items = ["9th Grade", "10th Grade"].map((e) {
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
      margin: const EdgeInsets.fromLTRB(23, 32, 23, 0),
      child: Center(
        child: DropdownButtonFormField(
          // isExpanded: true,
          hint: Text(
            "Grade Level",
            style:  GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color(0xffD2DAFF),
            ),
          ),
          dropdownColor: const Color(0xffD2DAFF),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
            ),
        
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
            ),
        
            focusColor: Color(0xffD2DAFF)
          ),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: const Color(0xff121623),
          ),
          value: widget.dropDownDataClass.value,
          onSaved: (value) {
            setState(() {
              widget.dropDownDataClass.value = value;
            });
          },
          items: items,
          onChanged: (value) {
            setState(() {
              widget.dropDownDataClass.value = value;
            });
          },
        
          selectedItemBuilder: (context) {
            return ["9th Grade", "10th Grade"].map<Widget>((e) {
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

double getTopMargin(BuildContext context) {
  double height = MediaQuery.of(context).size.height;

  if (height < 800) {
    return 15;
  }

  return 25;
}