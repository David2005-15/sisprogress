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
        width: 100,
        height: 148,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: widget.color
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Container(
              margin: const EdgeInsets.fromLTRB(13, 15, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: widget.icon,
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(13, 5, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.point.toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 28,
                    color: const Color(0xff2E2323)
                  ),
                )
              ),
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(13, 5, 0, 16),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  
                  widget.description,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
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