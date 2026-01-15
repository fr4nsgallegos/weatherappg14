import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weatherappg14/models/user_response.dart';

part 'user_api_retrofit.g.dart';

@RestApi(baseUrl: "https://68cedf266dc3f35077803c79.mockapi.io/api/v1/")
abstract class UserApiRetrofit {
  factory UserApiRetrofit(Dio dio, {String baseUrl}) = _UserApiRetrofit;

  // GET
  @GET("/users")
  Future<List<UserResponse>> getUsers();

  @GET("/users/{id}")
  Future<UserResponse> getUserById(@Path("id") String id);

  // POST
  @POST("/users")
  Future<UserResponse> createUser(@Body() UserResponse user);

  // PUT
  @PUT("users/{id}")
  Future<UserResponse> updateUser(
    @Path("id") String id,
    @Body() UserResponse user,
  );

  // DELETE
  @DELETE("users/{id}")
  Future<void> deleteUser(@Path("id") String id);
}
