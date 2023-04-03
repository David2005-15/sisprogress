import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/notification_data.dart';
import 'package:sis_progress/widgets/dashboard/notification_tile.dart';

class NotificationPage extends StatefulWidget {
  final List<NotificationData> notifications;

  const NotificationPage({required this.notifications, super.key});

  @override
  State<StatefulWidget> createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  bool visibility = true;

  void removeNote() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Text(
        "You don’t have any notification right now.",
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
      ),
    );
  }
}

Container notificationTile() {
  return Container(
    width: 360.1,
    height: 84.4,
    decoration: const BoxDecoration(
      color: Color(0xFFCC8E8E),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(2),
        bottomRight: Radius.circular(3),
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
      ),
      shape: BoxShape.rectangle,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        15, 10, 0, 0),
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, -1),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          20, 10, 0, 0),
                      child: Text(
                        'Hello World',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Align(
                alignment: AlignmentDirectional(1, 1),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0, 10, 25, 0),
                  child: Icon(
                    Icons.settings_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 0, 0),
            child: Text(
              'Hello World',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.black
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "Notifications",
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            letterSpacing: -0.02,
            color: Colors.white),
      ),
    ),
  );
}
