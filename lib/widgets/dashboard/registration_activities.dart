import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationActivities extends StatelessWidget{
  final TextEditingController controller;
  final String labelText;
  final List<String> items;
  final List<String> actions;
  final Function(String) addValue;
  final Function(String) removeValue;

  const RegistrationActivities({
    required this.labelText,
    required this.controller,
    required this.items,
    required this.actions,
    required this.addValue,
    required this.removeValue,

    super.key
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, state) {
        return Container(
        margin: const EdgeInsets.fromLTRB(23, 0, 23, 0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return TextFormField(
            readOnly: true,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    color: Colors.white),
                controller: controller,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: labelText,
                  // hintText: widget.hintText,
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
                      borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)),
                  border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)),
                  focusColor: const Color(0xffD2DAFF),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff36519D))),
                  suffixIcon: PopupMenuButton<String>(
                    color: const Color(0xffD2DAFF),
                    constraints:
                        BoxConstraints.expand(height: 150, width: constraints.maxWidth),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xffD2DAFF),
                    ),
                    onSelected: (String value) {
                      // controller.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      


                      return items.map<PopupMenuItem<String>>((String value) {
                        bool isEnabled = actions.where((element) => element.contains(value)).isNotEmpty;

                        return PopupMenuItem(
                            value: value,
                            child: StatefulBuilder(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [ 
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                          child: InkWell(
                                            onTap: () {
                                                if(actions.length != 10) {
                                                  if(!isEnabled) {
                                                    addValue(value); 
                                                  } else {
                                                    removeValue(value);
                                                  }
                                                }
                                                state(() {
                                                  isEnabled = !isEnabled;
                                                });
                                              
                                            },
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                border: Border.all(width: 1,color: const Color(0xff355CCA))
                                              ),
                                              child:  Icon(
                                                Icons.check,
                                                size: 18,
                                                color: isEnabled ?  const Color(0xff355CCA): Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          value.length > 20 ? value.substring(0, 20): value,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color: const Color(0xff121623),
                                          ),
                                        ),
                                      ],
                                    ),
          
                                    Row(
                                      children: <Widget> [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          decoration: BoxDecoration(
                                            color: Color(0xff355CCA).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(5),
          
                                            border: Border.all(width: 1, color: const Color(0xff355CCA))
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                                removeValue(value);
                                            }, 
                                            child: const Icon(
                                              Icons.remove,
                                              size: 14,
                                              color: Color(0xff355CCA)
                                            )
                                          ),
                                        ),
          
                                        Text(
                                          isEnabled ? "${actions.where((e) => e.contains(value)).length}" : "1"
                                        ),
                                        
                                        Container(
                                          width: 20,
                                          height: 20,
                                          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff355CCA).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(5),
          
                                            border: Border.all(width: 1, color: const Color(0xff355CCA))
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                                if(actions.length != 10) {
                                                  if(actions.where((element) => element == value).length != 0) {
                                                    addValue("$value (${actions.where((element) => element == value).length})");
                                                  }                     
                                                }
                                            }, 
                                            child: const Icon(
                                              Icons.add,
                                              size: 14,
                                              color: Color(0xff355CCA),
                                            )
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              }
                            ));
                      }).toList();
                    },
                  ),
                ),
              );
            }
          ));
      }
    );
    }

    double getContainerWidth (String value) {
      if(value.length < 7) {
        return 60;
      }

      return value.length * 10;
    }
  }
