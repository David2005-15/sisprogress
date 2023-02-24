import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/page/home.dart';

import '../widgets/custom_button.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Color(0xff121623)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.signal_wifi_connected_no_internet_4_outlined,
              color: Colors.white,
              size: 25,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: DefaultTextStyle(
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white
                ),
                child: const Text(
                  "You have no internet connection",
                ),
              ),
            ),

            Button(
                text: "Retry",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                height: 45,
                width: 150
            )
          ],
        ),
      ),
    );
  }
}