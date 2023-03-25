import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderCreateRequest {
  String? address;
  String? note;

  OrderCreateRequest({this.address, this.note});

  factory OrderCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestToJson(this);
}
