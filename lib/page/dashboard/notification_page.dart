import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../http client/http_client.dart';

class NotificationPage extends StatefulWidget {
  final VoidCallback onChange;

  const NotificationPage({
    required this.onChange,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  var notifications = [];
  int id = 0;

  Client client = Client();


  getNotifications() async {
    var result = await client.getNotifications();

    setState(() {
      notifications = result["notifications"];
    });
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Stack(
        children: <Widget> [
          Align(
            alignment: const AlignmentDirectional(-1, -1),
            child: buildTitle(),
          ),

          notifications.isEmpty ? Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Text(
              "You don’t have any notification right now.",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
            ),
          ): SizedBox(
            height: double.infinity,
            child: Column(
              children: notifications.map<Widget>((e) {
                return notificationTile(context, e["notificationTitle"], e["notification"], () async {
                  await client.readNotification(e["id"]);
                  getNotifications();
                  widget.onChange();
                }, e["read"]);
              }).toList(),
            ),
          )
        ],
      )
    );
  }
}

InkWell notificationTile(BuildContext context, String title, String subtitle, VoidCallback onTap, bool isRead) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1D2338),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(3),
          topLeft: Radius.circular(2),
          topRight: Radius.circular(2),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: !isRead ? const Color(0xff355CCA): Colors.white ,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1, -1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5, 10, 0, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Text(
                            title,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-1, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 15, 0, 10),
              child: Text(
                subtitle,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: const Color(0xffBFBFBF)
                ),
              ),
            ),
          ),
        ],
      ),
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
