import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/page/change_password.dart';
import 'package:sis_progress/widgets/dashboard/personal_details_tile.dart';
import 'package:sis_progress/widgets/drawers/shimmer_load.dart';
import 'package:sis_progress/widgets/input_box.dart';
import '../../http client/http_client.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/dashboard/email_details.dart';
import '../../widgets/dashboard/profile_university_tile.dart';
import '../login.dart';

class Profile extends StatefulWidget {
  final VoidCallback updateAppBar;

  const Profile({
    required this.updateAppBar,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  final Client httpClient = Client();

  bool isEditable = false;
  bool editPersonal = false;
  XFile? _image;

  final ImagePicker _picker = ImagePicker();

  List<String> uni = [""];
  List<List<dynamic>> points = [];

  late String phone = "";
  late String mail = "";
  late String secondaryMail = "";
  late String country = "";
  late String fullName = "";
  late String age = "";
  late String gradeLevel = "";
  late String firstAcademic = "";
  late String secondAcademic = "";
  late String thirdAcademic = "";
  late String fourthAcademic = "";
  late String university = "";
  late String study = "";
  late String dreamPoints = "";
  late String targetPoints = "";
  late String safetyPoints = "";
  late String image = "http://drive.google.com/uc?export=view&id=1T4h9d1wyGy-apEyrTW_D6C1UvdLSE166";

  bool isLoading = true;

  void setUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await httpClient.getUserData();
    setState(() {
      fullName = value["fullName"];
      prefs.setString("country", value["country"]);
    });
  }

  void getImage() async {
    var temp = await httpClient.getImage();

    setState(() {
      image = temp;
      isLoading = false;
    });
  }

  int traingDays = 0;
  int totalPoints = 0;
  int completedTasks = 0;

  bool isVerifiedSecondaryEmail = true;

  void printValue() async {
    var value = await httpClient.getDashboardData();
    setState(() {
      traingDays = value["TrainingDays"];
      totalPoints = value["totalPoints"];
      completedTasks = value["completed"];
    });
  }

  Future updateImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 120, maxHeight: 120);

    if (mounted) {
      setState(() {
        _image = image;
      });

      await httpClient.updateImage(_image!);
    }

