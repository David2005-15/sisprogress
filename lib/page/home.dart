import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/page/login.dart';
import 'package:sis_progress/page/registration.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 10 + 30,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 103),
              child: Image.asset(
                "assets/logo.png"
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 202,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow> [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: const Offset(0 , 10),
                      spreadRadius: 20,
                      blurRadius: 30
                    )
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color> [
                      Color(0xff272935),
                      Color(0xff121623),
                    ]
                  )
                ),
                child: Stack(
                  children: <Widget> [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 15, 0, 3),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Welcome SIS Progress!",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
          
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 145),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Let’s explore more togther.",
                            style:  GoogleFonts.montserrat(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xffBFBFBF)
                            ),
                          ),
                        ),
                      ),
                    ),
          
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 77),
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: const Color(0xff36519D)
                          ),
                          child: Text(
                            "Log In",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
          
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 15),
                        child: OutlinedButton(
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            print(prefs.getKeys());
                            // print(prefs.getAll());
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
                          },
                          style: OutlinedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: const BorderSide(width: 1, color: Color(0xff36519D))
                          ),
                          child: Text(
                            "Registration",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: const Color(0xff36519D)
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }

}