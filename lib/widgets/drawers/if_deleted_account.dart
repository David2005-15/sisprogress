import 'package:sis_progress/http%20client/http_client.dart';

Future<bool> isAccountValid(Client httpClient) async {
  var result = await httpClient.getUserData();

  return result.toString() == "not found";
}