    widget.updateAppBar();
  }

  void changeMode() {
    if (mounted) {
      setState(() {
        isEditable = true;
      });
    }
  }

  void onSave() {
    setState(() {
      isEditable = false;
      setEmail();
    });

    setEmail();
  }

  void onPersonalEdit() {
    setState(() {
      editPersonal = true;
    });
  }

  void onPersonalSave() {
    setState(() {
      editPersonal = false;
    });

    setEmail();
    setUsername();
  }

  @override
  void initState() {
    getPoint();
    setEmail();
    setUsername();
    printValue();
    getImage();

    super.initState();
  }

  void getPoint() async {
    var temp = await httpClient.getPoints();
    setState(() {
      points = temp;
    });
  }

  void setEmail() async {
    var value = await httpClient.getUserData();

    if (mounted) {
      setState(() {
        mail = value["firstEmail"]["email"];
        phone = value["phone"].toString();
        country = value["country"].toString();
        age = value["age"].toString();
        university = value["university"].toString();
        firstAcademic = value["academicProgramFirst"].toString();
        secondAcademic = value["academicProgramSecond"].toString();
        thirdAcademic = value["academicProgramThird"].toString();
        fourthAcademic = value["academicProgramFourth"].toString();

        if (value["secondaryEmail"] != null) {
          secondaryMail = value["secondaryEmail"]["email"];
          isVerifiedSecondaryEmail = value["secondaryEmail"]["isVerified"];
        } else {
          secondaryMail = "empty";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getPoint();
        setEmail();
        setUsername();
        printValue();
        getImage();
        onSave();
        onPersonalSave();
      },
      color: Colors.white,
      child: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          ColorAnimation(
                            isLoading: isLoading,
                            tree: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 100,
                                height: 100,
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: _image != null
                                      ? Image.file(
                                          File(_image!.path),
                                          fit: BoxFit.contain,
                                        ).image
                                      : Image.network(image).image,
                                  radius: 55,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: updateImage,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff3A3D4C),
                                      shape: BoxShape.circle),
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  padding: const EdgeInsets.all(10),
                                  child: Tooltip(
                                    showDuration: const Duration(seconds: 2),
                                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff3A3D4C),
                                      borderRadius: BorderRadius.circular(2)
                                    ),
                                    triggerMode: TooltipTriggerMode.longPress,
                                    message: "You can upload an image up to 1 mb",
                                    child: SvgPicture.asset(
                                      "assets/Camera.svg",
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Text(
                            fullName,
                            // textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 200,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            country,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: const Color(0xffBFBFBF)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildCard(
                      <Color>[const Color(0xffD2DAFF), const Color(0xff355CCA)],
                      traingDays.toString(),
                      "Days\nin training"),
                  buildCard(
                      <Color>[const Color(0xffFCD2D1), const Color(0xffFF5C58)],
                      completedTasks.toString(),
                      "Completed\nTasks"),
                  buildCard(
                      // <Color>[const Color(0xffFCD2D1), const Color(0xffFF5C58)],
                      <Color>[const Color(0xffD2C5DF), const Color(0xff8675A9)],
                      totalPoints.toString(),
                      "Dream\nmilestone"),
                ],
              ),
              UniversityTile(
                  onEdit: changeMode,
                  mode: isEditable,
                  onSave: onSave,
                  university: Universities().universities,
                  points: Universities().points,
                  selectedUniversity: university,
                  firstAcademic: firstAcademic,
                  secondAcademic: secondAcademic,
                  thirdAcademic: thirdAcademic,
                  fourthAcademic: fourthAcademic,
                  dreamPoint: dreamPoints,
                  targetPoint: targetPoints,
                  safetyPoint: safetyPoints),
              PersonalDetails(
                mode: editPersonal,
                onEdit: onPersonalEdit,
                onSave: onPersonalSave,
                phone: phone,
                email: mail,
                age: age != ""
                    ? DateFormat('dd/MM/yyyy').format(DateTime.parse(age))
                    : "",
                country: country,
                name: fullName,
              ),
              Emaildetails(
                mode: false,
                email: mail,
                secondaryEmail: secondaryMail,
                updateStates: setEmail,
                isVerified: isVerifiedSecondaryEmail,
              ),
              buildChangePassword(changePassword),
              // ChangePassword(),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: logoutDialogBuilder,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 25, 16, 25),
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: const Color(0xff26459B)),
                      color: Colors.transparent
                  ),
                  child: Text(
                    "Log out",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: const Color(0xff26459B)
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logoutDialogBuilder() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xff121623),
            title: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "Are you sure you want to log out?",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                width: 100,
                height: 35,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            width: 1.5, color: Color(0xffD2DAFF))),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: const Color(0xffD2DAFF)),
                    )),
              ),
              Container(
                width: 100,
                height: 35,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: ElevatedButton(
                    onPressed: () {
                      SharedPreferences.getInstance().then((value) {
                        value.setBool("auth", false);
                      });

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff355CCA)
                    ),
                    child: Text(
                      "Yes",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white),
                    )),
              )
            ],
          );
        });
  }

  changePassword() {
    var currentPassword = TextEditingController();
    var password = TextEditingController();
    var confirmPassword = TextEditingController();

    return showDialog(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: const Color(0xff121623),
                title: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  alignment: Alignment.center,
                  child: Text(
                    "Change password",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.white
                    ),
                  ),
                ),

                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    InputBox(textInputType: TextInputType.text, onChanged: (val) {state((){});}, context: context, controller: currentPassword, isPassword: true, initialValue: "Current Password",),
                    InputBox(textInputType: TextInputType.text, onChanged: (val) {state((){});}, context: context, controller: password, isPassword: true, initialValue: "New Password",),
                    InputBox(textInputType: TextInputType.text, onChanged: (val) {state((){});}, context: context, controller: confirmPassword, isPassword: true, initialValue: "Confirm new password",),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: <Widget>[
                  Button(text: "Change password", onPressed: currentPassword.text.isNotEmpty && password.text.isNotEmpty && confirmPassword.text.isNotEmpty ? () async {
                    var client = Client();

                    var response = await client.changePassword(currentPassword.text, password.text);

                    if(response != "error") {
                      var preferences = await SharedPreferences.getInstance();
                      preferences.setString("token", response["newToken"]);;
                      successMessage();
                    } else {
                      errorMessage();
                    }
                  }: null, height: 38, width: double.infinity)
                ],
              );
            }
          );
        }
    );
  }

  errorMessage() {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            backgroundColor: const Color(0xff121623),
            title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "OOPS!",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: const Color(0xffFE8F8F)
                  ),
                  children: [
                    TextSpan(
                        text: " Something went wrong.",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white
                        )
                    )
                  ]
              ),
            ),

            actions: [
              Button(text: "Ok", onPressed: () {
                Navigator.pop(context);
                // Navigator.pop(context);
              }, height: 36, width: double.infinity)
            ],
          );
        }
    );
  }

  successMessage() {
    return showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            backgroundColor: const Color(0xff121623),
            title: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "YEAH!",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: const Color(0xff355CCA)
                ),
                children: [
                  TextSpan(
                    text: " Your password is changed successfully.",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white
                    )
                  )
                ]
              ),
            ),
            actions: [
              Button(text: "Ok", onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, height: 38, width: double.infinity)
            ],
          );
        }
    );
  }
}

buildChangePassword(Function() showChange) {
  return Container(
    width: double.infinity,
    height: 111,
    margin: const EdgeInsets.fromLTRB(16, 23, 16, 0),
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
    child: Column(
      children: <Widget> [
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(15, 13, 0, 0),
          child: Text(
            "Change password",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xffD2DAFF)
            ),
          ),
        ),

        Container(
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: Button(
            text: "Change",
            onPressed: () {
              showChange();
            },
            height: 38,
            width: 120,
          ),
        )
      ],
    ),
  );
}

Container buildTitle() {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 25, 0, 0),
    child: FittedBox(
      fit: BoxFit.contain,
      child: Text(
        "My profile",
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

Container buildCard(List<Color> colors, String value, String val) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 37, 0, 0),
    height: 115,
    width: 95,
    decoration: BoxDecoration(
        color: colors[0], borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          value,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, fontSize: 24, color: colors[1]),
        ),
        Text(
          val,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400, fontSize: 13, color: colors[1]),
        )
      ],
    ),
  );
}
