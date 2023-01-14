import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/input_box.dart';

class PersonalDetails extends StatelessWidget {
  final bool mode;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final String phone;
  final String email;


  PersonalDetails({
    required this.phone,
    required this.email,
    required this.onSave,
    required this.onEdit,
    required this.mode,
    super.key
  });

  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const <BoxShadow> [
          BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color> [
            Color(0xff272935),
            Color(0xff121623),
          ]
        )
      ),
      child: Wrap(
        children: <Widget> [
          Column(
            children: <Widget> [
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 13, 0, 0),
                child: Text(
                  "University choice",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: const Color(0xffD2DAFF)
                  ),
                ),
              ),
      
              mode ? Container() : InkWell (
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: onEdit,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 13, 15, 0),
                  child: Text(
                    "Edit",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.grey
                    ),
                  ),
                ),
              )
            ],
          ),
            mode ?  InputBox(textInputType: TextInputType.phone, onChanged: (val) {}, context: context, controller: controller, isPassword: false, initialValue: "Phone",) : Container(
            margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: Text(
                    "Phone",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Container(
                  child: Text(
                    phone,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.grey
                    ),
                  ),
                )
              ],
            ),
          ),
            mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: controller, isPassword: false, initialValue: "Email",) :Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: Text(
                    "Email",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Container(
                  child: Text(
                    email,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.grey
                    ),
                  ),
                )
              ],
            ),
          ),
            mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: controller, isPassword: false, initialValue: "Instagram",) :Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: Text(
                    "Instagram",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Container(
                  child: Text(
                    "https://www.instagram.com/",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.grey
                    ),
                  ),
                )
              ],
            ),
          ),
          mode ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Button(text: "Change ", onPressed: onSave, height: 38, width: 128),
            ],
          ): Container()
            ],
          )
        ],
      ),
    );
  }

}