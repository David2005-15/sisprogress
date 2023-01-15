import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Client {
  final Dio dio = Dio();

  Future<List<String>> getAllUniversities() async {
    Response response = await dio.get('http://164.90.224.111/get/AllUniversities');

    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(response.data);

    List<String> unis = values.map((e) => e["name"].toString()).toList();

    Map<String, List<int>> returnValue = {};

    return unis;
  }

  Future<List<List<dynamic>>> getPoints() async {
    Response response = await dio.get('http://164.90.224.111/get/AllUniversities');

    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(response.data);
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

    var user_id = prefs.getString("user id");

    var allTasks = await dio.get("http://164.90.224.111/getTasks/my?id=$user_id");

    return allTasks.data["tasks"];
  }

  Future<List<dynamic>> getCalendarEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString("user id");

    var calendarTasks = await dio.get("http://164.90.224.111/getTasks/inCalendar?id=$userId");
    print(calendarTasks.data["task"]);

    return calendarTasks.data["task"];
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var credentials = {
      "email": email,
      "password": password
    };

    var token = await dio.post("http://164.90.224.111/user/login", data: credentials);

    prefs.setString("token", token.data["token"]);

    return token.data;
  }

  Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var isLoggedData = {
      "token": prefs.getString("token")
    };

    var userData = await dio.post("http://164.90.224.111/user/isLogined", data: isLoggedData);
    prefs.setString("user id", userData.data["id"].toString());
    prefs.setString("university", userData.data["university"].toString());

    print(prefs.getString("user id"));


    return userData.data;
  }

  Future addTask(int taskId, String date, String statusOfTask, String timePoints) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString("user id");

    var body = {
      "taskId": taskId,
      "DateOfAddTask": date,
      "statusOfTask": statusOfTask,
      "timePoints": timePoints,
      "userId": userId
    };

    var response = await dio.post('http://164.90.224.111/calendar/add', data: body);

    if(response.statusCode == 200) {
      print("Hello");
    }
  }

} 