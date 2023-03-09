import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserResponse {
  final bool status;
  final String message;
  final UserModel data;

  UserResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'username')
  final String? username;
  final String? email;
  final String? phone;
  final String? password;
  @JsonKey(name: 'full_name')
  final String? fullName;
  final String? avatar;
  final String? address;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  final String? token;

  UserModel(
      {this.username,
      this.email,
      this.phone,
      this.password,
      this.fullName,
      this.address,
      this.avatar,
      this.createdAt,
      this.updatedAt,
      this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
