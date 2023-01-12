import 'package:dio/dio.dart';

class Client {
  final Dio dio = Dio();

  Future<List<String>> getAllUniversities() async {
    Response response = await dio.get('http://164.90.224.111/get/AllUniversities');

    List<Map<String, dynamic>> values = List<Map<String, dynamic>>.from(response.data);

    List<String> unis = values.map((e) => e["name"].toString()).toList();

    return unis;
  }
} 