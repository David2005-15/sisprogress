import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';

class AccountDeletion extends StatelessWidget {
  const AccountDeletion({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(buildLogoIcon(), List.empty()),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 15),
          decoration: BoxDecoration(
            color: const Color(0xff3A3D4C),
            borderRadius: BorderRadius.circular(5)
          ),
          alignment: Alignment.center,
          child: Text(
            "Your account has been successfully deleted. We're sorry to see you go.",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: const Color(0xffB1B2FF)
            ),
          )
        )
          // child: RichText(
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     text: "Your account has been successfully deleted.We're sorry to see you go.",
          //     style: GoogleFonts.montserrat(
          //       fontWeight: FontWeight.w600,
          //       fontSize: 24,
          //       color: const Color(0xffB1B2FF)
          //     ),
          //   ),
          // ),
      ),
    );
  }
}

Image buildLogoIcon() {
  return Image.asset(
    "assets/logo.png",
  );
}