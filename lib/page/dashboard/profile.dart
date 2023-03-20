import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/widgets/dashboard/personal_details_tile.dart';
import '../../http client/http_client.dart';
import '../../widgets/dashboard/email_details.dart';
import '../../widgets/dashboard/profile_university_tile.dart';
import '../login.dart';

class Profile extends StatefulWidget {
  const Profile({
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
  late String academicProgram = "";
  late String university = "";
  late String study = "";
  late String dreamPoints = "";
  late String targetPoints = "";
  late String safetyPoints = "";
  late String image = "http://drive.google.com/uc?export=view&id=1T4h9d1wyGy-apEyrTW_D6C1UvdLSE166";

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
    });
  }

  int traingDays = 0;
  int totalPoints = 0;
  int completedTasks = 0; 

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

    setState(() {
      _image = image;
      httpClient.updateImage(_image!);
    });
  }

  void changeMode() {
    setState(() {
      isEditable = true;
    });
  }

  void onSave() {
    setState(() {
      isEditable = false;
      setEmail();
    });

    setEmail();
    setEmail();
    setEmail();
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

    setState(() {
      mail = value["firstEmail"]["email"];
      phone = value["phone"].toString();
      country = value["country"].toString();
      age = value["age"].toString();
      university = value["university"].toString();
      academicProgram = value["academicProgram"].toString();
      study = value["study"].toString();
      if(value["secondaryEmail"] != null) {
        secondaryMail = value["secondaryEmail"]["email"];
      } else {
        secondaryMail = "empty";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
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
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: _image != null ? Image.file(
                                File(_image!.path),
                                fit: BoxFit.contain,
                              ).image : Image.network(image).image,
                              radius: 55,
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
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xff3A3D4C),
                                shape: BoxShape.circle
                              ),
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                "assets/Camera.svg",
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        Text(
                            fullName,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),

                        Text(
                          country,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: const Color(0xffBFBFBF)
                          ),
                        )
                      ],
                    ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                buildCard(<Color> [const Color(0xffD2DAFF), const Color(0xff355CCA)], traingDays.toString(), "Days\nin training"),
                buildCard(<Color> [const Color(0xffFCD2D1),const Color(0xffFF5C58)], totalPoints.toString(), "Total\nPoints"),
                buildCard(<Color> [const Color(0xffD2C5DF), const Color(0xff8675A9)], completedTasks.toString(), "Completed\nTasks"),
              ],
            ),
            UniversityTile(onEdit: changeMode, mode: isEditable, onSave: onSave, university: Universities().universities, points: Universities().points, selectedUniversity: university, academicProgram: academicProgram, study: study,
              dreamPoint: dreamPoints,
              targetPoint: targetPoints,
              safetyPoint: safetyPoints),
            PersonalDetails(mode: editPersonal, onEdit: onPersonalEdit, onSave: onPersonalSave, phone: phone, email: mail, age: age != "" ? DateFormat('dd/MM/yyyy').format(DateTime.parse(age)): "", country: country, name: fullName,),
            Emaildetails(mode: false, email: mail, secondaryEmail: secondaryMail, updateStates: setEmail,),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                SharedPreferences.getInstance().then((value) {
                  value.setBool("auth", false);

                  debugPrint(value.getBool("auth").toString());
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 25, 16, 25),
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1, color: const Color(0xff26459B)),
                  color: Colors.transparent
                ),

                child: Text(
                  "Log out",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: const Color(0xff26459B)
                  ),
                ),
              ),
            ),
          ],
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
        "My profile",
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.02,
          color: Colors.white
        ),
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
      color: colors[0],
      borderRadius: BorderRadius.circular(10)
    ),
    
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget> [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: colors[1]
          ),
        ),

        Text(
          val,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: colors[1]
          ),
        )
      ],
    ),
  );
}