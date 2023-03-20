import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/dropdown.dart';
import 'package:sis_progress/data%20class/universities.dart';

class DropDown extends StatefulWidget {
  final BuildContext context;
  final DropDownDataClass dropDownDataClass;
  String? initialValue;
  String? errorText;
  bool? enabled;
  bool? showValidationOrNot;

  DropDown({
    required this.dropDownDataClass,
    required this.context,
    this.initialValue,
    this.errorText,
    this.enabled,
    this.showValidationOrNot,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _DropDown();

}

class CountryDropDown extends StatefulWidget {
  final BuildContext context;
  final DropDownDataClass dropDownDataClass;
  final dynamic Function(dynamic)? onChange;
  String? initialValue;
  String? errorText;
  bool? enabled;
  bool? showValidationOrNot;

  CountryDropDown({
    required this.dropDownDataClass,
    required this.context,
    required this.onChange,
    this.initialValue,
    this.errorText,
    this.enabled,
    this.showValidationOrNot,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _CountryDropDown();
}

class SchoolDropDown extends StatefulWidget {
  final BuildContext context;
  final DropDownDataClass dropDownDataClass;
  final dynamic Function(dynamic)? onChange;
  String? initialValue;
  String? errorText;
  bool? enabled;
  bool? showValidationOrNot;

  SchoolDropDown({
    required this.dropDownDataClass,
    required this.context,
    required this.onChange,
    this.initialValue,
    this.errorText,
    this.enabled,
    this.showValidationOrNot,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _SchoolDropdown();
}

class _DropDown extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
     List<DropdownMenuItem> items = ["Up to 9th grade", "10th grade or above"].map((e) {
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
      margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
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
          decoration: InputDecoration(
            errorText: widget.showValidationOrNot ?? false ? widget.errorText: null,
            alignLabelWithHint: true,
            labelText: widget.initialValue,
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
            return ["Up to 9th grade", "10th grade or above"].map<Widget>((e) {
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


class _CountryDropDown extends State<CountryDropDown> {
  @override
  Widget build(BuildContext context) {
     List<DropdownMenuItem> items = Universities().countryList.map((e) {
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
      margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
      height: 100,
      child: Center(
        child: DropdownButtonFormField(
          // itemHeight: 60,r
          menuMaxHeight: 150,
          // isExpanded: true,
          hint: Text(
            "Country",
            style:  GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color(0xffD2DAFF),
            ),
          ),
          dropdownColor: const Color(0xffD2DAFF),
          decoration: InputDecoration(
            errorText: widget.showValidationOrNot ?? false ? widget.errorText: null,
            alignLabelWithHint: true,
            labelText: widget.initialValue,
            errorStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: const Color(0xffE31F1F)
            ),
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
          onChanged: widget.onChange,
        
          selectedItemBuilder: (context) {
            return Universities().countryList.map<Widget>((e) {
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

class _SchoolDropdown extends State<SchoolDropDown> {
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items = Universities().schools.map((e) {
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
      margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
      height: 100,
      child: Center(
        child: DropdownButtonFormField(
          // itemHeight: 60,r
          menuMaxHeight: 150,
          // isExpanded: true,
          hint: Text(
            "School",
            style:  GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: const Color(0xffD2DAFF),
            ),
          ),
          dropdownColor: const Color(0xffD2DAFF),
          decoration: InputDecoration(
              errorText: widget.showValidationOrNot ?? false ? widget.errorText: null,
              alignLabelWithHint: true,
              labelText: widget.initialValue,
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
          value: widget.dropDownDataClass.value,
          onSaved: (value) {
            setState(() {
              widget.dropDownDataClass.value = value;
            });
          },
          items: items,
          onChanged: widget.onChange,

          selectedItemBuilder: (context) {
            return Universities().schools.map<Widget>((e) {
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
