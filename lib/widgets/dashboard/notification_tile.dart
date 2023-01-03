import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/notification_data.dart';

class NotificationTile extends StatelessWidget {
  final NotificationData data;
  final VoidCallback onTap;

  const NotificationTile({
    required this.data,
    required this.onTap,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.fromLTRB(16, 15, 16, 0),
    width: double.infinity,
    height: 50,
    decoration: const BoxDecoration(
      color: Color(0xff1D2338),
      borderRadius: BorderRadius.all(Radius.circular(2))
    ),

    child: Stack(
      children: <Widget> [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 9, 0, 0),
            child: Row(
              children: [
                const Icon(
                  Icons.circle, 
                  color: Color(0xff355CCA), 
                  size: 10,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  data.title,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 9),
            child: Text(
              data.description,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: const Color(0xffBFBFBF)
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 9, 9, 0),
            child: InkWell(
              onTap: onTap,
              child: const Icon(
                Icons.close,
                size: 11,
                color: Colors.grey,
              ),
            ),
          ),
        )
      ]
    ),
  );
  }

}