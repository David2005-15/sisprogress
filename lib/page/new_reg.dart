import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/school_states.dart';
import 'package:sis_progress/data%20class/universities.dart';
import 'package:sis_progress/http%20client/http_client.dart';
import 'package:sis_progress/page/verify_email.dart';
import 'package:sis_progress/widgets/custom_button.dart';
import 'package:sis_progress/widgets/drawers/acativity_to_map.dart';
import 'package:sis_progress/widgets/drawers/app_bar.dart';
import 'package:sis_progress/widgets/drop_down_field.dart';
import 'package:table_calendar/table_calendar.dart';
import '../data class/registration_data_class.dart';
import '../widgets/Input_field.dart';

class NewReg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewReg();
}

class _NewReg extends State<NewReg> {
  var grades = ["Up to 9th grade", "10th grade or above"];

  final _formKey = GlobalKey<FormState>();

  Client httpClient = Client();

  var name = TextEditingController();
  var email = TextEditingController();
  var age = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassword = TextEditingController();
  var otherSchool = TextEditingController();
  var phone = TextEditingController();

  // var schoolEdit = TextEditingController();
  // var schoolRadioHandler = RadioButtonHandler(value: null);
  // var schTextEditingController()
  var school;
  var country;
  var grade;
  var university;

  var schoolState = SchoolState.notselected;

