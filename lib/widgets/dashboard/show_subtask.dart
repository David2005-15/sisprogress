import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subtask extends StatefulWidget {
  final String compamyName;
  List<dynamic>? addedTasks;


  Subtask({
    required this.compamyName,
    required this.addedTasks,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Subtask();

}


class _Subtask extends State<Subtask> {
  bool showSubtask = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
                    Text(
                      widget.compamyName.length > 20 ? "${widget.compamyName.substring(0, 15)}..." : widget.compamyName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color(0xff2E2323)
                      ),
                    ),

                    StatefulBuilder(builder: ((context, setState) {
                      return Checkbox(
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                         value: showSubtask,
                         onChanged: ((value) {
                           setState(() {
                            Set<dynamic> mySet = Set.from(widget.addedTasks!);
                            widget.addedTasks = mySet.toList();
                            showSubtask = value!;
                            value ? widget.addedTasks!.add(widget.compamyName): widget.addedTasks!.remove(widget.compamyName);
                            print(widget.addedTasks);
                           });
                         })
                        );
                    }))
                  ],
                );
  }

}

Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }