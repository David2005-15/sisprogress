import 'dart:collection';

import 'package:dio/dio.dart';

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
} 