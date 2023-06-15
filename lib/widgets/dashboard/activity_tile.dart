import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/widgets/custom_button.dart';

class ActivityTile extends StatelessWidget {

  final bool mode;
  final VoidCallback onEdit;
  final Map<String, int> selectedActivities;
  final Function(String) onRemove;
  final VoidCallback onClose;
  final List<dynamic> selection;
  final VoidCallback onSubmit;

  final Function(String) onSelect;
  final Function(String) onAdd;
  final Function(String) onSubtract;

  const ActivityTile({
    required this.mode,
    required this.onEdit,
    required this.selectedActivities,
    required this.onRemove,
    required this.onClose,
    required this.selection,
    required this.onAdd,
    required this.onSelect,
    required this.onSubtract,
    required this.onSubmit,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClose,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const <BoxShadow>[
              BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
            ],
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xff272935),
                  Color(0xff121623),
                ])),
        child: Wrap(
          children: [
            Column(
              children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 13, 0, 0),
                      child: Text(
                        "Extracurricular activities",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: const Color(0xffD2DAFF)),
                      ),
                    ),
                    mode
                        ? Container()
                        : InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: onEdit,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 15, 0),
                        child: Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),

                Container(
                  width: double.infinity,
                  margin: mode ? const EdgeInsets.fromLTRB(23, 15, 0, 10)
                      : const EdgeInsets.fromLTRB(23, 15, 0, 10),
                  child: Column(
                    children: <Widget> [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                        child: Wrap(
                          runSpacing: 10,
                          spacing: 5.0,
                          direction: Axis.horizontal,
                          children: selectedActivities.entries.map((entry) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                              height: 29,
                              // width: 150,
                              width: entry.key.toString().length * 10,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: const Color(0xffB1B2FF))),

                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        entry.key,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xffB1B2FF)),
                                      ),

                                      Text(
                                        " (${entry.value})",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: const Color(0xffB1B2FF)),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            if(mode) onRemove(entry.key);
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            size: 15,
                                            color: Color(0xffB1B2FF),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                !mode ? Container() : Container(
                    margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return TextFormField(
                        readOnly: true,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: "Select your activities",
                          labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: const Color(0xffD2DAFF)),
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              color: const Color(0xffD2DAFF)),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffD2DAFF), width: 1)),
                          border: const UnderlineInputBorder(
                              borderSide:
                              BorderSide(color: Color(0xffD2DAFF), width: 1)),
                          focusColor: const Color(0xffD2DAFF),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff36519D))),
                          suffixIcon: PopupMenuButton<String>(
                            color: const Color(0xffD2DAFF),
                            constraints: BoxConstraints.expand(
                                height: 150, width: constraints.maxWidth),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xffD2DAFF),
                            ),
                            onSelected: (String value) {
                              // controller.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return selection
                                  .map<PopupMenuItem<String>>((dynamic value) {

                                return PopupMenuItem(
                                    value: value,
                                    child: StatefulBuilder(
                                        builder: (context, state) {
                                          return Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.fromLTRB(
                                                        5, 0, 5, 0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        onSelect(value);
                                                        state(() {

                                                        });
                                                        // int sum = 0;
                                                        // if(activities.isNotEmpty) {
                                                        //   sum = activities.values.reduce((value, element) => value + element);
                                                        // }
                                                        // state(() {
                                                        //   // int sum = activities.values.reduce((value, element) => value + element);
                                                        //   // print(sum);
                                                        //
                                                        //   if(!activities.containsKey(value) && sum < 10) {
                                                        //     activities[value] = 1;
                                                        //   } else {
                                                        //     activities.remove(value);
                                                        //   }
                                                        // });
                                                        //
                                                        // setState(() {
                                                        //
                                                        // });
                                                      },
                                                      child: Container(
                                                        width: 24,
                                                        height: 24,
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                            border: Border.all(
                                                                width: 1.5,
                                                                color: const Color(
                                                                    0xff355CCA))),
                                                        child: selectedActivities.containsKey(value) ? const Icon(
                                                            Icons.check,
                                                            size: 18,
                                                            color: Color(0xff355CCA)
                                                        ): null,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    value.length > 20 ? value.substring(0, 20) : value,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      color: const Color(0xff121623),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    margin: const EdgeInsets.fromLTRB(
                                                        0, 0, 5, 0),
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xff355CCA)
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: const Color(
                                                                0xff355CCA))),
                                                    child: InkWell(
                                                        onTap: () {
                                                          onSubtract(value);
                                                          state(() {

                                                          });
                                                          // state(() {
                                                          //   if(activities.containsKey(value)) {
                                                          //     activities.update(value, (val) {
                                                          //       if(val > 0) {
                                                          //         val -= 1;
                                                          //       }
                                                          //
                                                          //       return val;
                                                          //     });
                                                          //   }
                                                          // });
                                                          //
                                                          // setState(() {
                                                          //
                                                          // });
                                                        },
                                                        child: const Icon(
                                                            Icons.remove,
                                                            size: 14,
                                                            color:
                                                            Color(0xff355CCA))),
                                                  ),
                                                  Text(selectedActivities.containsKey(value) ? selectedActivities[value].toString() : "0"),
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    margin: const EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xff355CCA)
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                        BorderRadius.circular(5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: const Color(
                                                                0xff355CCA))),
                                                    child: InkWell(
                                                        onTap: () {

                                                          onAdd(value);
                                                          state(() {

                                                          });

                                                          // int sum = 0;
                                                          // if(activities.isNotEmpty) {
                                                          //   sum = activities.values.reduce((value, element) => value + element);
                                                          // }
                                                          //
                                                          // state(() {
                                                          //
                                                          //   if(activities.containsKey(value) && sum < 10) {
                                                          //     activities.update(value, (val) {
                                                          //       if(val < 10) {
                                                          //         val += 1;
                                                          //       }
                                                          //
                                                          //       return val;
                                                          //     });
                                                          //   }
                                                          // });
                                                          //
                                                          // setState(() {
                                                          //
                                                          // });
                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 14,
                                                          color: Color(0xff355CCA),
                                                        )),
                                                  )
                                                ],
                                              )
                                            ],
                                          );
                                        }));
                              }).toList();
                            },
                          ),
                        ),
                      );
                    })),

                mode ? Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 15),
                  child: Row(
                    children: <Widget> [
                      Container(
                        height: 38,
                        width: 128,
                        margin: const EdgeInsets.fromLTRB(22, 20, 22, 10),
                        child: ElevatedButton(
                          onPressed: () {
                            onClose();
                            // _controller1 =
                            //     TextEditingController(text: widget.selectedUniversity);
                            // widget.onSave();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              side: const BorderSide(width: 1.5, color: Color(0xffD2DAFF))
                          ),
                          child: Text(
                              "Discard",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: const Color(0xffD2DAFF)
                              )
                          ),
                        ),
                      ),

                      Button(
                        width: 128,
                        height: 38,
                        onPressed: onSubmit,
                        text: "Submit",
                      )
                    ],
                  ),
                ): Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
