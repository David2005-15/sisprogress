import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/registration_data_grade10.dart';
import 'package:sis_progress/data%20class/registration_data_grade9.dart';

class Client {
  final Dio dio = Dio();

  Client._privateConstructor();

  static final Client _instance = Client._privateConstructor();

  factory Client() {
    return _instance;
  }

  Future removeSecondaryMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    dio.delete("https://sisprogress.online/addEmail/delete");
  }

  Future<List<dynamic>> getAllUniversities() async {
    Response response = await dio.get(
        'https://sisprogress.online/get/AllUniversities');

    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(
        response.data);

    List<String> unis = values.map((e) => e["name"].toString()).toList();


    return unis;
  }

  Future sendPasswordLink(String email) async {
    var body = {
      "email": email
    };

    await dio.post('https://sisprogress.online/resetPassword', data: body);
  }

  Future<Map<String, dynamic>> getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    Response response = await dio.get("https://sisprogress.online/dashboard");

    return response.data;
  }

  Future sendEssay(String description, int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var body = {
      "taskId": taskId,
      "feedback": description
    };


    await dio.post('https://sisprogress.online/add/feedback', data: body);
  }

  Future<List<dynamic>> getAllFeedbacks(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};


    Response response = await dio.get('https://sisprogress.online/add/feedback',
        queryParameters: {"taskId": taskId});

    return response.data;
  }

  Future<dynamic> getTimePoints(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};


    Response response = await dio.get(
        'https://sisprogress.online/getTasks/description',
        queryParameters: {"id": taskId});

    return response.data;
  }

  Future<List<dynamic>> getRecommendations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var response = await dio.get("https://sisprogress.online/getTasks/Category1");

    return response.data["recommendation"];
  }

  Future<Map<String, dynamic>> getAllFaculties() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var response = await dio.get("https://sisprogress.online/getTasks/Category1");

    return response.data["groupedTasks"];
  }

  Future doneSubtask(int userId, bool status) async {
    var body = {
      "subTaskId": userId,
      "status": status
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    await dio.patch('https://sisprogress.online/change/subTaskStatus', data: body);
  }

  Future<List<List<dynamic>>> getPoints() async {
    Response response = await dio.get(
        'https://sisprogress.online/get/AllUniversities');

    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(
        response.data);
    // print(values);
    List<List<dynamic>> value = [];

    List<dynamic> dreamPoint = values.map((e) => e["dreamPointMin"]).toList();
    List<dynamic> targetPoint = values.map((e) => e["targetPointMin"]).toList();
    List<dynamic> safetyPoint = values.map((e) => e["sefetyPointMin"]).toList();

    value.add(dreamPoint);
    value.add(targetPoint);
    value.add(safetyPoint);

    return value;
  }

  Future<List<dynamic>> getAllTaskAndFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var allTasks = await dio.get("https://sisprogress.online/getTasks/my");

    return allTasks.data["newTasks"];
  }

  Future sendTask(int taskId, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var body = {
      "id": taskId,
      "description": description
    };

    await dio.patch("https://sisprogress.online/change/taskDescription", data: body);
  }

  Future removeTask(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    await dio.delete("https://sisprogress.online/getTasks/delete",
        queryParameters: {"taskId": taskId});
  }

  Future<List<dynamic>> getAllTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var allTasks = await dio.get("https://sisprogress.online/getTasks/rest");

    return allTasks.data["item"];
  }

  Future updateUniversityAndAcademic(Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    await dio.patch("https://sisprogress.online/settings/", data: value);
  }

  Future<List<dynamic>> getCalendarEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var calendarTasks = await dio.get(
        "https://sisprogress.online/getTasks/inCalendar");

    return calendarTasks.data["myTasks"];
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var credentials = {
      "email": email,
      "password": password
    };

    var token = await dio.post(
        "https://sisprogress.online/user/login", data: credentials);

    prefs.setString("token", token.data["token"]);

    return token.data;
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var isLoggedData = {
      "token": prefs.getString("token")
    };

    var userData = await dio.post(
        "https://sisprogress.online/user/isLogined", data: isLoggedData);
    prefs.setString("user id", userData.data["id"].toString());
    prefs.setString("university", userData.data["university"].toString());

    return userData.data;
  }

  Future addTask(int taskId, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = {
      "taskId": taskId,
      "startDate": date,
    };

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    await dio.post('https://sisprogress.online/calendar/add', data: body);
  }

  Future sendUpdateEmail(String email, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var body = {
      "email": email,
      "role": type
    };

    var response = await dio.post('https://sisprogress.online/addEmail/update', data: body);

    return response.data;
  }


  Future sendCode(String email, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers =
    {"Authorization": "Bearer ${prefs.getString("token")}"};

    var body = {
      "email": email,
      "code": code
    };

    var response = await dio.patch(
        "https://sisprogress.online/addEmail/update", data: body);

    return response.data;
  }

  Future registerForGrade9(RegistrationGrade9 data) async {
    var body = {
      "fullName": data.fullName,
      "email": data.email,
      "password": data.password,
      "phone": data.phone,
      "age": data.age,
      "country": data.country,
      "grade": 9,
      "university": data.university,
      "study": data.study,
      "academicProgram": data.proffession,
      "term": data.term,
      "planType": data.addmision,
      "aid": data.aid == "Yes" ? true : false,
      "legacy": data.legacy == "Yes" ? true : false,
      "area": data.workExp,
    };

    var response = await dio.post("https://sisprogress.online/register", data: body);

    return response.data;
  }

  Future registerForGrade10(RegistrationGrade10 data) async {
    var activity = data.outActivity!.map((act) {
      bool isSingle = !act.contains("(");

      if(isSingle) {
        return "$act (1)";
      }

      return act;
    }).toList();

    debugPrint(activity.toString());

    var body = {
      "fullName": data.fullName,
      "email": data.email,
      "password": data.password,
      "phone": data.phone,
      "age": data.age,
      "country": data.country,
      "grade": 10,
      "university": data.university,
      "academicProgram": data.profession,
      "study": data.study,
      "term": data.term,
      "planType": data.addmision,
      "aid": data.aid == "Yes" ? true : false,
      "legacy": data.legacy == "Yes" ? true : false,
      "activityName": activity.toString(),
      "applyingFrom": false,
      "testSubmit": false,
      "recentSchool": data.highSchool,
      "report": false,
      "hadtests": false,
      "workExperience": data.essayWorkExp,
      "addinfo": true,
      "moreInfo": data.details
    };

    // print(body);

    var response = await dio.post("https://sisprogress.online/register", data: body);

    return response.data;
  }
  
  Future<dynamic> checkIfEmailExists(String mail) async {
    var response = await dio.get("https://sisprogress.online/addEmail/isFree", queryParameters: {"email": mail});

    return response.data;
  }

} 