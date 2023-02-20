import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/forgot_password.dart';
import 'package:sis_progress/page/home.dart';
import 'package:sis_progress/page/registration.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/input_box.dart';
import 'dashboard/scaffold_keeper.dart';


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
  Color iconColor = Colors.transparent;
  Color borderColor = Colors.white;

  Client httpClient = Client();


  String fullNameErrorText = "";
  String emailErrorText = "";
  bool showValidationOrNo = false;
  bool showEmailValidation = false;


  bool showErrorVisibility = false; 

  final RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  bool emailMatch(String email) {
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

        return Future.value(false);
      },
      child: Scaffold(
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
                // InputBox(textInputType: TextInputType.text, onChanged: (String val) {print(val);}, context: context, controller: widget.fullName, isPassword: false, initialValue: "Full Name", errorText: fullNameErrorText, showValidationOrNot: showValidationOrNo,),
                InputBox(textInputType: TextInputType.emailAddress, onChanged: (String val) {}, context: context, controller: widget.email, isPassword: false, initialValue: "Email", errorText: emailErrorText, showValidationOrNot: showEmailValidation,),
                InputBox(textInputType: TextInputType.text, onChanged: (String val) {}, context: context, controller: widget.password, isPassword: true, initialValue: "Password"),
                Visibility(
                  visible: showErrorVisibility,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Text(
                      "Email or password is invalid",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.red
                      ),
                    ),
                  )
                ),
                buildLowerRow(isVisible, () {
                  setState(() {
                    isVisible = !isVisible;
                    if(isVisible) {
                      iconColor = const Color(0xff355CCA);
                      borderColor = const Color(0xff355CCA);
                    } else {
                      iconColor = Colors.transparent;
                      borderColor = const Color(0xffBFBFBF);
                    }
                  });
                }, context, iconColor, borderColor),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Button(text: "Log In", onPressed: () async {
    
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ScaffoldHome()));
                    if(!emailMatch(widget.email.text)) {
                      setState(() {
                        showEmailValidation = true;
                        emailErrorText = "Email must be in the correct format";
                      });
                    } else {
                      setState(() {
                        showEmailValidation = false;
                      });
                    }
    
                    try {
                      var value = await httpClient.loginUser(widget.email.text, widget.password.text);
                      if(value["success"]) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScaffoldHome()));
                      }
                    } catch(e) {
                      setState(() {
                        showErrorVisibility = true;
                      });
                    }
                    // print(value["fullName"]);
                    // print(value["fullName"]);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const ScaffoldHome()));
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
    // alignment: Alignment.centerLeft,
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

FittedBox buildLowerRow(bool isVisible, Function() onChange, BuildContext context, Color iconColor, Color borderColor) {
  return FittedBox(
    fit: BoxFit.contain,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Container(
          margin: const EdgeInsets.fromLTRB(5, 5, 15, 0),
          child: Row(
            children: <Widget> [
              buildCheckbox(iconColor: iconColor, borderColor: borderColor, onChange: onChange),

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
          margin: const EdgeInsets.fromLTRB(15, 5, 5, 0),
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
  );
}

Container buildCheckbox({required Color iconColor, required Function() onChange, required Color borderColor}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: borderColor, width: 1),
      color: Colors.transparent
    ),

    child: InkWell(
      onTap: onChange,
      child: Icon(Icons.check, color: iconColor, size: 11,),
    ),
  );
}