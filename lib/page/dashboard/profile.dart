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

  void setUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await httpClient.getUserData();
    setState(() {

      fullName = value["fullName"];
      prefs.setString("country", value["country"]);    
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

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 120, maxHeight: 120);

    setState(() {
      _image = image;
    });
  }

  void changeMode() {
    setState(() {
      isEditable = true;
    });
  }

  void onSave() async {
    setState(() {
      isEditable = false;
    });

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
    getUniver();
    getPoint();
    // setUniversity();
    setEmail();
    setUsername();
    printValue();


    print(country);
    print(fullName);



    
    super.initState();
  }

  void getUniver() async {
    var temp = await httpClient.getAllUniversities();
    // await httpClient.getPoints();
    setState(() {
      uni = temp;

    });
  }

  void getPoint() async {
    var temp = await httpClient.getPoints();
    setState(() {
      points = temp;
    });
  }

  // void setUniversity() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     university = prefs.getString("university").toString();
  //   });
  // }

  void setEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = await httpClient.getUserData();
    
    setState(() {
      // mail = prefs.getString("email").toString();
      mail = value["UserEmails"][0]["email"];
      
      phone = value["phone"].toString();
      country = value["country"].toString();
      age = value["age"].toString();
      university = value["university"].toString();
      academicProgram = value["academicProgram"].toString();
      study = value["study"].toString();
      secondaryMail = value["UserEmails"][1]["email"];
      print(secondaryMail);
      // gradeLevel = "${value["grade"]!}th Grade";
    });
  }



  


  @override
  Widget build(BuildContext context) {    
    // setEmail();
    // if(!isEditable) {
    // setEmail();
    // }

    // print(points);
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pop(context);
        return Future.value(false);
      },
      child: Container(
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
                    Container(
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
                                ).image : Image.asset("assets/AvatarAvatar.png").image,
                                radius: 55,
                              ),
                            ),
                          ),
                    
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: getImage,
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
              // Emaildetails(mode: false, email: mail, secondaryEmail: secondaryMail,),
              UniversityTile(onEdit: changeMode, mode: isEditable, onSave: onSave, university: uni, points: points, selectedUniversity: university, academicProgram: academicProgram, study: study, 
                dreamPoint: dreamPoints,
                targetPoint: targetPoints,
                safetyPoint: safetyPoints),
              PersonalDetails(mode: editPersonal, onEdit: onPersonalEdit, onSave: onPersonalSave, phone: phone, email: mail, age: age != "" ? DateFormat('dd/MM/yyyy').format(DateTime.parse(age)): "", country: country, name: fullName,),
              Emaildetails(mode: false, email: mail, secondaryEmail: secondaryMail,),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 25, 16, 25),
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
      
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Color(0xff26459B)),
                    color: Colors.transparent
                  ),
    
                  child: Text(
                    "Log out",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Color(0xff26459B)
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