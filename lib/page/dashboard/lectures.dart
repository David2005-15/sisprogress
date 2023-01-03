import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lectures extends StatefulWidget {
  const Lectures({super.key});

  @override
  State<StatefulWidget> createState() => _Lectures();

}

class _Lectures extends State<Lectures> {
  List<Color> colors = [Colors.white, Colors.white, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            buildTitle(),
            Container(
              width: double.infinity,
              height: 35,
              margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color> [
                    Color(0xff272935),
                    Color(0xff121623),
                  ]
                ),

                boxShadow: <BoxShadow> [
                  BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
                ]
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget> [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        colors = [Colors.white, Colors.white, Colors.white];
                        colors[0] = const Color(0xffFE8F8F);
                      });
                    }, 
                    child: Text(
                      "All",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: colors[0]
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        colors = [Colors.white, Colors.white, Colors.white];
                        colors[1] = const Color(0xffFE8F8F);
                      });
                    }, 
                    child: Text(
                      "Favourits",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: colors[1]
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        colors = [Colors.white, Colors.white, Colors.white];
                        colors[2] = const Color(0xffFE8F8F);
                      });
                    }, 
                    child: Text(
                      "Recently viewed",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: colors[2]
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Lectures",
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