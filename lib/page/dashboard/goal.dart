import 'package:dartx/dartx.dart';
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

  @override
  void initState() {
    getAllRecommendations();
    getFaculties();

    super.initState();
  }

  bool showFilter = false;

  String filterText = "Activites";
  bool cantYouSee = false;

  OverlayEntry? _overlayEntry;

  var recommendation = [];
  var recommendationWidget = StatefulBuilder(
    builder: ((context, setState) => Container()),
  );

  var faculties = {};
  var facultiesInFilter = [];
  var filteredFaculties = [];

  Map<String, Widget> facultiesWidget = <String, Widget>{};
  Map<String, Widget> filteredFacultiesWidget = <String, Widget>{};

  void getFaculties() async {
    var temp = await client.getAllFaculties();

    setState(() {

      temp.forEach((key, value) {
        facultiesInFilter.add(key);
      });

      filteredFaculties = [...facultiesInFilter];
    });
  }

  void getAllRecommendations() async {
    var temp = await client.getRecommendations();
    var temp2 = await client.getAllFaculties();

    setState(() {
      recommendation = temp;
      faculties = temp2;
    });

    if(recommendation.isNotEmpty) {
      filteredFaculties.insert(0, "Recommendation");
      debugPrint("Hello");
      filteredFaculties.insert(1, "All");
    } else {
      filteredFaculties.insert(0, "All");
    }

    if(recommendation.isNotEmpty) {
      recommendationWidget = StatefulBuilder(builder: (context, state) {
        return ExpansionTile(
          trailing: Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: const ImageIcon(
              AssetImage("assets/Vectorchevorn.png"),
              size: 14,
              color: Color(0xffB1B2FF),
            ),
          ),
          title: Row(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  "Recommendation",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: const Color(0xffB1B2FF)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: const BoxDecoration(color: Color(0xffB1B2FF)),
                ),
              )
            ],
          ),
          children: recommendation.map((e) {
            var disballed = !(e["isFree"] == false);

            return ExploreTile(
                onClick: () {
                  setState(() {
                    disballed = !disballed;
                  });
                },
                taskCount:
                "${e["SubTasks"].where((p0) => p0['status'] == true).length}/${e["SubTasks"].length}",
                taskId: e["id"],
                title: e["companyName"].length > 30
                    ? "${e['companyName'].substring(0, 30)}..."
                    : e['companyName'],
                disabled: disballed,
                position: e["positionName"]);
          }).toList(),
        );
      });

      filteredFacultiesWidget['Recommendation'] = recommendationWidget;
    }


    faculties.forEach((key, value) {
      facultiesInFilter.add(key);

      facultiesWidget[key] = ExpansionTile(
        trailing: Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: const ImageIcon(
            AssetImage("assets/Vectorchevorn.png"),
            size: 14,
            color: Color(0xffB1B2FF),
          ),
        ),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                "${key[0].toString().toUpperCase()}${key.substring(1).toLowerCase()}",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: const Color(0xffB1B2FF)),
              ),
            ),
            Expanded(
              child: Container(
                height: 2,
                decoration: const BoxDecoration(color: Color(0xffB1B2FF)),
              ),
            )
          ],
        ),
        children: (value as List<dynamic>).map<Widget>((e) {
          var disballed = !(e["isFree"] == false);

          return ExploreTile(
            disabled: disballed,
            taskCount:
                "${e["SubTasks"].where((p0) => p0['status'] == true).length}/${e["SubTasks"].length}",
            taskId: e["id"],
            title: e["companyName"].length > 30
                ? "${e['companyName'].substring(0, 30)}..."
                : e["companyName"],
            position: e["positionName"],
            onClick: () {
              debugPrint("Hello World");
            },
          );
        }).toList(),
      );
    });

    filteredFacultiesWidget.addAll(facultiesWidget);
  }

  Future<bool> _onBackButtonPressed() {
    setState(() {
      cantYouSee = false;
      if(!cantYouSee) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    });

    return Future.value(false);
  }

  @override
  void dispose() {
    if(!cantYouSee) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackButtonPressed,
      child: GestureDetector(
        onTap: _onBackButtonPressed,
        behavior: HitTestBehavior.translucent,
        onVerticalDragDown: (details) {
          _onBackButtonPressed();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              buildButton(widget.title, (p0) {}),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  scrollController.animateTo(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                  setState(() {
                    showFilter = !showFilter;
                  });
                  if (showFilter) {
                    _overlayEntry = OverlayEntry(builder: (context) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: StatefulBuilder(builder: (context, state) {
                          return Container(
                            width: 174,
                            height: 200,
                            margin: const EdgeInsets.fromLTRB(15, 260, 0, 0),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color(0xffD2DAFF),
                                borderRadius: BorderRadius.circular(5)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Material(
                                    color: const Color(0xffD2DAFF),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      padding:
                                          const EdgeInsets.fromLTRB(5, 4, 5, 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextField(
                                        textAlign: TextAlign.left,
                                        textAlignVertical:
                                            TextAlignVertical.bottom,
                                        keyboardType: TextInputType.text,
                                        onChanged: ((val) {
                                          state(() {
                                            if (val.isNotEmpty) {
                                              filteredFaculties =
                                                  facultiesInFilter
                                                      .where((element) => element
                                                          .toLowerCase()
                                                          .contains(val.toLowerCase()))
                                                      .toList();
                                            }
                                            if (val.isEmpty) {
                                              filteredFaculties =
                                                  facultiesInFilter;
                                              if(recommendation.isNotEmpty) {
                                                filteredFaculties.insert(
                                                    0, "Recommendation");
                                                filteredFaculties.insert(
                                                    1, "All");
                                              } else {
                                                filteredFaculties.insert(
                                                    0, "All");
                                              }
                                            }
                                          });
                                        }),
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          alignLabelWithHint: true,
                                          hintStyle:
                                              const TextStyle(fontSize: 16),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xffB1B2FF),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: filteredFaculties
                                        .toSet()
                                        .toList()
                                        .map((e) {
                                          debugPrint(filteredFaculties.toString());
                                      return Material(
                                        color: const Color(0xffD2DAFF),
                                        child: InkWell(
                                          highlightColor:
                                              const Color(0xffAAC4FF),
                                          onTap: () {
                                            state(() {
                                              filterText = e;
                                              showFilter = false;
                                              _overlayEntry!.remove();
                                              _overlayEntry = null;

                                              if (filterText ==
                                                  "Recommendation") {
                                                filteredFacultiesWidget = {};
                                                filteredFacultiesWidget[
                                                        'Recommendation'] =
                                                    recommendationWidget;
                                              } else if (filterText == "All") {
                                                filteredFacultiesWidget =
                                                    facultiesWidget;
                                              } else {
                                                filteredFacultiesWidget =
                                                    facultiesWidget
                                                        .filter((pair) {
                                                  return pair.key == filterText;
                                                });
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 44,
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 0, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            alignment: Alignment.centerLeft,
                                            child: DefaultTextStyle(
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xff121623)),
                                              child: Text(
                                                e,
                                                textAlign: TextAlign.left,
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
                    Overlay.of(context).insert(_overlayEntry!);
                  } else {
                    _overlayEntry!.remove();
                    _overlayEntry = null;
                  }
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 10, 0, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 1, color: const Color(0xff355CCA))),
                    width: filterText.length * 10 + 60,
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
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: const ImageIcon(
                              AssetImage("assets/Vectorchevorn.png"),
                              size: 14,
                              color: Colors.grey,
                            ),
                          )
                        ])),
              ),

              Column(
                children: filteredFacultiesWidget.values.toList(),
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
