import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputBox extends StatefulWidget {
  final BuildContext context;
  final TextEditingController controller;
  final bool isPassword;
  final Function(String) onChanged;
  final TextInputType textInputType;
  String? initialValue;

  InputBox({
    this.initialValue,
    required this.textInputType,
    required this.onChanged,
    required this.context,
    required this.controller,
    required this.isPassword,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _InputBox();

}

class _InputBox extends State<InputBox> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  Color color = const Color(0xffD2DAFF);

  void getColor(String text) {
    if(text.isNotEmpty) {
      setState(() {
        color = const Color(0xff36519D);
      });
    }else {
      color = const Color(0xffD2DAFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    getColor(widget.controller.text);

    return Container(
      margin: EdgeInsets.fromLTRB(23, getTopMargin(widget.context), 23, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: widget.textInputType,
        onChanged: (value) => {widget.onChanged(value), getColor(value)},
        obscureText: widget.isPassword ? !_passwordVisible: widget.isPassword,
        autocorrect: false,
        // initialValue: widget.initialValue,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: widget.initialValue,
          // hintText: widget.hintText,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: const Color(0xffD2DAFF)
          ),
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            fontStyle: FontStyle.normal,
            color: const Color(0xffD2DAFF)
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1)
          ),
          focusColor: const Color(0xffD2DAFF),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff36519D))
          ),
          suffixIcon: widget.isPassword ? IconButton(
            icon: Icon(
               _passwordVisible
                 ? Icons.visibility
                 : Icons.visibility_off,
                 color: const Color(0xffD2DAFF),
                 size: 14,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ): null
        ),
        controller: widget.controller,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          fontStyle: FontStyle.normal,
          color: Colors.white
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

