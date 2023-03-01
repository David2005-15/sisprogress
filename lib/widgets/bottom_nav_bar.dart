import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class NavBar extends StatelessWidget {
  final int selected;
  final Function(int) onChange;

  const NavBar({
    required this.selected,
    required this.onChange,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 14),
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),     
        color: Colors.transparent
      ),
      height: Platform.isIOS ? 86 : 67,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff3A3D4C),
          unselectedItemColor: const Color(0xffD2DAFF),
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal
          ),
          selectedItemColor: const Color(0xffAAC4FF),
          showSelectedLabels: true,
          showUnselectedLabels: false,

          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/Home.png"), size: 24,),
              label: "Dashboard"
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/NavCal.png"), size: 24,),
              label: "Extraculicular\n    calendar",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/Tasks.png"), size: 24,),
              label: "Goals"
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/Checklist.png"), size: 24,),
              label: "My tasks"
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/Profile.png"), size: 24,),
                label: "Profile"
              ),
            ],
            currentIndex: selected,
            onTap: onChange,
        ),
      ),
    );
  }
}