import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/dashboard/dashboard.dart';
import 'package:sis_progress/page/forgot_password.dart';
import 'package:sis_progress/page/registration.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/input_box.dart';

class LoginPage extends StatefulWidget {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
  
}

class _LoginPage extends State<LoginPage> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(17, 25, 17, 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xff3A3D4C)
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              buildTitle(),
              InputBox(textInputType: TextInputType.text, onChanged: (String val) {print(val);}, context: context, controller: widget.fullName, isPassword: false, initialValue: "Full Name"),
              InputBox(textInputType: TextInputType.emailAddress, onChanged: (String val) {print(val);}, context: context, controller: widget.email, isPassword: false, initialValue: "Email"),
              InputBox(textInputType: TextInputType.text, onChanged: (String val) {print(val);}, context: context, controller: widget.password, isPassword: true, initialValue: "Password"),
              buildLowerRow(isVisible, (val) {
                setState(() {
                  isVisible = val ?? false;
                });
              }, context),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Button(text: "Log In", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(fullName: widget.fullName.text,)));
                }, height: 38, width: 280)
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(35, 30, 35, 20),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Text(
                        "I don't have an account?",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white
                        ),
                      ),
                              
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
                        }, 
                        child: Text(
                          "Registration",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14, 
                            color: const Color(0xff355CCA)
                          ),
                        )
                      )
                    ],
                  ),
                ),
              )
            ],
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
    margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Log in",
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

Container buildLowerRow(bool isVisible, Function(bool?) onChange, BuildContext context) {
  return Container(
    child: FittedBox(
      fit: BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 0, 0),
            child: Row(
              children: <Widget> [
                CustomCheckBox(
                  borderRadius: 2,
                  uncheckedFillColor: Colors.transparent,
                  checkedFillColor: const Color(0xff355CCA),
                  uncheckedIcon: Icons.check,
                  uncheckedIconColor: Colors.transparent,
                  borderColor: const Color(0xffAAC4FF),
                  value: isVisible, 
                  onChanged: onChange
                ),
                Text(
                  "Remember me",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: const Color(0xff355CCA)
                ),
              )
            ],
            ),
          ),
    
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 20, 0),
            child: TextButton(
              child: Text(
                "Forget Password?",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: const Color(0xff355CCA)
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
            ),
          )
        ],
      ),
    ),
  );
}