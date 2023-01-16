import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/event_process.dart';

class EventTile extends StatelessWidget {
  final String title;
  final EventProccess proccess;

  const EventTile({
    required this.proccess,
    required this.title,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        width: double.infinity,
        height: 75,
        margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
        decoration: BoxDecoration(
          color: proccess.eventColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                  width: 4,
                  height: 63,
                  decoration: BoxDecoration(
                    color: proccess.leftColor,
                    borderRadius: BorderRadius.circular(7)
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(17, 8, 0, 0),
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: const Color(0xff2E2323)
                        ),
                      ),
                    ),
    
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(17, 0, 5, 8),
                          child: proccess.icon
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Text(
                            proccess.eventName,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              color: const Color(0xff2E2323)
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

  // Future<void> _dialogBuiler(BuildContext) {
  //   return showDialog(
  //     context: context, builder: builder
  //   );
  // }

}