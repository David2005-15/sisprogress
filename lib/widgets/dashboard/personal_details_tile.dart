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

  TextEditingController number = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController secondaryMail = TextEditingController();
  TextEditingController instagram = TextEditingController();


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
                  "Personal Details",
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
            mode ?  InputBox(textInputType: TextInputType.phone, onChanged: (val) {}, context: context, controller: number, isPassword: false, initialValue: "Phone",) : Container(
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
            mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: mail, isPassword: false, initialValue: "Primary Email",) :Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: Text(
                    "Primary Email",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Text(
                  email,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: Colors.grey
                  ),
                )
              ],
            ),
          ),
          mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: secondaryMail, isPassword: false, initialValue: "Secondary Email",) :Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: Text(
                    "Secondary Email",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Text(
                  email,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: Colors.grey
                  ),
                )
              ],
            ),
          ),
          mode ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Button(text: "Change ", onPressed: () async {
                await _dialogBuilder(context, () { });
                onSave();
              }, height: 38, width: 128),
            ],
          ): Container()
            ],
          )
        ],
      ),
    );
  }

}

Future<void> _dialogBuilder(BuildContext context, VoidCallback onSave,) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff121623),
          title: Text(
            'Are you sure to change your personal details?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 15, color: Colors.white),
          ),
          // content: Text(
          //   'After you make a change, the tasks that have been already completed or in progress will not be deleted. ',
          //   textAlign: TextAlign.center,
          //   style: GoogleFonts.montserrat(
          //       fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white),
          // ),
          actions: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[

                  SizedBox(
                    width: 104,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff355CCA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      onPressed: () async {
                        onSave();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 104,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: const BorderSide(
                                  color: Color(0xffD2DAFF), width: 2))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }