import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OverlayInput extends StatefulWidget {
  final BuildContext context;
  final TextEditingController controller;
  final List<String> values;
  final TextInputType textInputType;
  final String initialValue;
  final String? Function(String?)? validator;
  final bool showFilter;
  final VoidCallback onSuffix;


  OverlayInput({
    required this.onSuffix,
    required this.showFilter,
    required this.initialValue,
    required this.validator,
    required this.textInputType,
    required this.context,
    required this.controller,
    required this.values,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _InputField();
}

class _InputField extends State<OverlayInput> {

  @override
  void initState() {
    super.initState();
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
      margin: const EdgeInsets.fromLTRB(23, 5, 23, 5),
      child: TextFormField(
        validator: widget.validator,
        maxLines: 1,
        keyboardType: widget.textInputType,
        autocorrect: false,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            alignLabelWithHint: true,
            labelText: widget.initialValue,
            errorStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: const Color(0xffE31F1F)
            ),
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
          suffix: IconButton(
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            onPressed: widget.onSuffix,
          )
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

