import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis_progress/data%20class/registration_data_grade10.dart';
import 'package:sis_progress/data%20class/registration_data_grade9.dart';

class Client {
  final Dio dio = Dio();

  Future<List<String>> getAllUniversities() async {
    Response response = await dio.get('http://164.90.224.111/get/AllUniversities');

    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(response.data);

    List<String> unis = values.map((e) => e["name"].toString()).toList();

    Map<String, List<int>> returnValue = {};

    return unis;
  }

  Future<Map<String, dynamic>> getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    Response response = await dio.get("http://164.90.224.111/dashboard");
    print(await response.data);
    return response.data;
  }

  Future sendEssay(String description, int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var body = {
      "taskId": taskId,
      "feedback": description
    };

    print(body);

    Response response = await dio.post('http://164.90.224.111/add/feedback', data: body);
    print(response.data);
  }

  Future<List<dynamic>> getAllFeedbacks(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};


    Response response = await dio.get('http://164.90.224.111/add/feedback', queryParameters: {"taskId": taskId});
    
    return response.data;
  }

  Future doneSubtask(int userId, bool status) async {
    var body = {
      "subTaskId": userId,
      "status": status
    };

    print(body);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    Response response = await dio.patch('http://164.90.224.111/change/subTaskStatus', data: body);

    print(response.data);
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

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var allTasks = await dio.get("http://164.90.224.111/getTasks/my");

    print(allTasks.data["newTasks"]);

    return allTasks.data["newTasks"];
  }

  Future sendTask(int taskId, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var body = {
      "id": taskId,
      "description": description
    };

    await dio.patch("http://164.90.224.111/change/taskDescription", data: body);
  }

  Future removeTask(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    await dio.delete("http://164.90.224.111/getTasks/delete", queryParameters: {"taskId": taskId});
  }

  Future<List<dynamic>> getAllTasks() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var allTasks = await dio.get("http://164.90.224.111/getTasks/rest");

    print(allTasks.data["newTasks"]);

    return allTasks.data["item"];
  }

  Future updateUniversityAndAcademic(Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var result = await dio.patch("http://164.90.224.111/settings/", data: value);
    print(result);
  } 

  Future<List<dynamic>> getCalendarEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString("user id");
    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var calendarTasks = await dio.get("http://164.90.224.111/getTasks/inCalendar");

    return calendarTasks.data["myTasks"];
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

  Future addTask(int taskId, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = prefs.getString("user id");

    var body = {
      "taskId": taskId,
      "startDate": date,
    };
    

    print(body);

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var response = await dio.post('http://164.90.224.111/calendar/add', data: body);

    if(response.statusCode == 200) {
      print("Hello");
    }
  }

  Future sendUpdateEmail(String email) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();

     dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

     var body = {
      "email": email
     };

     var response = await dio.post('http://164.90.224.111/addEmail', data: body);

     return response.data;
  }


  Future sendCode(String email, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {"Authorization": "Bearer ${prefs.getString("token")}"};

    var body = {
      "email": email, 
      "code": code
    };

    var response = await dio.patch("http://164.90.224.111/addEmail/update", data: body);

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

    print(body);

    var response = await dio.post("http://164.90.224.111/register", data: body);

    return response.data;

  }

  Future registerForGrade10(RegistrationGrade10 data) async {
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
      "activityName": data.outActivity.toString(),
      "applyingFrom": false,
      "testSubmit": false,
      "recentSchool": data.highSchool,
      "report": false,
      "hadtests": false,
      "workExperience": data.essayWorkExp,
      "addinfo": true,
      "moreInfo": data.details
    };

    print(body);

    var response = await dio.post("http://164.90.224.111/register", data: body);

    print(response);
  }

} 