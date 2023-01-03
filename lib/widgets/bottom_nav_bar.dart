import 'package:flutter/material.dart';
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),     
      ),
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
              icon: Icon(Icons.home_outlined, size: 24,),
              label: "Home"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.rocket_outlined, size: 24),
              label: "Dashboard"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined, size: 24),
              label: "Lectures"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outlined, size: 24,),
              label: "Profile"
            )
          ],
          currentIndex: selected,
          onTap: onChange,
      ),
    ),
  );
  }

}