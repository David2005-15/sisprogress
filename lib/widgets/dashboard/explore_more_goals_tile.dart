import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';

class ExploreTile extends StatelessWidget {
  final String title;
  final String position;
  bool disabled;
  final int taskId;
  final String taskCount;
  final VoidCallback onClick;

  ExploreTile({
    required this.onClick,
    required this.taskCount,
    required this.taskId,
    required this.title,
    required this.disabled,
    required this.position,
    super.key
  });

  Client httpClient = Client();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 190,
          margin: const EdgeInsets.fromLTRB(15, 14, 15, 0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Color(0xFFAAC4FF),
          ),
          child: Stack(
            children: <Widget> [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: const ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                    child: Image(
                      image: AssetImage("assets/Books.png"),
                      height: 95,
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: (190 / 2) - 12,
                  child: Stack(
                    children: <Widget> [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(14, 0, 20, 0),
                                    child: Text(
                                      "Company",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: const Color(0xff2E2323)
                                      ),
                                    ),
                                  ),
                                  Text(
                                    title,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: const Color(0xff2E2323)
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(14, 0, 20, 0),
                                    child: Text(
                                      "Position",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: const Color(0xff2E2323)
                                      ),
                                    ),
                                  ),
                                  Text(
                                    position,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: const Color(0xff2E2323)
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget> [
                            Container(
                              margin: const EdgeInsets.fromLTRB(17, 0, 7, 10),
                              child: const Icon(Icons.calendar_month, size: 11, color: Color(0xff2E2323),)
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 7, 10),
                              child: Text(
                                taskCount,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  color: const Color(0xff2E2323)
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 8, 10),
                          height: 23,
                          width: 73,
                          child: ElevatedButton(
                            onPressed: disabled ? () {
                              state(() {                              
                                httpClient.addTask(taskId, DateTime.now().toIso8601String());
                                onClick();
                                disabled = false;
                              });   
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff355CCA)
                            ),
                            child: const Text("ADD"),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        );
      }
    );
  }

}