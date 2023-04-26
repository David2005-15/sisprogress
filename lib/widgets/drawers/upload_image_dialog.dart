import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../http client/http_client.dart';

void showImageUploadDialog(BuildContext context,
    {required bool isImageDefault,
    required VoidCallback uploadImage,
    required VoidCallback updateStates}) {
  showDialog(
      context: context,
      builder: (builder) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color(0xff121623),
            content: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Choose profile photo",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: const Color(0xffAAC4FF)
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Color(0xffD4D4D4)),
                          bottom: BorderSide(width: 1, color: Color(0xffD4D4D4))
                      )
                    ),
                    child: TextButton(
                      onPressed: () {
                        uploadImage();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Choose photo",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  !isImageDefault ? Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Color(0xffD4D4D4))
                        )
                    ),
                    child: TextButton(
                      onPressed: () async {
                        var client = Client();

                        await client.removeImage();

                        Navigator.pop(context);
                      },
                      child: Text(
                        "Remove current image",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: const Color(0xffFE8F8F)
                        ),
                      ),
                    ),
                  ): Container(),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
      }).then((value) {
        updateStates();
  });
}
