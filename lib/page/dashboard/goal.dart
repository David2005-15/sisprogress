import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/widgets/dashboard/explore_more_goals_tile.dart';

class GoalPage extends StatefulWidget {
  final String title;

  const GoalPage({required this.title, super.key});

  @override
  State<StatefulWidget> createState() => _GoalPage();
}

class _GoalPage extends State<GoalPage> {
  Client client = Client();

  List<Widget> goals = [];
  List<Widget> goals2 = [];

  @override
  void initState() {
    getAllTasks();

    super.initState();
  }

  List<dynamic> tasks = [];

  List<int> items = [];

  List<bool> disableds = [];

  bool showFilter = false;

  // String activities = "Social Justice";

  List<String> value = [];

  List<String> temp = [];

  String filterText = "Activites";
  bool cantYouSee = false;

  OverlayEntry? _overlayEntry;

  void getAllTasks() async {
    var temp = await client.getAllTaskAndFilter();
    // print(temp);
    setState(() {
      tasks = temp;
    });
  }

  Future<bool> _onBackButtonPressed() {
    setState(() {
      cantYouSee = false;
      // Navigator.of(context).pop();
      _overlayEntry!.remove();
      _overlayEntry = null;
    });

    return Future.value(false);
  }

  void updateValues() {
    setState(() {
      tasks.forEach((e) {
        // print(e["SubTasks"].where((p0) => p0['status'] == true).length);
        // print(e["SubTasks"].where((p0) => p0['status'] == true).length);
        items.add(e["SubTasks"]
            .where((p0) => p0['status'] == true)
            .length);
        disableds.add(!(e["isFree"] == false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              buildButton(widget.title, (p0) {}),
              Container(
                  margin: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                      Border.all(width: 1, color: const Color(0xff355CCA))),
                  width: filterText.length * 10 + 80,
                  height: 40,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: Text(
                            filterText,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: const Color(0xff355CCA)),
                          ),
                        ),
                        IconButton(
                          // splashColor: Colors.transparent,
                            onPressed: () {
                              setState(() {
                                temp = value;
                                showFilter = !showFilter;
                                goals2 = goals2.toSet().toList();
                              });
                              if (showFilter) {
                                _overlayEntry = OverlayEntry(builder: (context) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: StatefulBuilder(
                                        builder: (context, state) {
                                          return Container(
                                            width: 174,
                                            height: 200,
                                            margin: const EdgeInsets.fromLTRB(15, 270, 0, 0),
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffD2DAFF),
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Material(
                                                    color: const Color(
                                                        0xffD2DAFF),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      height: 40,
                                                      padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 4, 5, 4),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                      child: TextField(
                                                        textAlign: TextAlign
                                                            .left,
                                                            textAlignVertical: TextAlignVertical.bottom,
                                                        // controller: searchCtrl,
                                                        keyboardType:
                                                        TextInputType.text,
                                                        onChanged: ((val) {
                                                          setState(() {
                                                            temp = value
                                                                .where((
                                                                element) =>
                                                                element.contains(
                                                                    val))
                                                                .toList();
    
                                                            temp =
                                                                temp.toSet()
                                                                    .toList();
    
                                                            goals2 =
                                                                goals2.toSet()
                                                                    .toList();
                                                          });
                                                        }),
                                                        decoration: InputDecoration(
                                                          // contentPadding: EdgeInsets.all(5.0),
                                                          hintText: 'Search',
                                                          alignLabelWithHint: true,
                                                          hintStyle: const TextStyle(
                                                              fontSize: 16),
                                                          border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                25),
                                                            borderSide:
                                                            const BorderSide(
                                                              width: 0,
                                                              style: BorderStyle
                                                                  .none,
                                                            ),
                                                          ),
                                                          filled: true,
                                                          // contentPadding:
                                                          // EdgeInsets.all(16),
                                                          fillColor:
                                                          const Color(0xffB1B2FF),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: temp.map((e) {
                                                      return Material(
                                                        color:
                                                        const Color(0xffD2DAFF),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              filterText = e;
                                                              showFilter = false;
                                                              _overlayEntry!
                                                                  .remove();
                                                              _overlayEntry =
                                                              null;
                                                              goals = [];
    
                                                              getAllTasks();
    
                                                              tasks = tasks.where((element) => element["status"] == e).toList();
                                                            });
                                                          },
                                                          child: Container(
                                                            height: 44,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(5)),
                                                            alignment:
                                                            Alignment.centerLeft,
                                                            child: DefaultTextStyle(
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  fontWeight:
                                                                  FontWeight.w400,
                                                                  fontSize: 11,
                                                                  color: const Color(
                                                                      0xff121623)),
                                                              child: Text(
                                                                e,
                                                                textAlign:
                                                                TextAlign.left,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  );
                                });
                                Overlay.of(context)!.insert(_overlayEntry!);
                              } else {
                                _overlayEntry!.remove();
                                _overlayEntry = null;
                                setState(() {
                                  goals2 = goals2.toSet().toList();
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.chevron_left_outlined,
                              size: 24,
                              color: Colors.white,
                            ))
                      ])),
              Column(
                children: tasks.map((e) {
                  var value = 0;
                  value +=1;
    
                  var disballed = !(e["isFree"] == false);
    
                  return ExploreTile(
                    title: e["companyName"]
                        .length >
                        30
                        ? "${e["companyName"].substring(0, 30)}..."
                        : e
                    [
                    "companyName"],
                    disabled: disballed,
                    taskId: e["id"],
                    taskCount:
                    "${e["SubTasks"]
              .where((p0) => p0['status'] == true)
              .length}/${e["SubTasks"].length}",
                    onClick:  () {
                      updateValues();
                      getAllTasks();
                      // setState(() {
                      //   disballed = true;
                      // });
                    },
                    position: e["positionName"],
                  );
                }).toList(),
              )
            ],
          ),
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
        "Extracurricular",
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

Container buildButton(String text, Function(String) callback) {
  return Container(
    decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(offset: Offset(0, 10), spreadRadius: 0, blurRadius: 30)
        ],
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xff272935),
              Color(0xff121623),
            ])),
    margin: const EdgeInsets.fromLTRB(16, 25, 16, 0),
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
      onPressed: () {
        callback(text);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xffFCD2D1)),
      ),
    ),
  );
}
