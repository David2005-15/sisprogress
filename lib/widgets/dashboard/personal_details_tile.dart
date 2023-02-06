import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/input_box.dart';

class PersonalDetails extends StatelessWidget {
  final bool mode;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final String phone;
  final String email;
  final String age;
  final String country;
  final String name;


  PersonalDetails({
    required this.phone,
    required this.email,
    required this.onSave,
    required this.onEdit,
    required this.mode,
    required this.age,
    required this.country,
    required this.name,
    super.key
  });

  TextEditingController fullName = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController secondaryMail = TextEditingController();
  TextEditingController verifyMail = TextEditingController();
  TextEditingController agecnt = TextEditingController();
  TextEditingController countrycnt = TextEditingController();
  TextEditingController instagram = TextEditingController();


  bool isSecondaryEmail = false;
  String removeText = "Add secondary email";

  Client httpClient = Client();

  @override
  Widget build(BuildContext context) {
    mail.text = email;
    number.text = phone;
    agecnt.text = age;
    countrycnt.text = country;
    fullName.text = name;

    return StatefulBuilder(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
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
                mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: fullName, isPassword: false, initialValue: "Full Name",) : Container(
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
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

              mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: number, isPassword: false, initialValue: "Phone",) : Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                      child: Text(
                        "Full Name",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white
                        ),
                      ),
                    ),
              
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        name,
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
              mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: agecnt, isPassword: false, initialValue: "Age",) : Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                      child: Text(
                        "Age",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white
                        ),
                      ),
                    ),
              
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        age,
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
              mode ?  InputBox(textInputType: TextInputType.text, onChanged: (val) {}, context: context, controller: countrycnt, isPassword: false, initialValue: "Country",) : Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                      child: Text(
                        "Country",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white
                        ),
                      ),
                    ),
              
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        country,
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
                  Button(text: "Change ", onPressed: () async {
                    // await _dialogBuilder(context, () { });
                    // {fullName,phone,country,email,age,greade,university,academicProgram,study}
                    var body = {
                      "fullName": fullName.text,
                      "phone": number.text,
                      // "age": agecnt.text,
                      "country": countrycnt.text,
                      "email": mail.text,

                      "greade": 9
                    };

                    await httpClient.updateUniversityAndAcademic(body).then((value) {
                      onSave();
                    });


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
    );
  }
}

Future<void> _addSecondaryEmail(BuildContext context, TextEditingController secondary, TextEditingController verify) {
  return showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xff121623),
        title: Text(
          "Add secondary email",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(    
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.white
          ),
        ),

        actions: <Widget> [
          Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => {},
        autocorrect: false,
        // initialValue: widget.initialValue,
        textAlignVertical: TextAlignVertical.center,
        
        decoration: InputDecoration(
          hintText: "Secondary email",
          alignLabelWithHint: true,
          errorStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: const Color(0xffE31F1F)
          ),
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
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
          ),
          focusColor: const Color(0xffD2DAFF),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff36519D))
          ),

        ),
        controller: secondary,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          fontStyle: FontStyle.normal,
          color: Colors.white
        ),
      ),
    ),
    Container(
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => {},
        autocorrect: false,
        
        // initialValue: widget.initialValue,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: "Confirm your password",
          alignLabelWithHint: true,
          errorStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 10,
            color: const Color(0xffE31F1F)
          ),
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
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
          ),
          focusColor: const Color(0xffD2DAFF),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff36519D))
          ),

        ),
        controller: verify,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          fontStyle: FontStyle.normal,
          color: Colors.white
        ),
      ),
    ),
        Container(
          width: double.infinity,
          height: 36,
          margin: const EdgeInsets.fromLTRB(20, 30, 20, 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff355CCA)
            ),
            child: Text(
              "Add",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white
              ),
            ),
            onPressed: () {

            },
          ),
        )
        ],
      );
    }
  );
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