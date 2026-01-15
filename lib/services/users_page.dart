import 'package:flutter/material.dart';
import 'package:weatherappg14/models/user_model.dart';
import 'package:weatherappg14/services/user_api_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  UserApiService userApiService = UserApiService();
  List<UserModel> userList = [];

  Future<void> getUsers() async {
    userList = await userApiService.getUsers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(child: ListTile(title: Text(userList[index].name)));
          },
        ),
      ),
    );
  }
}
