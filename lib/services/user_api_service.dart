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

  // POST
  Future<UserModel> createUser(UserModel user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      print(response.body);
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  // PUT
  Future<UserModel?> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/${user.id}"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );

    try {
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
