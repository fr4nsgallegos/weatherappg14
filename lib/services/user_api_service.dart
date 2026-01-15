import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg14/models/user_model.dart';

class UserApiService {
  final String baseUrl = "https://68cedf266dc3f35077803c79.mockapi.io/api/v1/";

  // GET
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users"));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      print(data);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar los usuarios");
    }
  }
}
