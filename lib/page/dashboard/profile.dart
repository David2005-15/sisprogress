import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 120, maxHeight: 120);
    var status = await Permission.camera.request();

    setState(() {
      if(status.isGranted){
        _image = image;
      }
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
    super.initState();
  }

  void getUniver() async {
    var temp = await httpClient.getAllUniversities();
    setState(() {
      uni = temp;
    });
  }




  @override
  Widget build(BuildContext context) {
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
                                color: Colors.red,
                                shape: BoxShape.circle
                              ),
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: const Icon(
                                Icons.camera_outlined,
                                size: 30,
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
                        "Montana",
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

            UniversityTile(onEdit: changeMode, mode: isEditable, onSave: onSave, university: uni,),
            PersonalDetails(mode: editPersonal, onEdit: onPersonalEdit, onSave: onPersonalSave,)
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