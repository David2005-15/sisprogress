import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/data%20class/notification_data.dart';
import 'package:sis_progress/widgets/dashboard/notification_tile.dart';

class NotificationPage extends StatefulWidget {
  final List<NotificationData> notifications;

  const NotificationPage({
    required this.notifications,
    super.key
  });

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          buildTitle(),
          // widget.notifications.map((e) => null).toList()
          Visibility(
            visible: visibility,
            child: NotificationTile(data: widget.notifications[0], onTap: removeNote)
          )
        ],
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
        "Notifications",
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

