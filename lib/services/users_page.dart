import 'package:flutter/material.dart';
import 'package:weatherappg14/models/user_model.dart';
import 'package:weatherappg14/models/user_response.dart';
import 'package:weatherappg14/services/dio_client.dart';
import 'package:weatherappg14/services/user_api_retrofit.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final userApiRetrofit = UserApiRetrofit(DioClient.getDio());

          await userApiRetrofit.createUser(
            UserResponse(
              createdAt: DateTime.now(),
              name: "Galloegsd",
              avatar:
                  "https://images.unsplash.com/photo-1754473260215-51f8183c137d?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          );

          await userApiRetrofit.getUsers().then((value) {
            value.forEach((e) {
              print(e.name);
            });
          });

          await userApiRetrofit.updateUser(
            "16",
            UserResponse(
              createdAt: DateTime.now(),
              name: "Mengoaaaaaaaaaaaaa",
              avatar:
                  "https://images.unsplash.com/photo-1754473260215-51f8183c137d?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          );
          // await userApiRetrofit.deleteUser("21");
          // await userApiRetrofit.deleteUser("22");
          await userApiRetrofit.getUsers().then((value) {
            value.forEach((e) {
              print(e.name);
            });
          });
          print("------------------------------------");

          await userApiRetrofit.getUserById("2").then((value) {
            print(value.name);
          });
          // UserModel _exampleUser = UserModel(
          //   createdAt: DateTime.now(),
          //   name: "Elias Sanchez",
          //   avatar:
          //       "https://images.unsplash.com/photo-1754473260215-51f8183c137d?q=80&w=627&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          // );
          // userApiService.createUser(_exampleUser);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(userList[index].name),
                subtitle: Text(userList[index].createdAt.toString()),
                leading: Image.network(
                  userList[index].avatar,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        UserModel userUpdated = UserModel(
                          createdAt: userList[index].createdAt,
                          name: "Nombre actualizado",
                          avatar: userList[index].avatar,
                          id: userList[index].id,
                        );
                        await userApiService.updateUser(userUpdated);
                        getUsers();
                        setState(() {});
                      },
                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                    ),
                    IconButton(
                      onPressed: () {
                        userApiService.deteleUser(
                          userList[index].id.toString(),
                        );
                        getUsers();

                        setState(() {});
                      },
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
