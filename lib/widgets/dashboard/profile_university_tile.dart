import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/input_box.dart';

class UniversityTile extends StatefulWidget {
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final bool mode;

  const UniversityTile({
    required this.onSave,
    required this.onEdit,
    required this.mode,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _UniversityTile();

}

class _UniversityTile extends State<UniversityTile> {
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;
  late TextEditingController _controller4;
  List<String> items = ['Harvard University', 'MIT', 'Standford'];

  @override
  void initState() {
    _controller1 = TextEditingController();
    _controller2 =  TextEditingController();
    _controller3 = TextEditingController();
    _controller4 =  TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    // width: double.infinity,
    // height: widget.mode ? 300: 112,
    margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      boxShadow: const <BoxShadow> [
        BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color> [
          Color(0xff272935),
          Color(0xff121623),
        ]
      )
    ),
    
    child: Wrap(
      children: [Column(
        children: <Widget> [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 13, 0, 0),
                child: Text(
                  "University choice",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: const Color(0xffD2DAFF)
                  ),
                ),
              ),
      
              widget.mode ? Container() : InkWell (
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: widget.onEdit,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 13, 15, 0),
                  child: Text(
                    "Edit",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.grey
                    ),
                  ),
                ),
              )
            ],
          ),
      
          widget.mode ?  buildMode(_controller1, items):Container(
            margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: Text(
                    "University",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Container(
                  child: Text(
                    "Harvard",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.grey
                    ),
                  ),
                )
              ],
            ),
          ),
      
          widget.mode ? buildMode(_controller2, items) : Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget> [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 30, 15),
                  child: Text(
                    "Faculty",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                ),
          
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Text(
                    "Human Resources",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: Colors.grey
                    ),
                  ),
                )
              ],
            ),
          ),
      
          widget.mode ? buildMode(_controller3, items) : Container(),

          widget.mode ? InputBox(textInputType: TextInputType.number, onChanged: (val) {}, context: context, controller: _controller4, isPassword: false, initialValue: "Dream Point",): Container(),
          widget.mode ? InputBox(textInputType: TextInputType.number, onChanged: (val) {}, context: context, controller: _controller4, isPassword: false, initialValue: "Target Point",): Container(),
          widget.mode ? InputBox(textInputType: TextInputType.number, onChanged: (val) {}, context: context, controller: _controller4, isPassword: false, initialValue: "Safety Point",): Container(),

          widget.mode ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              Button(text: "Change ", onPressed: widget.onSave, height: 38, width: 128),
            ],
          ): Container()
        ],
      )],
    ),
    );
  }
}


Container buildMode(TextEditingController controller, List<String> items) {
  return Container(
            margin: const EdgeInsets.fromLTRB(23, 16, 23, 0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return TextFormField(
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    color: Colors.white
                  ),
                  controller: controller, 
                  decoration: InputDecoration(
                    
                    alignLabelWithHint: true,
                    labelText: "Harvard University",
          // hintText: widget.hintText,
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      color: const Color(0xffD2DAFF)
                    ),
                    hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      color: const Color(0xffD2DAFF)
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD2DAFF), width: 1)
                    ),
                    focusColor: const Color(0xffD2DAFF),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff36519D))
                    ),
                    suffixIcon: PopupMenuButton<String>(
                      color: const Color(0xffD2DAFF),
                      constraints: BoxConstraints.expand(height:150, width: constraints.maxWidth),
                        icon: const Icon(Icons.arrow_drop_down, color:  Color(0xffD2DAFF),),
                        onSelected: (String value) {
                          controller.text = value;
                        },
                        itemBuilder: (BuildContext context) {
                          
                          return items.map<PopupMenuItem<String>>((String value) {
                            return PopupMenuItem(value: value, child: Text(value, style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: const Color(0xff121623),
                            ),));
                          }
                        ).toList();
                      },
                    ),
                  ),
                );
              }
            ),
          );
}