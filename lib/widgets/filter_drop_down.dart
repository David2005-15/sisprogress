import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterDropDown extends StatelessWidget {
  final List<String> statuses;
  final String status;
  final Function(String) onChange;

  FilterDropDown({
    required this.statuses,
    required this.status,
    required this.onChange,
    super.key
  });

  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        dynamic state = _menuKey.currentState;
        state.showButtonMenu();
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 0, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 1, color: const Color(0xff355CCA))
        ),
        width: 176,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Text(
                status,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color(0xff355CCA)
                ),
              ),
            ),

            Theme(
              data: Theme.of(context).copyWith(
                highlightColor: const Color(0xffAAC4FF),
                splashColor: Colors.transparent,
              ),
              child: PopupMenuButton(
                key: _menuKey,
                icon: Transform.rotate(
                    angle: 3.14159,
                    child: SvgPicture.asset("assets/VectorChevron.svg",
                      width: 12.5, height: 7.5,)
                ),

                onSelected: (val) async {
                  onChange(val);
                  // await printAllTasks();
                  //
                  // setState(() {
                  //   statusText = val;
                  //   if (statusText != "All") {
                  //     tasks = tasks.where((element) =>
                  //     element["status"] == val).toList();
                  //   }
                  // });
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),

                offset: const Offset(-120, 50),
                // color: const Color(0xff3A3D4C),
                color: const Color(0xffD2DAFF),
                itemBuilder: (BuildContext context) {
                  return statuses.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(value: value.toString(),
                        child: Text(
                          value.toString(), style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: const Color(0xff3A3D4C)
                        ),));
                  }
                  ).toList();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}