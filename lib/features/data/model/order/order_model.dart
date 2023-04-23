import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class ListOrderResponse {
  bool? status;
  String? message;
  List<OrderModel>? data;

  ListOrderResponse({this.status, this.message, this.data});

  factory ListOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$ListOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListOrderResponseToJson(this);
}

@JsonSerializable()
class OrderResponse {
  bool? status;
  String? message;
  OrderModel? data;

  OrderResponse({this.status, this.message, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}

@JsonSerializable()
class OrderModel {
  final int? id;
  @JsonKey(name: 'user_id')
  final String? userId;
  final String? address;
  final int? status;
  final double? stats;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'update_at')
  final String? updatedAt;
  final User? user;
  @JsonKey(name: 'rescue_unit')
  final RescueUnit? rescueUnit;

  OrderModel({
    this.id,
    this.userId,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.rescueUnit,
    this.stats,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

@JsonSerializable()
class User {
  String? username;
  String? email;
  String? phone;
  String? password;
  @JsonKey(name: 'full_name')
  String? fullName;
  int? age;
  String? createdAt;
  String? updatedAt;
  Role? role;

  User(
      {this.username,
      this.email,
      this.phone,
      this.password,
      this.fullName,
      this.age,
      this.createdAt,
      this.updatedAt,
      this.role});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Role {
  int? id;
  Role({this.id});
  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}

@JsonSerializable()
class RescueUnit {
  final String? username;
  final String? email;
  final String? phone;
  final String? password;
  final double? lat;
  final double? lng;
  final String? name;
  final int? age;
  final String? createdAt;
  final String? updatedAt;
  final Role? role;

  RescueUnit(
      {this.updatedAt,
      this.createdAt,
      this.username,
      this.email,
      this.phone,
      this.password,
      this.lat,
      this.lng,
      this.name,
      this.age,
      this.role});

  factory RescueUnit.fromJson(Map<String, dynamic> json) =>
      _$RescueUnitFromJson(json);

  Map<String, dynamic> toJson() => _$RescueUnitToJson(this);
}
