import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/login.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';

import '../widgets/input_box.dart';

class ChangePassword extends StatefulWidget {
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePassword();

}

class _ChangePassword extends State<ChangePassword> {
  Color color = const Color(0xffD4D4D4);

  bool isVisible = false;

  Color capitalLetter = const Color(0xffFE8F8F);
  Color containNumber= const Color(0xffFE8F8F);
  Color containSmall = const Color(0xffFE8F8F);
  Color cotain8charecters = const Color(0xffFE8F8F);
  Color containSpecial = const Color(0xffFE8F8F);

  void changeColor() {
    capitalLetter = const Color(0xffFE8F8F);
    containNumber= const Color(0xffFE8F8F);
    containSmall = const Color(0xffFE8F8F);
    cotain8charecters = const Color(0xffFE8F8F);
    containSpecial = const Color(0xffFE8F8F);

    setState(() {
      if(widget.password.text.contains(RegExp(r'[0-9]'))) {
        containNumber = const Color(0xff94B49F);
      }
      
      if(widget.password.text.contains(RegExp(r'[A-Z]'))) {
        capitalLetter = const Color(0xff94B49F);
      }

      if(widget.password.text.contains(RegExp(r'[a-z]'))) {
        containSmall = const Color(0xff94B49F);
      }

      if(widget.password.text.contains(RegExp(r'[^\w\s]+')) && widget.password.text.length >= 8) {
        cotain8charecters = const Color(0xff94B49F);
        containSpecial = const Color(0xff94B49F);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xff3A3D4C),
          borderRadius: BorderRadius.circular(5)
        ),
        width: double.infinity,
        // height: 265,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            buildTitle(),
            Focus(onFocusChange: ((value) {
              setState(() {
                isVisible = value;
              });
            }), child: InputBox(controller: widget.password, context: context, isPassword: true, initialValue: "Password", onChanged: (String val) {changeColor();}, textInputType: TextInputType.text)),
           Visibility(
                visible: isVisible,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(31, 5, 23, 0),
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan> [
                          TextSpan(text: "A", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: capitalLetter,
                            fontSize: 13
                          )),
                          TextSpan(text: "a", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: containSmall,
                            fontSize: 13
                          )),
                          TextSpan(text: 123456.toString(), style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: containNumber,
                            fontSize: 13
                          )),
                          TextSpan(text: "*", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: containSpecial,
                            fontSize: 13
                          ))
                        ]
                      ),
                    )
                  ),
              ),
            InputBox(controller: widget.confirmPassword, context: context, isPassword: true, initialValue: "Confirm Password", onChanged: (String val) {debugPrint(val);}, textInputType: TextInputType.text),
            Button(text: "Change password", onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));}, height: 38, width: double.infinity, margin: const EdgeInsets.fromLTRB(22, 47, 22, 10),)
          ],
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
    margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Change Password",
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