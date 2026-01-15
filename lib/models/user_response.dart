import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  String? id;
  DateTime createdAt;
  String name;
  String avatar;

  UserResponse({
    required this.createdAt,
    required this.name,
    required this.avatar,
    this.id,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
