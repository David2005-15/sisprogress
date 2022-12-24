import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tile extends StatefulWidget {
  final Color color;
  final Widget icon;
  final int point;
  final String description;


  const Tile({
    required this.icon,
    required this.point,
    required this.description,
    required this.color,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Tile();

}

class _Tile extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width: 154,
        height: 148,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.color
        ),
        child: Stack(
          children: <Widget> [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: widget.icon,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 26, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.point.toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 32,
                    color: const Color(0xff2E2323)
                  ),
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 0, 16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.description,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xff2E2323)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}