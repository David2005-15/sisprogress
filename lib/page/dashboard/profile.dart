import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/dashboard/profile_university_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _Profile();

} 

class _Profile extends State<Profile> {
  bool isEditable = false;

  void changeMode() {
    setState(() {
      isEditable = true;
    });
  }

  void onSave() {
    setState(() {
      isEditable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            buildTitle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                buildCard(<Color> [const Color(0xffD2DAFF), const Color(0xff355CCA)]),
                buildCard(<Color> [const Color(0xffFCD2D1),const Color(0xffFF5C58)]),
                buildCard(<Color> [const Color(0xffD2C5DF), const Color(0xff8675A9)]),
              ],
            ),

            UniversityTile(onEdit: changeMode, mode: isEditable, onSave: onSave,)
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
        "My profile",
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


Container buildCard(List<Color> colors) {
  return Container( 
    margin: const EdgeInsets.fromLTRB(0, 37, 0, 0), 
    height: 115,
    width: 95,
    decoration: BoxDecoration(
      color: colors[0],
      borderRadius: BorderRadius.circular(10)
    ),
    
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Text(
          "24",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: colors[1]
          ),
        ),

        Text(
          "Days in training",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: colors[1]
          ),
        )
      ],
    ),
  );
}