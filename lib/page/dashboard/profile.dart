import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/widgets/dashboard/personal_details_tile.dart';
import '../../http client/http_client.dart';
import '../../widgets/dashboard/profile_university_tile.dart';

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

  String university = "Harvard";

  late String phone;
  late String mail;
  late String fullName;


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
      setUniversity();
    });
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
  }

  @override
  void initState() {
    getUniver();
    getPoint();
    setUniversity();
    setEmail();
    
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

  void setUniversity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      university = prefs.getString("university").toString();
    });
  }

  void setEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = prefs.getString("email").toString();
      phone = prefs.getString("number").toString();
      fullName = prefs.getString("full name").toString();
    });
  }

  


  @override
  Widget build(BuildContext context) {

    // print(points);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            buildTitle(),
            Container(
              width: double.infinity,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              backgroundColor: Colors.yellow,
                              backgroundImage: _image != null ? Image.file(
                                File(_image!.path),
                                fit: BoxFit.contain,
                              ).image : Image.asset("assets/logo.png").image,
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
                              child: const Icon(
                                Icons.camera_outlined,
                                size: 30,
                                color: Color(0xffD2DAFF),
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
                        "Yerevan, Armenia",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: const Color(0xffBFBFBF)
                        ),
                      )
                    ],
                  )     
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget> [
                buildCard(<Color> [const Color(0xffD2DAFF), const Color(0xff355CCA)]),
                buildCard(<Color> [const Color(0xffFCD2D1),const Color(0xffFF5C58)]),
                buildCard(<Color> [const Color(0xffD2C5DF), const Color(0xff8675A9)]),
              ],
            ),

            UniversityTile(onEdit: changeMode, mode: isEditable, onSave: onSave, university: uni, points: points, selectedUniversity: university,),
            PersonalDetails(mode: editPersonal, onEdit: onPersonalEdit, onSave: onPersonalSave, phone: phone, email: mail,),
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


Container buildCard(List<Color> colors) {
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
          "24",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: colors[1]
          ),
        ),

        Text(
          "Days in training",
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