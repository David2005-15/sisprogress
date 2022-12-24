import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/registration_data_grade9.dart';
import 'package:sis_progress/page/verify_email.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/progress/progress_bar.dart';

class Grade9thSecond extends StatefulWidget {
  final TextEditingController work = TextEditingController();
  final RegistrationGrade9  registration;


  Grade9thSecond({
    required this.registration,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Grade9thSecond();
}


class _Grade9thSecond extends State<Grade9thSecond> {
  String text = "0/160";

  void getInputLength(TextEditingController controller) {
    setState(() {
      text = "${controller.text.length}/160";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          // alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: const Color(0xff3A3D4C),
            borderRadius: BorderRadius.circular(5)
          ),
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 25, 16, 15),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const ProgressBar(isPassed: [true, true, false]),
                buildTitle(),
                Container(
                  margin: const EdgeInsets.fromLTRB(13, 25, 13, 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Please briefly elaborate on one of your extracurricular activities or work experiences",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Container(
                  margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                  height: 160,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        text = "${value.length}/160";
                      });
                    },
                    controller: widget.work,
                    expands: false,
                    maxLines: 8,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: const Color(0xffD2DAFF)
                    ),
                    decoration: InputDecoration(
                      hintText: "Type about your activites or work experiance",
                      hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        color: const Color(0xffD2DAFF)
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
                      ),
                      focusColor: const Color(0xffD2DAFF),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD2DAFF))
                      ),
                    ),
                  ),
                ),
          
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 7, 23, 0),
                  alignment: Alignment.centerRight,
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color(0xffD2DAFF)
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                          child: TextButton.icon(     // <-- TextButton
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/previous.png"),
                              size: 14,
                              color:Color(0xffBFBFBF),
                            ),
                            label: Text(
                              'Previous',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: const Color(0xffBFBFBF)
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff36519D)
                            ),
                            child: Text(
                              "Next",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 18
                              ),
                            ),
                            onPressed: () {
                              widget.registration.workExp = widget.work.text;
                              Navigator.push(context,  MaterialPageRoute(builder: (context) => VerifyEmail(email: widget.registration.email,)));
                            },
                          ),
                        )
                      ],
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Image buildLogoIcon() {
  return Image.asset(
    "assets/logo.png",
  );
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Registration for admission",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.02,
          color: Colors.white
        ),
      ),
    ),
  );
}