import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTask extends StatefulWidget {
  const MyTask({super.key});

  @override
  State<StatefulWidget> createState() => _MyTask();

}

class _MyTask extends State<MyTask> {
  List<String> status = ["Completed", "In Progress", "Late Done"];

  String statusText = "Task Status";


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            buildTitle(),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 10, 0, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: const Color(0xff355CCA))
              ),
              width: 176,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Container(
                    margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                    child: Text(
                      statusText,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: const Color(0xff355CCA)
                      ),
                    ),
                  ),

                  PopupMenuButton(
                    icon: ImageIcon(
                      AssetImage("assets/Vectorchevorn.png"),
                      size: 14,
                      color: Colors.grey,
                    ),
          
                  onSelected: (val) {
                    setState(() {
                      statusText = val;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                  ),

                  offset: const Offset(-120, 50),
                // color: const Color(0xff3A3D4C),
                  color: const Color(0xffD2DAFF),
                  itemBuilder: (BuildContext context) {
                    return status.map<PopupMenuItem<String>>((String value) {
                      return PopupMenuItem(value: value.toString(), child: Text(value.toString(), style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: const Color(0xff3A3D4C)
                      ),));
                    }
                  ).toList();
                },
                )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5, 32, 5, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Container(
                    margin: const EdgeInsets.fromLTRB(45, 0, 0, 0),
                    child: Text(
                      "Status",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: const Color(0xffBFBFBF)
                      ),
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                    child: Text(
                      "Due date for max points",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: const Color(0xffBFBFBF)
                      ),
                    )
                  )
                ],
              ),
            ),

            buildTile("Company", "In Progress", "Position Name", "7th of Dec, 2023", const Color(0xff94B49F)),
            buildTile("Company", "Overdue", "Position Name", "7th of Dec, 2023", const Color(0xffFFC900)),
            buildTile("Company", "Late Done", "Position Name", "7th of Dec, 2023", const Color(0xffE31F1F))
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
        "My Tasks",
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


Container buildTile(String title, String status, String position, String date, Color statusColor) {
  return Container(
              margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
              width: double.infinity,
              height: 75,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(width: 2.5, color: Color(0xffB1B2FF))
                )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xffB1B2FF)
                        ),
                      ),
                      Text(
                        position,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xffB1B2FF)
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(25, 5, 0, 0),
                        child: Text(
                          status,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            color: statusColor
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 45, 10),
                    child: Text(
                      date,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            );
}