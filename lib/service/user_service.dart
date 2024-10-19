import 'package:http/http.dart' as http;
import 'package:pengastigen/constans/endpoint_constants.dart';

class UserService {
  var localHost = EndpointConstants.LOCALHOST;
  var usersEndpoint = EndpointConstants.USERS_ENDPOINT;

  Future<http.Response> fetchUsers() async {
    var url = Uri.parse('$localHost$usersEndpoint');
    return await http.get(url);
  }
}
