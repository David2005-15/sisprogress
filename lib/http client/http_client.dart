import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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

  Future removeImage() async {
    var prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    await dio.delete("https://sisprogress.online/uploadImage/delete");
  }

  Future addReason(String reason, bool isDelete) async {
    var prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"reasone": reason, "type": isDelete ? "Delete" : "Deactivate"};

    await dio.post("https://sisprogress.online/user/deletionReasone",
        data: body);
  }

  Future<dynamic> deactivateAccount(String password) async {
    var prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"password": password};

    var response = await dio.patch("https://sisprogress.online/user/deactivate",
        data: body, options: Options(
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    return response.data;
  }

  Future<dynamic> removeAccount(String password) async {
    var prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"password": password};

    var response = await dio
        .patch("https://sisprogress.online/user/deleteAccount", data: body,
            options: Options(
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    return response.data;
  }

  Future<dynamic> getNotifications() async {
    var prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var response = await dio.get("https://sisprogress.online/notification/get");

    return response.data;
  }

  Future<dynamic> readNotification(int id) async {
    var prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"id": id};

    await dio.patch("https://sisprogress.online/notification/read", data: body);
  }

  Future<dynamic> changePassword(
      String currentPassword, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"currentPassword": currentPassword, "password": password};

    try {
      var response = await dio
          .patch("https://sisprogress.online/settings/password", data: body);

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      return "error";
    }
  }

  Future removeSecondaryMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    dio.delete("https://sisprogress.online/addEmail/delete");
  }

  Future newRegister(
      String fullName,
      String password,
      String phone,
      String email,
      String age,
      String country,
      int grade,
      String university,
      String academic1,
      String? academic2,
      String? academic3,
      String? academic4,
      String recentSchool) async {
    var body = {
      "fullName": fullName,
      "password": password,
      "email": email,
      "phone": phone,
      "age": age,
      "country": country,
      "grade": grade,
      "university": university,
      "academicProgramFirst": academic1,
      "academicProgramSecond": academic2,
      "academicProgramThird": academic3,
      'academicProgramFourth': academic4,
      "recentSchool": recentSchool
    };

    await dio.post("https://sisprogress.online/newRegister/", data: body);
  }

  Future sendVerificationLink(String email) async {
    var body = {"email": email};

    await dio.post("https://sisprogress.online/sendMail", data: body);
  }

  Future<dynamic> getAllActivities() async {
    var result =
        await dio.get("https://sisprogress.online/getTasks/activities");

    return await result.data;
  }

  Future updateImage(XFile file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fileName = file.path.split('/').last;

    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    await dio.patch("https://sisprogress.online/uploadImage",
        data: formData,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
        ));
  }

  Future<dynamic> getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    Response response = await dio.get(
      "https://sisprogress.online/user/get",
    );

    return response.data["img"];
  }

  Future<List<dynamic>> getAllUniversities() async {
    Response response =
        await dio.get('https://sisprogress.online/get/AllUniversities');

    List<Map<String, dynamic>> values =
        List<Map<String, dynamic>>.from(response.data);

    List<String> unis = values.map((e) => e["name"].toString()).toList();

    return unis;
  }

  Future sendPasswordLink(String email) async {
    var body = {"email": email};

    await dio.post('https://sisprogress.online/resetPassword', data: body);
  }

  Future<Map<String, dynamic>> getDashboardData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    Response response = await dio.get("https://sisprogress.online/dashboard");

    return response.data;
  }

  Future sendEssay(String description, int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"taskId": taskId, "feedback": description};

    await dio.post('https://sisprogress.online/add/feedback', data: body);
  }

  Future<List<dynamic>> getAllFeedbacks(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    Response response = await dio.get('https://sisprogress.online/add/feedback',
        queryParameters: {"taskId": taskId});

    return response.data;
  }

  Future<dynamic> getTimePoints(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    Response response = await dio.get(
        'https://sisprogress.online/getTasks/description',
        queryParameters: {"id": taskId});

    return response.data;
  }

  Future<List<dynamic>> getRecommendations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var response =
        await dio.get("https://sisprogress.online/getTasks/Category1");

    return response.data["recommendation"];
  }

  Future<Map<String, dynamic>> getAllFaculties() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var response =
        await dio.get("https://sisprogress.online/getTasks/Category1");

    return response.data["groupedTasks"];
  }

  Future doneSubtask(int userId, bool status) async {
    var body = {"subTaskId": userId, "status": status};

    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    await dio.patch('https://sisprogress.online/change/subTaskStatus',
        data: body);
  }

  Future<List<List<dynamic>>> getPoints() async {
    Response response =
        await dio.get('https://sisprogress.online/get/AllUniversities');

    List<Map<String, dynamic>> values =
        List<Map<String, dynamic>>.from(response.data);

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

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var allTasks = await dio.get("https://sisprogress.online/getTasks/my");

    return allTasks.data["newTasks"];
  }

  Future sendTask(int taskId, String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"id": taskId, "description": description};

    await dio.patch("https://sisprogress.online/change/taskDescription",
        data: body);
  }

  Future removeTask(int taskId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    await dio.delete("https://sisprogress.online/getTasks/delete",
        queryParameters: {"taskId": taskId});
  }

  Future<List<dynamic>> getAllTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var allTasks = await dio.get("https://sisprogress.online/getTasks/rest");

    return allTasks.data["item"];
  }

  Future updateUniversityAndAcademic(Map<String, dynamic> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    await dio.patch("https://sisprogress.online/settings", data: value);
  }

  Future<List<dynamic>> getCalendarEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var calendarTasks =
        await dio.get("https://sisprogress.online/getTasks/inCalendar");

    return calendarTasks.data["myTasks"];
  }

  Future<Map<String, dynamic>> updateUserInfo(
      {required String term,
      required String planType,
      required bool aid,
      required bool legacy,
      required String area,
      required bool applying,
      required String testSubmit,
      required bool achievements,
      required bool admission,
      required List<String> activityName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    // body{
    //   termOption: STRING,
    // planType: STRING,
    // aid: BOOLEAN,
    // legacy: BOOLEAN,
    // area: STRING,
    // applyingFrom: BOOLEAN,
    // testSubmit: STRING,
    // achievements: BOOLEAN,
    // admission: BOOLEAN,
    // activityName: Array,
    // }

    var body = {
      "termOption": term,
      "planType": planType,
      "aid": aid,
      "legacy": legacy,
      "area": area,
      "applyingFrom": applying,
      "testSubmit": testSubmit,
      "achievements": achievements,
      "admission": admission,
      "activityName": activityName
    };

    var response = await dio.patch("https://sisprogress.online/newRegister/", data: body);

    return response.data;
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var credentials = {"email": email, "password": password};

    var token = await dio.post("https://sisprogress.online/user/login",
        data: credentials);

    prefs.setString("token", token.data["token"]);

    return token.data;
  }

  Future changeActivity(List<String> activities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    dio.patch("https://sisprogress.online/settings/activities",
        data: {"newActivityName": activities});
  }

  Future<dynamic> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var isLoggedData = {"token": prefs.getString("token")};

    var userData = await dio.post("https://sisprogress.online/user/isLogined",
        data: isLoggedData, options: Options(
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    if (userData.statusCode == 200) {
      prefs.setString("user id", userData.data["id"].toString());
      prefs.setString("university", userData.data["university"].toString());
    }

    return userData.data;
  }

  Future addTask(int taskId, String date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var body = {
      "taskId": taskId,
      "startDate": date,
    };

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    await dio.post('https://sisprogress.online/calendar/add', data: body);
  }

  Future sendUpdateEmail(String email, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"email": email, "role": type};

    var response = await dio.post('https://sisprogress.online/addEmail/update',
        data: body);

    return response.data;
  }

  Future sendCode(String email, String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    dio.options.headers = {
      "Authorization": "Bearer ${prefs.getString("token")}"
    };

    var body = {"email": email, "code": code};

    var response = await dio.patch("https://sisprogress.online/addEmail/update",
        data: body);

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
      "academicProgramFirst": data.firstAcademic,
      "academicProgramSecond": data.secondAcademic,
      "academicProgramThird": data.thirdAcademic,
      "academicProgramFourth": data.fourthAcademic
    };

    var response =
        await dio.post("https://sisprogress.online/register", data: body);

    return response.data;
  }

  Future registerForGrade10(RegistrationGrade10 data) async {
    var activity = data.outActivity!.map((act) {
      act = act.replaceAll("-", " ");
      bool isSingle = !act.contains("(");

      if (isSingle) {
        return "$act (1)";
      }

      return act;
    }).toList();

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
      "moreInfo": data.details,
      "academicProgramFirst": data.firstAcademic,
      "academicProgramSecond": data.secondAcademic,
      "academicProgramThird": data.thirdAcademic,
      "academicProgramFourth": data.fourthAcademic
    };

    var response =
        await dio.post("https://sisprogress.online/register", data: body);

    return response.data;
  }

  Future<dynamic> checkIfEmailExists(String mail) async {
    var response = await dio.get("https://sisprogress.online/addEmail/isFree",
        queryParameters: {"email": mail}, options: Options(
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    return response.data;
  }
}
