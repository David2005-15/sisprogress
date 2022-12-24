import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Question extends StatefulWidget {
  final String question;
  final List<String> answer;


  const Question({
    required this.answer,
    required this.question,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Question();

}

class _Question extends State<Question> {
  @override
  Widget build(BuildContext context) {
    String? answer = widget.answer[0];

    return Container(
      margin: const EdgeInsets.fromLTRB(19, 20, 0, 0),
      child: Column(
        children: <Widget> [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.question,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white
              ),
            ),
          ),

          ListTile(
            title: Text(widget.answer[0]),
            leading: Radio(
              groupValue: answer, 
              value: "Value",
              onChanged: (value) {
                setState(() {
                  answer = value;
                });
              },
            ),
          ),

          ListTile(
            title: Text(widget.answer[1]),
            leading: Radio(
              groupValue: answer, 
              value: "Value",
              onChanged: (value) {
                setState(() {
                  answer = value;
                });
                
              },
            ),
          )
        ],
      ),
    );
  }
}