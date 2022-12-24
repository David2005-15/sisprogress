import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/change_password.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/input_box.dart';

class ForgotPassword extends StatefulWidget {
  final TextEditingController controller = TextEditingController();

  ForgotPassword({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPassword();
}


class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
        // constraints: const BoxConstraints.expand(),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff3A3D4C),
          borderRadius: BorderRadius.circular(5)
        ),
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              buildTitle(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: InputBox(textInputType: TextInputType.emailAddress, onChanged: (val) => print(val), context: context, controller: widget.controller, isPassword: false, initialValue: "Your working email",)
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Button(text: "Send email", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                }, height: 38, width: double.infinity)
              ),
      
              buildSendAgainButton(context)
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
        "Forgot Your Password",
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

Container buildSendAgainButton(BuildContext context) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 15, 0, 20),
    child: TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "Back to log in",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: const Color(0xff355CCA)
        ),
      ),
    ),
  );
}