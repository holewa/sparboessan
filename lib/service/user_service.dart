import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pengastigen/constans/endpoint_constants.dart';

class UserService {
  final String localHost = EndpointConstants.LOCALHOST;
  final String usersEndpoint = EndpointConstants.USERS_ENDPOINT;

  Future<http.Response> fetchUsers() async {
    var url = Uri.parse('$localHost$usersEndpoint');
    return await http.get(url);
  }

  Future<http.Response> toggleFeature(int userId) async {
    var url = Uri.parse('$localHost$usersEndpoint/$userId');
    return await http.patch(url);
  }

  Future<http.Response> changeAvatar(String ?userId, String avatar) async {
    var url = Uri.parse('$localHost$usersEndpoint/$userId');

    return await http.put(
      url,
      body: jsonEncode({'avatar': avatar}),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