  List<String> academics = [];
  var columbiaFaculty;
  var pensylvaniaFaculty;
  var pensylvaniaSecond;
  var pensylvaniaThird;
  var pensylvaniaFourth;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    if (value.isNullOrBlank) {
      return "Fill your email address, please";
    }

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Fill a valid email address, please'
        : null;
  }

  String? validatePassword(String? value) {
    const pattern =
        r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";

    final regex = RegExp(pattern);

    if (value.isNullOrBlank) {
      return 'Enter valid password, please';
    }

    return !regex.hasMatch(value!) ?'Enter valid password, please' : null;
  }

  var capitalLetter = const Color(0xffFE8F8F);
  var containNumber = const Color(0xffFE8F8F);
  var containSmall = const Color(0xffFE8F8F);
  var contain8char = const Color(0xffFE8F8F);
  var containSpecial = const Color(0xffFE8F8F);

  List<String> years = List.generate(74, (i) => (2008 - i).toString());
  String month = DateFormat("MMMM")
      .format(DateTime(2008, DateTime.now().day, DateTime.now().month));
  String year = (DateTime(2008, DateTime.now().day, DateTime.now().month).year)
      .toString();

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  var uniDataClass = RegistrationDataClass();
  var showFilter = false;
  var showAcademic = false;

  PhoneNumber number = PhoneNumber(isoCode: 'US');
  String phoneValue = "";

  OverlayEntry? _overlayEntry;

  bool isPasswordHintVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(buildLogoIcon(), List.empty()),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.fromLTRB(16, 5, 16, 20),
          decoration: BoxDecoration(
              color: const Color(0xff3A3D4C),
              borderRadius: BorderRadius.circular(5)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Text(
                    "Start Your Journey Today",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          context: context,
                          initialValue: "Full Name",
                          controller: name,
                          isPassword: false,
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fill your full name, please';
                            }
                            return null;
                          },
                        ),

                        InputField(
                          context: context,
                          initialValue: "Email",
                          controller: email,
                          isPassword: false,
                          textInputType: TextInputType.emailAddress,
                          validator: validateEmail,
                        ),

                        Focus(
                          onFocusChange: (focus) {
                            isPasswordHintVisible = focus;
                            print(focus);
                          },
                          child: StatefulBuilder(


                            builder: (context, state) {

                              return Column(
                                children: [
                                  InputField(
                                      onChanged: (val) {
                                        state(() {
                                          capitalLetter = const Color(0xffFE8F8F);
                                          containNumber = const Color(0xffFE8F8F);
                                          containSmall = const Color(0xffFE8F8F);
                                          contain8char = const Color(0xffFE8F8F);
                                          containSpecial = const Color(0xffFE8F8F);

                                          if (passwordController.text.contains(RegExp(r'[0-9]'))) {
                                            containNumber = const Color(0xff94B49F);
                                          }

                                          if (passwordController.text.contains(RegExp(r'[A-Z]'))) {
                                            capitalLetter = const Color(0xff94B49F);
                                          }

                                          if (passwordController.text.contains(RegExp(r'[a-z]'))) {
                                            containSmall = const Color(0xff94B49F);
                                          }

                                          if (passwordController.text.contains(RegExp(r'[^\w\s]+'))) {
                                            containSpecial = const Color(0xff94B49F);
                                          }

                                          if(passwordController.text.length >= 8) {
                                            contain8char = const Color(0xff94B49F);
                                          }
                                        });
                                      },
                                      initialValue: "Create Password",
                                      validator: validatePassword,
                                      textInputType: TextInputType.visiblePassword,
                                      context: context,
                                      controller: passwordController,
                                      isPassword: true),

                                  isPasswordHintVisible ? Container(
                                      margin: const EdgeInsets.fromLTRB(31, 5, 23, 0),
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(children: <TextSpan>[
                                          TextSpan(
                                              text: "A",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: capitalLetter,
                                                  fontSize: 13)),
                                          TextSpan(
                                              text: "a",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: containSmall,
                                                  fontSize: 13)),
                                          TextSpan(
                                              text: 1.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: containNumber,
                                                  fontSize: 13)),
                                          TextSpan(
                                              text: 23456.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: contain8char,
                                                  fontSize: 13)),
                                          TextSpan(
                                              text: "*",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                  color: containSpecial,
                                                  fontSize: 13))
                                        ]),
                                      )): Container()
                                ],
                              );
                            }
                          ),
                        ),
                        

                        InputField(
                            initialValue: "Confirm Password",
                            validator: (value) {
                              if (value.isNullOrBlank ||
                                  value != passwordController.text) {
                                return "No password match";
                              }

                              return null;
                            },
                            textInputType: TextInputType.visiblePassword,
                            context: context,
                            controller: confirmPassword,
                            isPassword: true),

                        Container(
                          margin: const EdgeInsets.fromLTRB(23, 30, 23, 0),
                          child: InternationalPhoneNumberInput(
                            textAlign: TextAlign.start,
                            onInputChanged: (PhoneNumber number) {
                              // print(number.phoneNumber);

                              phoneValue = number.phoneNumber.toString();
                            },
                            onInputValidated: (bool value) {},

                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DROPDOWN,
                            ),
                            textStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                color: Colors.white),
                            validator: (val) {
                              if(val.isNullOrEmpty) {
                                return "Fill your phone number, please";
                              }

                              return null;
                            },
                            inputDecoration: InputDecoration(
                              labelText: "Phone",
                              errorStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: const Color(0xffE31F1F)),
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
                                  borderSide:
                                  BorderSide(color: Color(0xffD2DAFF), width: 1)),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffD4D4D4), width: 1)),
                              focusColor: const Color(0xffD2DAFF),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff36519D))),
                            ),
                            searchBoxDecoration: InputDecoration(
                              alignLabelWithHint: true,
                              labelText: "Phone",
                              errorStyle: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: const Color(0xffE31F1F)),
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
                                  borderSide:
                                  BorderSide(color: Color(0xffD2DAFF), width: 1)),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color:  Color(0xffD4D4D4), width: 1)),
                              focusColor: const Color(0xffD2DAFF),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff36519D))),
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: const Color(0xffD4D4D4)),

                            initialValue: number,
                            textFieldController: phone,
                            formatInput: true,
                            keyboardType: TextInputType.phone,
                            // inputBorder: OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {
                              // print('On Saved: $number');
                            },
                          ),
                        ),

                        DropDownField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Choose your country, please';
                              }
                              return null;
                            },
                            onChange: (value) {
                              setState(() {
                                country = value;
                              });
                            },
                            context: context,
                            initialValue: "Country",
                            value: country,
                            items: Universities().countryList),

                        DropDownField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Choose your grade, please';
                              }
                              return null;
                            },
                            onChange: (value) {
                              setState(() {
                                grade = value;
                              });
                            },
                            context: context,
                            initialValue: "Grade",
                            value: grade,
                            items: grades),

                        Container(
                          margin: const EdgeInsets.fromLTRB(23, 0, 23, 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isNullOrBlank) {
                                return "Choose your birth date, please";
                              }

                              return null;
                            },
                            readOnly: true,
                            maxLines: 1,
                            autocorrect: false,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                labelText: "Birth date",
                                errorStyle: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: const Color(0xffE31F1F)),
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
                                    borderSide: BorderSide(
                                        color: Color(0xffD2DAFF), width: 1)),
                                border: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffD4D4D4), width: 1)),
                                focusColor: const Color(0xffD2DAFF),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff36519D))),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _dialogBuilder();
                                  },
                                  child: const Icon(
                                    Icons.calendar_month_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )),
                            controller: age,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                color: Colors.white),
                          ),
                        ),

                        DropDownField(
                            value: university,
                            validator: (value) {
                              if (value != null) {
                                return null;
                              }

                              return "Choose your dream university, please";
                            },
                            onChange: (value) {
                              setState(() {
                                university = value;

                                showAcademic = true;
                                academics.clear();
                                // print("******" + RegistrationDataClass().universities["university"].keys);
                              });
                            },
                            context: context,
                            initialValue: "Pick your dream university",
                            items: Universities().universities),

                        Visibility(
                            visible: university.toString().contains("Columbia"),
                            child: Column(
                              children: [
                                DropDownField(
                                    value: columbiaFaculty,
                                    validator: (val) {
                                      if(val == null) {
                                        return "Choose your dream college, please";
                                      }

                                      return null;
                                    },
                                    onChange: (val) {
                                      setState(() {
                                        columbiaFaculty = val;
                                        academics.clear();
                                      });
                                    },
                                    context: context,
                                    initialValue: "Academic Program",
                                    items: const [
                                      "Columbia College",
                                      "Columbia Engineering"
                                    ]),
                                Visibility(
                                  visible: columbiaFaculty
                                      .toString()
                                      .isNotNullOrEmpty,
                                  child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          23, 0, 23, 5),
                                      child: LayoutBuilder(builder:
                                          (BuildContext context,
                                              BoxConstraints constraints) {
                                        return TextFormField(
                                          readOnly: true,
                                          validator: (val) {
                                            if(academics.isEmpty) {
                                              return "Choose at least one academic, please";
                                            }

                                            return null;
                                          },
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              fontStyle: FontStyle.normal,
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            labelText: academics.isEmpty ? "Academic Program (choose up to ${RegistrationDataClass()
                                                .univer[university]["length"]})" : academics.join(', '),
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
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xffD2DAFF),
                                                        width: 1)),
                                            border: const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xffD2DAFF),
                                                    width: 1)),
                                            focusColor: const Color(0xffD2DAFF),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff36519D))),
                                            suffixIcon: PopupMenuButton<String>(
                                              color: const Color(0xffD2DAFF),
                                              constraints:
                                                  BoxConstraints.expand(
                                                      height: 150,
                                                      width:
                                                          constraints.maxWidth),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.grey,
                                              ),
                                              onSelected: (String value) {
                                                // controller.text = value;
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return RegistrationDataClass()
                                                    .univer[university]
                                                        [columbiaFaculty]
                                                    .keys
                                                    .map<PopupMenuItem<String>>(
                                                        (String value) {
                                                  return PopupMenuItem(
                                                      value: value,
                                                      child: StatefulBuilder(
                                                        builder:
                                                            (context, state) {
                                                          return Row(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  state(() {
                                                                    // academics.clear();

                                                                    if (academics
                                                                        .contains(
                                                                            value)) {
                                                                      academics
                                                                          .remove(
                                                                              value);
                                                                    } else if (academics
                                                                            .length <
                                                                        RegistrationDataClass().univer[university]
                                                                            [
                                                                            "length"]) {
                                                                      academics.add(
                                                                          value);
                                                                    }

                                                                    // print(academics);
                                                                  });

                                                                  setState(() {

                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 24,
                                                                  height: 24,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border: Border.all(
                                                                          width:
                                                                              1.5,
                                                                          color:
                                                                              const Color(0xff355CCA))),
                                                                  child: academics.contains(
                                                                          value)
                                                                      ? const Icon(
                                                                          Icons
                                                                              .check,
                                                                          size:
                                                                              18,
                                                                          color:
                                                                              Color(0xff355CCA))
                                                                      : null,
                                                                ),
                                                              ),
                                                              Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                                  child: Text(
                                                                      value))
                                                            ],
                                                          );
                                                        },
                                                      ));
                                                }).toList();
                                              },
                                            ),
                                          ),
                                        );
                                      })),
                                ),
                              ],
                            )),

                        Visibility(
                            visible: showAcademic &&
                                !university.toString().contains("Columbia") && !university.toString().contains("Pennsylvania"),
                            child: Container(
                                margin: const EdgeInsets.fromLTRB(23, 0, 23, 5),
                                child: LayoutBuilder(builder:
                                    (BuildContext context,
                                        BoxConstraints constraints) {
                                  return TextFormField(
                                    readOnly: true,
                                    validator: (val) {
                                      if(academics.isEmpty){
                                        return "Choose at least one academic, please";
                                      }

                                      return null;
                                    },
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      labelText: academics.isEmpty ? "Academic Program (choose up to ${RegistrationDataClass()
                                          .univer[university]["length"]})" : academics.join(', '),
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
                                          borderSide: BorderSide(
                                              color: Color(0xffD2DAFF),
                                              width: 1)),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffD2DAFF),
                                              width: 1)),
                                      focusColor: const Color(0xffD2DAFF),
                                      focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xff36519D))),
                                      suffixIcon: PopupMenuButton<String>(
                                        color: const Color(0xffD2DAFF),
                                        constraints: BoxConstraints.expand(
                                            height: 150,
                                            width: constraints.maxWidth),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey,
                                        ),
                                        onSelected: (String value) {
                                          // controller.text = value;
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return RegistrationDataClass()
                                              .univer[university]["academics"]
                                              .keys
                                              .map<PopupMenuItem<String>>(
                                                  (String value) {
                                            return PopupMenuItem(
                                                value: value,
                                                child: StatefulBuilder(
                                                  builder: (context, state) {
                                                    return Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            state(() {
                                                              if (academics
                                                                  .contains(
                                                                      value)) {
                                                                academics
                                                                    .remove(
                                                                        value);
                                                              } else if (academics
                                                                      .length <
                                                                  RegistrationDataClass()
                                                                              .univer[
                                                                          university]
                                                                      [
                                                                      "length"]) {
                                                                academics
                                                                    .add(value);
                                                              }
                                                            });

                                                            setState(() {

                                                            });
                                                          },
                                                          child: Container(
                                                            width: 24,
                                                            height: 24,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                border: Border.all(
                                                                    width: 1.5,
                                                                    color: const Color(
                                                                        0xff355CCA))),
                                                            child: academics
                                                                    .contains(
                                                                        value)
                                                                ? const Icon(
                                                                    Icons.check,
                                                                    size: 18,
                                                                    color: Color(
                                                                        0xff355CCA))
                                                                : null,
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            child: Text(value))
                                                      ],
                                                    );
                                                  },
                                                ));
                                          }).toList();
                                        },
                                      ),
                                    ),
                                  );
                                }))),

                        Visibility(
                            visible: university.toString().contains("Pennsylvania"),
                            child: Column(
                              children: [
                                DropDownField(
                                    value: pensylvaniaFaculty,
                                    validator: (val) {
                                      if(val == null) {
                                        return "Choose your dream college, please";
                                      }

                                      return null;
                                    },
                                    onChange: (val) {
                                      setState(() {
                                        pensylvaniaSecond = null;
                                        pensylvaniaThird = null;
                                        pensylvaniaFourth = null;
                                        pensylvaniaFaculty = val;
                                      });
                                    },
                                    context: context,
                                    initialValue: "Academic Program",
                                    items: RegistrationDataClass().univer["University of Pennsylvania"].keys.toList(),
                                ),

                                RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null ? !RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty].containsKey("hasMany") && pensylvaniaFaculty != "School of Nursing" ? DropDownField(
                                  value: pensylvaniaSecond,
                                  validator: (val) {
                                    if(val == null) {
                                      return "Choose your dream college, please";
                                    }

                                    return null;
                                  },
                                  onChange: (val) {
                                    setState(() {
                                      pensylvaniaThird = null;
                                      pensylvaniaFourth = null;
                                      debugPrint(pensylvaniaFaculty.toString());
                                      debugPrint(RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty]["academics"].toString());
                                      pensylvaniaSecond = val;
                                    });
                                  },
                                  context: context,
                                  initialValue: "Academic Program",
                                  items: RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null && !RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty].containsKey("hasMany") && pensylvaniaFaculty != "School of Nursing" ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty]["academics"].keys.toList(): [],
                                ) : Container(): Container(),

                                RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty].containsKey("hasMany") && pensylvaniaThird != "School of Nursing" ? DropDownField(
                                  value: pensylvaniaThird,
                                  validator: (val) {
                                    if(val == null) {
                                      return "Choose your dream college, please";
                                    }

                                    return null;
                                  },
                                  onChange: (val) {
                                    setState(() {
                                      pensylvaniaThird = val;
                                    });
                                  },
                                  context: context,
                                  initialValue: "Academic Program",
                                  items: RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty] != null ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaFaculty]["academicLinks"].toList(): []
                                ): Container(): Container(),
                                //
                                pensylvaniaThird != null && pensylvaniaThird != "School of Nursing" ? DropDownField(
                                  value: pensylvaniaFourth,
                                  validator: (val) {
                                    if(val == null) {
                                      return "Choose your dream college, please";
                                    }

                                    return null;
                                  },
                                  onChange: (val) {
                                    setState(() {
                                      pensylvaniaFourth = val;
                                    });
                                  },
                                  context: context,
                                  initialValue: "Academic Program",
                                  items: pensylvaniaThird.toString() != "null" && pensylvaniaThird != "School of Nursing" ? RegistrationDataClass().univer["University of Pennsylvania"][pensylvaniaThird]["academics"].keys.toList(): []
                                ): Container()
                              ],
                            )),

                        Visibility(
                          visible: grade == "10th grade or above",
                          child: DropDownField(
                              value: school,
                              validator: (value) {
                                if (value != null) {
                                  return null;
                                }

                                return "Choose your school please";
                              },
                              onChange: (value) {
                                setState(() {
                                  school = value;

                                  if (value == "Other") {
                                    showFilter = true;
                                  } else {
                                    showFilter = false;
                                  }
                                });
                              },
                              context: context,
                              initialValue: "School",
                              items: Universities().schools),
                        ),

                        Visibility(
                            visible: showFilter,
                            child: InputField(
                              controller: otherSchool,
                              initialValue: "School",
                              context: context,
                              validator: (value) {
                                if (value.isNullOrBlank && school == "Other") {
                                  return "Fill your school, please";
                                }

                                return null;
                              },
                              isPassword: false,
                              textInputType: TextInputType.text,
                            )),

                        Button(
                            text: "Next",
                            onPressed: () async {
                              if(_formKey.currentState!.validate()) {
                                if(university.toString().contains("Columbia")) {
                                  await httpClient.newRegister(name.text, passwordController.text, phoneValue, email.text, age.text, country, grade == "10th grade or above"?  10 : 9, university, columbiaFaculty, getValueAt(academics, 0), getValueAt(academics, 1), null, school ?? otherSchool.text);
                                } else if (university.toString().contains("Pennsylvania")) {
                                  await httpClient.newRegister(name.text, passwordController.text, phoneValue, email.text, age.text, country,  grade == "10th grade or above"?  10 : 9, university, pensylvaniaFaculty, pensylvaniaSecond, pensylvaniaThird, pensylvaniaFourth, school ?? otherSchool.text);
                                } else {
                                  await httpClient.newRegister(name.text, passwordController.text, phoneValue, email.text, age.text, country,  grade == "10th grade or above"?  10 : 9, university, academics[0], getValueAt(academics, 1), getValueAt(academics, 2), null, school ?? otherSchool.text);
                                }

                                SharedPreferences pref = await SharedPreferences.getInstance();

                                pref.setBool("show", true);

                                // if(context.mounted) {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => VerifyEmail(
                                //             email: email.text,
                                //           )));
                                // }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyEmail(
                                          email: email.text,
                                        )));
                              }
                            },
                            height: 38,
                            width: double.infinity)
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  Future<void> _dialogBuilder() {
    DateTime choosenDate =
        DateTime(2008, DateTime.now().month, DateTime.now().day);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return AlertDialog(
                backgroundColor: const Color(0xff121623),
                content: SizedBox(
                  width: 100,
                  height: 220,
                  child: TableCalendar(
                    availableGestures: AvailableGestures.none,
                    daysOfWeekHeight: 30,
                    rowHeight: 30,
                    selectedDayPredicate: (day) => isSameDay(day, choosenDate),
                    onDaySelected: (selectedDay, focusedDay) {
                      state(() {
                        DateFormat monthFormat = DateFormat.MMMM();
                        DateTime monthr = monthFormat.parse(month);
                        choosenDate = selectedDay;
                        choosenDate = DateTime(
                            choosenDate.year, monthr.month, choosenDate.day);
                        age.text = DateFormat("MM/dd/yyyy")
                            .format(choosenDate)
                            .toString();
                      });
                    },
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, day, focusedDay) {
                        return Container(
                          height: 38,
                          width: 38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Text(
                            "${day.day}",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                        );
                      },
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xffD2DAFF)),
                      weekendStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xffD2DAFF)),
                      dowTextFormatter: (date, locale) =>
                          DateFormat.E(locale).format(date)[0],
                    ),
                    firstDay: DateTime.utc(1946, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: choosenDate,
                    headerVisible: false,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                    ),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      defaultTextStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      todayDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      holidayTextStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      weekendTextStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(9, 13, 0, 0),
                        child: DefaultTextStyle(
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white),
                          child: Text(
                            month,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: PopupMenuButton(
                          onSelected: (val) {
                            state(() {
                              month = val;

                              DateFormat monthFormat = DateFormat.MMMM();
                              DateTime monthr = monthFormat.parse(month);

                              int monthIndex = monthr.month;
                              choosenDate = DateTime(choosenDate.year,
                                  monthIndex, choosenDate.day);
                            });
                          },
                          icon: const ImageIcon(
                            AssetImage("assets/Vectorchevorn.png"),
                            size: 12,
                            color: Color(0xffBFBFBF),
                          ),
                          offset: const Offset(0, 0),
                          color: const Color(0xff3A3D4C),
                          itemBuilder: (BuildContext context) {
                            return months
                                .map<PopupMenuItem<String>>((String value) {
                              return PopupMenuItem(
                                  height: 25,
                                  value: value.toString(),
                                  child: Text(
                                    value.toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ));
                            }).toList();
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 9, 0),
                        child: DefaultTextStyle(
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white),
                          child: Text(
                            year == "2010"
                                ? (int.parse(year) - 2).toString()
                                : year,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: PopupMenuButton(
                          constraints: const BoxConstraints.expand(
                              width: 68, height: 150),
                          onSelected: (val) {
                            state(() {
                              year = val;
                              choosenDate = DateTime(int.parse(year),
                                  choosenDate.month, choosenDate.day);

                              age.text = DateFormat("MM/dd/yyyy")
                                  .format(choosenDate)
                                  .toString();
                              setState(() {});
                            });
                          },
                          icon: const ImageIcon(
                            AssetImage("assets/Vectorchevorn.png"),
                            size: 12,
                            color: Color(0xffBFBFBF),
                          ),
                          offset: const Offset(0, 0),
                          color: const Color(0xff3A3D4C),
                          itemBuilder: (BuildContext context) {
                            return years
                                .map<PopupMenuItem<String>>((String value) {
                              return PopupMenuItem(
                                  height: 25,
                                  value: (int.parse(value)).toString(),
                                  child: Text(
                                    value.toString(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        color: Colors.white),
                                  ));
                            }).toList();
                          },
                        ),
                      ),
                    ]));
          });
        });
  }
}

Container buildQuestion(String question, bool isRequired) {
  return Container(
    margin: const EdgeInsets.fromLTRB(19, 20, 0, 0),
    alignment: Alignment.centerLeft,
    child: isRequired
        ? RichText(
            text: TextSpan(
                text: question,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                      text: " *",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.white))
                ]),
          )
        : Text(question,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.white)),
  );
}

Image buildLogoIcon() {
  return Image.asset(
    "assets/logo.png",
  );
}
