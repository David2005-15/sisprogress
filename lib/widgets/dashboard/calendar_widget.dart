import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data class/popup_menu_status.dart';

typedef Select<T> = Function(T);


class CalendarWidget extends StatefulWidget {
  final String value;
  final List<int> years;
  final Select<String> onSelected;
  final VoidCallback? onCanceled;
  PopupMenuStatus status;


  CalendarWidget({
    required this.onCanceled,
    required this.status,
    required this.onSelected,
    required this.value,
    required this.years,
    super.key
  });
  
  @override
  State<StatefulWidget> createState() => _CalendarWidget();
}

class _CalendarWidget extends State<CalendarWidget> {
  late Map<DateTime, List<String>> selectedEvents;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(
            children: <Widget> [
              RichText(
                text: TextSpan(
                  text: "December ",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: const Color(0xffB1B2FF)
                  ),
                  children: <TextSpan> [
                    TextSpan(
                      text: "4, ${widget.value}",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: const Color(0xffB1B2FF)
                      )
                    )
                  ]
                ),
              ),

              PopupMenuButton(
                onSelected: (val) {
                  widget.onSelected(val.toString());
                },
                
                onCanceled: widget.onCanceled,
                offset: const Offset(20, 50),
                icon: widget.status == PopupMenuStatus.closed ? const Icon(
                  Icons.arrow_back_outlined, 
                  color: Color(0xffB1B2FF)
                ) : const Icon(
                  Icons.arrow_forward_outlined,
                  color: Color(0xffB1B2FF)
                ),
                color: const Color(0xff3A3D4C),
                itemBuilder: (BuildContext context) {  
                  return widget.years.map<PopupMenuItem<String>>((int value) {
                    return PopupMenuItem(value: value.toString(), child: Text(value.toString(), style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.white
                    ),));
                  }
                ).toList();},
              )
            ],
          ),
        ],
      )
    );
  }
}